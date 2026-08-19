package com.company.daily.skills;

import com.company.daily.analysis.AnalysisPeriod;
import com.company.daily.analysis.AnalysisPeriodWindow;
import com.company.daily.analysis.AnalysisPeriodWindowService;
import com.company.daily.analysis.AnalysisSourceSnapshotService;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.Instant;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AnalysisSkillService {
  private static final String VERSION_COLUMNS = "id,analysis_period,skill_kind,version_number,status,skill_name,"
      + "description,package_name,checksum,validation_message,runtime_profile,trial_succeeded_at,published_at,created_at";
  private static final String TRIAL_COLUMNS = "t.id,t.analysis_period,t.rule_skill_version_id,t.template_skill_version_id,"
      + "t.period_start,t.period_end,t.status,t.analysis_draft,t.rendered_html,t.error_summary,t.started_at,t.finished_at";
  private final JdbcTemplate jdbcTemplate;
  private final SkillPackageValidator validator;
  private final AnalysisPeriodWindowService windowService;
  private final AnalysisSourceSnapshotService snapshotService;
  private final SkillAnalysisExecutor executor;

  public AnalysisSkillService(
      JdbcTemplate jdbcTemplate,
      SkillPackageValidator validator,
      AnalysisPeriodWindowService windowService,
      AnalysisSourceSnapshotService snapshotService,
      SkillAnalysisExecutor executor) {
    this.jdbcTemplate = jdbcTemplate;
    this.validator = validator;
    this.windowService = windowService;
    this.snapshotService = snapshotService;
    this.executor = executor;
  }

  @Transactional(readOnly = true)
  public List<AnalysisSkillVersion> list(AnalysisPeriod period, AnalysisSkillKind kind) {
    return jdbcTemplate.query("select " + VERSION_COLUMNS + " from analysis_skill_versions where analysis_period=? and skill_kind=? "
        + "order by version_number desc", this::mapVersion, period.name(), kind.name());
  }

  @Transactional(readOnly = true)
  public Optional<AnalysisSkillVersion> published(AnalysisPeriod period, AnalysisSkillKind kind) {
    return jdbcTemplate.query("select " + VERSION_COLUMNS + " from analysis_skill_versions where analysis_period=? and skill_kind=? "
        + "and status='PUBLISHED'", this::mapVersion, period.name(), kind.name()).stream().findFirst();
  }

  @Transactional
  public AnalysisSkillVersion upload(
      AnalysisPeriod period, AnalysisSkillKind kind, String packageName, byte[] packageBytes) {
    SkillPackageValidator.ValidatedSkillPackage value = validator.validate(packageBytes);
    int version = jdbcTemplate.queryForObject("select coalesce(max(version_number), 0) + 1 "
        + "from analysis_skill_versions where analysis_period=? and skill_kind=?", Integer.class,
        period.name(), kind.name());
    long id = jdbcTemplate.queryForObject("insert into analysis_skill_versions(analysis_period,skill_kind,"
        + "version_number,status,skill_name,description,package_name,package_bytes,skill_markdown,checksum,"
        + "validation_message,runtime_profile,manifest_json) values (?,?,?,'DRAFT',?,?,?,?,?,?,?,?,?) returning id",
        Long.class, period.name(), kind.name(), version, value.skillName(), value.description(), packageName,
        packageBytes, value.markdown(), value.checksum(), "校验通过",
        value.manifest() == null ? null : value.manifest().runtimeProfile(),
        value.manifest() == null ? null : manifestJson(value.manifest()));
    return get(id);
  }

  @Transactional(readOnly = true)
  public byte[] download(long id) {
    return jdbcTemplate.queryForObject("select package_bytes from analysis_skill_versions where id=?", byte[].class, id);
  }

  public AnalysisSkillTrial trial(AnalysisPeriod period, LocalDate endDate, long ruleVersionId, long templateVersionId) {
    AnalysisSkillVersion rule = get(ruleVersionId);
    AnalysisSkillVersion template = get(templateVersionId);
    validatePair(period, rule, template);
    AnalysisPeriodWindow window = windowService.resolve(period, endDate);
    String snapshot = snapshotService.build(window);
    long id = jdbcTemplate.queryForObject("insert into analysis_skill_trials(analysis_period,rule_skill_version_id,"
        + "template_skill_version_id,period_start,period_end,status,source_snapshot_json) "
        + "values (?,?,?,?,?,'RUNNING',?) returning id", Long.class,
        period.name(), rule.id(), template.id(), window.startDate(), window.endDate(), snapshot);
    try {
      SkillAnalysisExecutor.SkillExecution execution = executor.execute(rule, template, markdown(rule.id()),
          markdown(template.id()), snapshot, packageBytes(rule.id()), packageBytes(template.id()));
      if ("SUCCEEDED".equals(execution.status())) {
        jdbcTemplate.update("update analysis_skill_versions set trial_succeeded_at=current_timestamp where id in (?,?)",
            ruleVersionId, templateVersionId);
        if (execution.renderedDocument() != null) {
          jdbcTemplate.update("insert into analysis_skill_artifacts(trial_id,artifact_type,file_name,mime_type,checksum,"
              + "content) values (?,'REPORT_DOCX','daily-analysis.docx',?,?,?)", id,
              "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
              checksum(execution.renderedDocument()), execution.renderedDocument());
        }
      }
      jdbcTemplate.update("update analysis_skill_trials set status=?,analysis_draft=?,rendered_html=?,error_summary=?,"
          + "finished_at=current_timestamp where id=?", execution.status(), execution.analysisDraft(),
          execution.renderedHtml(), execution.errorSummary(), id);
    } catch (RuntimeException | Error exception) {
      jdbcTemplate.update("update analysis_skill_trials set status='TRIAL_FAILED',error_summary=?,"
          + "finished_at=current_timestamp where id=?", "试运行执行异常：" + exception.getClass().getSimpleName(), id);
      throw exception;
    }
    return getTrial(id);
  }

  @Transactional
  public void publishPair(AnalysisPeriod period, long ruleVersionId, long templateVersionId) {
    AnalysisSkillVersion rule = get(ruleVersionId);
    AnalysisSkillVersion template = get(templateVersionId);
    validatePair(period, rule, template);
    if (rule.status() == AnalysisSkillStatus.PUBLISHED && template.status() == AnalysisSkillStatus.PUBLISHED) {
      return;
    }
    if (rule.status() != AnalysisSkillStatus.DRAFT || template.status() != AnalysisSkillStatus.DRAFT
        || rule.trialSucceededAt() == null || template.trialSucceededAt() == null) {
      throw new IllegalArgumentException("仅可成对发布试运行成功的规则和模板草稿");
    }
    boolean hasTrial = jdbcTemplate.queryForObject("select count(*) > 0 from analysis_skill_trials where "
        + "analysis_period=? and rule_skill_version_id=? and template_skill_version_id=? and status='SUCCEEDED'",
        Boolean.class, period.name(), ruleVersionId, templateVersionId);
    if (!hasTrial) {
      throw new IllegalArgumentException("该规则与模板必须完成同一次成功试运行");
    }
    jdbcTemplate.update("update analysis_skill_versions set status='HISTORICAL' where analysis_period=? "
        + "and status='PUBLISHED'", period.name());
    jdbcTemplate.update("update analysis_skill_versions set status='PUBLISHED',published_at=current_timestamp "
        + "where id in (?,?)", ruleVersionId, templateVersionId);
  }

  @Transactional(readOnly = true)
  public List<AnalysisSkillTrial> trials(AnalysisPeriod period) {
    return jdbcTemplate.query("select " + TRIAL_COLUMNS + ",exists(select 1 from analysis_skill_artifacts a where a.trial_id=t.id "
        + "and a.artifact_type='REPORT_DOCX') as has_document from analysis_skill_trials t "
        + "where t.analysis_period=? order by t.started_at desc",
        this::mapTrial, period.name());
  }

  @Transactional(readOnly = true)
  public AnalysisSkillVersion get(long id) {
    return jdbcTemplate.queryForObject("select " + VERSION_COLUMNS + " from analysis_skill_versions where id=?",
        this::mapVersion, id);
  }

  @Transactional
  public void delete(long id) {
    AnalysisSkillVersion version = get(id);
    if (version.status() != AnalysisSkillStatus.DRAFT) {
      throw new IllegalArgumentException("仅草稿版本可以删除");
    }
    jdbcTemplate.update("update analysis_runs set rule_skill_version_id=null where rule_skill_version_id=?", id);
    jdbcTemplate.update("update analysis_runs set template_skill_version_id=null where template_skill_version_id=?", id);
    jdbcTemplate.update("delete from analysis_skill_trials where rule_skill_version_id=? or template_skill_version_id=?",
        id, id);
    jdbcTemplate.update("delete from analysis_skill_versions where id=?", id);
  }

  @Transactional(readOnly = true)
  public PublishedSkillPair publishedPair(AnalysisPeriod period) {
    AnalysisSkillVersion rule = published(period, AnalysisSkillKind.RULE)
        .orElseThrow(() -> new IllegalArgumentException("该周期没有已发布的规则 Skill"));
    AnalysisSkillVersion template = published(period, AnalysisSkillKind.TEMPLATE)
        .orElseThrow(() -> new IllegalArgumentException("该周期没有已发布的模板 Skill"));
    return new PublishedSkillPair(rule, template, markdown(rule.id()), markdown(template.id()),
        packageBytes(rule.id()), packageBytes(template.id()));
  }

  @Transactional(readOnly = true)
  public SkillArtifact document(long trialId) {
    return jdbcTemplate.queryForObject("select file_name,mime_type,content from analysis_skill_artifacts "
        + "where trial_id=? and artifact_type='REPORT_DOCX'", (resultSet, row) -> new SkillArtifact(
            resultSet.getString("file_name"), resultSet.getString("mime_type"), resultSet.getBytes("content")), trialId);
  }

  private String markdown(long id) {
    return jdbcTemplate.queryForObject("select skill_markdown from analysis_skill_versions where id=?", String.class, id);
  }

  private byte[] packageBytes(long id) {
    return jdbcTemplate.queryForObject("select package_bytes from analysis_skill_versions where id=?", byte[].class, id);
  }

  private static String manifestJson(SkillPackageValidator.SkillManifest manifest) {
    try {
      return new tools.jackson.databind.ObjectMapper().writeValueAsString(manifest);
    } catch (Exception exception) {
      throw new IllegalArgumentException("Unable to serialize Skill manifest", exception);
    }
  }

  private static String checksum(byte[] bytes) {
    try {
      byte[] digest = MessageDigest.getInstance("SHA-256").digest(bytes);
      StringBuilder value = new StringBuilder();
      for (byte item : digest) {
        value.append(String.format("%02x", item));
      }
      return value.toString();
    } catch (NoSuchAlgorithmException exception) {
      throw new IllegalStateException("SHA-256 unavailable", exception);
    }
  }

  private static void validatePair(
      AnalysisPeriod period, AnalysisSkillVersion rule, AnalysisSkillVersion template) {
    if (rule.period() != period || template.period() != period || rule.kind() != AnalysisSkillKind.RULE
        || template.kind() != AnalysisSkillKind.TEMPLATE) {
      throw new IllegalArgumentException("规则与模板必须属于同一分析周期的对应槽位");
    }
  }

  private AnalysisSkillTrial getTrial(long id) {
    return jdbcTemplate.queryForObject("select " + TRIAL_COLUMNS + ",exists(select 1 from analysis_skill_artifacts a where a.trial_id=t.id "
        + "and a.artifact_type='REPORT_DOCX') as has_document from analysis_skill_trials t where t.id=?",
        this::mapTrial, id);
  }

  private AnalysisSkillVersion mapVersion(ResultSet resultSet, int row) throws SQLException {
    return new AnalysisSkillVersion(resultSet.getLong("id"),
        AnalysisPeriod.valueOf(resultSet.getString("analysis_period")),
        AnalysisSkillKind.valueOf(resultSet.getString("skill_kind")), resultSet.getInt("version_number"),
        AnalysisSkillStatus.valueOf(resultSet.getString("status")), resultSet.getString("skill_name"),
        resultSet.getString("description"), resultSet.getString("package_name"), resultSet.getString("checksum"),
        resultSet.getString("validation_message"), resultSet.getString("runtime_profile"),
        instant(resultSet, "trial_succeeded_at"),
        instant(resultSet, "published_at"), instant(resultSet, "created_at"));
  }

  private AnalysisSkillTrial mapTrial(ResultSet resultSet, int row) throws SQLException {
    return new AnalysisSkillTrial(resultSet.getLong("id"),
        AnalysisPeriod.valueOf(resultSet.getString("analysis_period")), resultSet.getLong("rule_skill_version_id"),
        resultSet.getLong("template_skill_version_id"), resultSet.getObject("period_start", LocalDate.class),
        resultSet.getObject("period_end", LocalDate.class), resultSet.getString("status"),
        resultSet.getString("analysis_draft"), resultSet.getString("rendered_html"), resultSet.getBoolean("has_document"),
        resultSet.getString("error_summary"), instant(resultSet, "started_at"), instant(resultSet, "finished_at"));
  }

  private static Instant instant(ResultSet resultSet, String field) throws SQLException {
    return resultSet.getTimestamp(field) == null ? null : resultSet.getTimestamp(field).toInstant();
  }

  public record PublishedSkillPair(AnalysisSkillVersion rule, AnalysisSkillVersion template,
      String ruleMarkdown, String templateMarkdown, byte[] rulePackage, byte[] templatePackage) {}

  public record SkillArtifact(String fileName, String mimeType, byte[] content) {}
}
