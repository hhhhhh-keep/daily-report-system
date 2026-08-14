package com.company.daily.analysis;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.Instant;
import java.util.List;
import java.util.Optional;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AnalysisRuleVersionService {
  private final JdbcTemplate jdbcTemplate;

  public AnalysisRuleVersionService(JdbcTemplate jdbcTemplate) {
    this.jdbcTemplate = jdbcTemplate;
  }

  @Transactional(readOnly = true)
  public List<AnalysisRuleVersion> list(AnalysisPeriod period) {
    return jdbcTemplate.query("select * from analysis_rule_versions where analysis_period=? "
        + "order by version_number desc", this::map, period.name());
  }

  @Transactional(readOnly = true)
  public Optional<AnalysisRuleVersion> published(AnalysisPeriod period) {
    List<AnalysisRuleVersion> versions = jdbcTemplate.query("select * from analysis_rule_versions "
        + "where analysis_period=? and status='PUBLISHED'", this::map, period.name());
    return versions.stream().findFirst();
  }

  @Transactional
  public AnalysisRuleVersion createDraft(AnalysisPeriod period, AnalysisRuleVersionRequest request) {
    int version = jdbcTemplate.queryForObject("select coalesce(max(version_number), 0) + 1 "
        + "from analysis_rule_versions where analysis_period=?", Integer.class, period.name());
    long id = jdbcTemplate.queryForObject("insert into analysis_rule_versions(analysis_period,"
        + "version_number,status,change_note,rules_json,prompt_template,custom_schema_json) "
        + "values (?,?,'DRAFT',?,?,?,?) returning id", Long.class, period.name(), version,
        request.changeNote().trim(), request.rulesJson(), request.promptTemplate(),
        request.customSchemaJson());
    return get(id);
  }

  @Transactional
  public AnalysisRuleVersion markTrialSucceeded(long id) {
    jdbcTemplate.update("update analysis_rule_versions set trial_succeeded_at=current_timestamp "
        + "where id=? and status='DRAFT'", id);
    return get(id);
  }

  @Transactional
  public AnalysisRuleVersion publish(long id, boolean allowUntriedFirstVersion) {
    AnalysisRuleVersion version = get(id);
    if (version.status() != AnalysisRuleVersionStatus.DRAFT) {
      throw new IllegalArgumentException("Only draft versions can be published");
    }
    boolean firstVersion = jdbcTemplate.queryForObject("select count(*)=0 from analysis_rule_versions "
        + "where analysis_period=? and status='PUBLISHED'", Boolean.class, version.period().name());
    if (version.trialSucceededAt() == null && !(allowUntriedFirstVersion && firstVersion)) {
      throw new IllegalArgumentException("A successful trial is required before publishing");
    }
    jdbcTemplate.update("update analysis_rule_versions set status='HISTORICAL' "
        + "where analysis_period=? and status='PUBLISHED'", version.period().name());
    jdbcTemplate.update("update analysis_rule_versions set status='PUBLISHED',published_at=current_timestamp "
        + "where id=?", id);
    return get(id);
  }

  @Transactional(readOnly = true)
  public AnalysisRuleVersion get(long id) {
    return jdbcTemplate.queryForObject("select * from analysis_rule_versions where id=?", this::map, id);
  }

  private AnalysisRuleVersion map(ResultSet rs, int row) throws SQLException {
    return new AnalysisRuleVersion(rs.getLong("id"), AnalysisPeriod.valueOf(rs.getString("analysis_period")),
        rs.getInt("version_number"), AnalysisRuleVersionStatus.valueOf(rs.getString("status")),
        rs.getString("change_note"), rs.getString("rules_json"), rs.getString("prompt_template"),
        rs.getString("custom_schema_json"), instant(rs, "trial_succeeded_at"), instant(rs, "published_at"));
  }

  private static Instant instant(ResultSet rs, String field) throws SQLException {
    return rs.getTimestamp(field) == null ? null : rs.getTimestamp(field).toInstant();
  }
}
