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
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AnalysisSkillService {
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
    return jdbcTemplate.query("select * from analysis_skill_versions where analysis_period=? and skill_kind=? "
        + "order by version_number desc", this::mapVersion, period.name(), kind.name());
  }

  @Transactional(readOnly = true)
  public Optional<AnalysisSkillVersion> published(AnalysisPeriod period, AnalysisSkillKind kind) {
    return jdbcTemplate.query("select * from analysis_skill_versions where analysis_period=? and skill_kind=? "
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
        + "validation_message) values (?,?,?,'DRAFT',?,?,?,?,?,?,?) returning id", Long.class,
        period.name(), kind.name(), version, value.skillName(), value.description(), packageName,
        packageBytes, value.markdown(), value.checksum(), "校验通过");
    return get(id);
  }

  @Transactional(readOnly = true)
  public byte[] download(long id) {
    return jdbcTemplate.queryForObject("select package_bytes from analysis_skill_versions where id=?", byte[].class, id);
  }

  @Transactional
  public AnalysisSkillTrial trial(AnalysisPeriod period, LocalDate endDate, long ruleVersionId, long templateVersionId) {
    AnalysisSkillVersion rule = get(ruleVersionId);
    AnalysisSkillVersion template = get(templateVersionId);
    validatePair(period, rule, template);
    AnalysisPeriodWindow window = windowService.resolve(period, endDate);
    String snapshot = snapshotService.build(window);
    SkillAnalysisExecutor.SkillExecution execution = executor.execute(rule, template, markdown(rule.id()),
        markdown(template.id()), snapshot);
    long id = jdbcTemplate.queryForObject("insert into analysis_skill_trials(analysis_period,rule_skill_version_id,"
        + "template_skill_version_id,period_start,period_end,status,source_snapshot_json,analysis_draft,rendered_html,"
        + "error_summary,finished_at) values (?,?,?,?,?,?,?,?,?,?,current_timestamp) returning id", Long.class,
        period.name(), rule.id(), template.id(), window.startDate(), window.endDate(), execution.status(),
        snapshot, execution.analysisDraft(), execution.renderedHtml(), execution.errorSummary());
    if ("SUCCEEDED".equals(execution.status())) {
      jdbcTemplate.update("update analysis_skill_versions set trial_succeeded_at=current_timestamp where id in (?,?)",
          ruleVersionId, templateVersionId);
    }
    return getTrial(id);
  }

  @Transactional
  public void publishPair(AnalysisPeriod period, long ruleVersionId, long templateVersionId) {
    AnalysisSkillVersion rule = get(ruleVersionId);
    AnalysisSkillVersion template = get(templateVersionId);
    validatePair(period, rule, template);
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
    return jdbcTemplate.query("select * from analysis_skill_trials where analysis_period=? order by started_at desc",
        this::mapTrial, period.name());
  }

  @Transactional(readOnly = true)
  public AnalysisSkillVersion get(long id) {
    return jdbcTemplate.queryForObject("select * from analysis_skill_versions where id=?", this::mapVersion, id);
  }

  @Transactional(readOnly = true)
  public PublishedSkillPair publishedPair(AnalysisPeriod period) {
    AnalysisSkillVersion rule = published(period, AnalysisSkillKind.RULE)
        .orElseThrow(() -> new IllegalArgumentException("该周期没有已发布的规则 Skill"));
    AnalysisSkillVersion template = published(period, AnalysisSkillKind.TEMPLATE)
        .orElseThrow(() -> new IllegalArgumentException("该周期没有已发布的模板 Skill"));
    return new PublishedSkillPair(rule, template, markdown(rule.id()), markdown(template.id()));
  }

  private String markdown(long id) {
    return jdbcTemplate.queryForObject("select skill_markdown from analysis_skill_versions where id=?", String.class, id);
  }

  private static void validatePair(
      AnalysisPeriod period, AnalysisSkillVersion rule, AnalysisSkillVersion template) {
    if (rule.period() != period || template.period() != period || rule.kind() != AnalysisSkillKind.RULE
        || template.kind() != AnalysisSkillKind.TEMPLATE) {
      throw new IllegalArgumentException("规则与模板必须属于同一分析周期的对应槽位");
    }
  }

  private AnalysisSkillTrial getTrial(long id) {
    return jdbcTemplate.queryForObject("select * from analysis_skill_trials where id=?", this::mapTrial, id);
  }

  private AnalysisSkillVersion mapVersion(ResultSet resultSet, int row) throws SQLException {
    return new AnalysisSkillVersion(resultSet.getLong("id"),
        AnalysisPeriod.valueOf(resultSet.getString("analysis_period")),
        AnalysisSkillKind.valueOf(resultSet.getString("skill_kind")), resultSet.getInt("version_number"),
        AnalysisSkillStatus.valueOf(resultSet.getString("status")), resultSet.getString("skill_name"),
        resultSet.getString("description"), resultSet.getString("package_name"), resultSet.getString("checksum"),
        resultSet.getString("validation_message"), instant(resultSet, "trial_succeeded_at"),
        instant(resultSet, "published_at"), instant(resultSet, "created_at"));
  }

  private AnalysisSkillTrial mapTrial(ResultSet resultSet, int row) throws SQLException {
    return new AnalysisSkillTrial(resultSet.getLong("id"),
        AnalysisPeriod.valueOf(resultSet.getString("analysis_period")), resultSet.getLong("rule_skill_version_id"),
        resultSet.getLong("template_skill_version_id"), resultSet.getObject("period_start", LocalDate.class),
        resultSet.getObject("period_end", LocalDate.class), resultSet.getString("status"),
        resultSet.getString("analysis_draft"), resultSet.getString("rendered_html"),
        resultSet.getString("error_summary"), instant(resultSet, "started_at"), instant(resultSet, "finished_at"));
  }

  private static Instant instant(ResultSet resultSet, String field) throws SQLException {
    return resultSet.getTimestamp(field) == null ? null : resultSet.getTimestamp(field).toInstant();
  }

  public record PublishedSkillPair(AnalysisSkillVersion rule, AnalysisSkillVersion template,
      String ruleMarkdown, String templateMarkdown) {}
}
