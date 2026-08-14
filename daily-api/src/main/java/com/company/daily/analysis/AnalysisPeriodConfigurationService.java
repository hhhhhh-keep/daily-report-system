package com.company.daily.analysis;

import java.util.Arrays;
import java.util.List;
import org.quartz.CronExpression;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

@Service
public class AnalysisPeriodConfigurationService {
  private final JdbcTemplate jdbcTemplate;

  public AnalysisPeriodConfigurationService(JdbcTemplate jdbcTemplate) {
    this.jdbcTemplate = jdbcTemplate;
  }

  @Transactional(readOnly = true)
  public List<AnalysisPeriodConfiguration> list() {
    return jdbcTemplate.query("select * from analysis_period_configurations order by case analysis_period "
        + "when 'DAILY' then 1 when 'WEEKLY' then 2 when 'MONTHLY' then 3 end",
        (rs, row) -> map(rs.getString("analysis_period"), rs.getBoolean("enabled"),
            rs.getString("cron_expression"), rs.getString("enabled_modules"),
            rs.getInt("retention_months"), rs.getBoolean("include_evidence_in_delivery")));
  }

  @Transactional(readOnly = true)
  public AnalysisPeriodConfiguration get(AnalysisPeriod period) {
    return jdbcTemplate.queryForObject("select * from analysis_period_configurations "
        + "where analysis_period=?", (rs, row) -> map(rs.getString("analysis_period"),
            rs.getBoolean("enabled"), rs.getString("cron_expression"),
            rs.getString("enabled_modules"), rs.getInt("retention_months"),
            rs.getBoolean("include_evidence_in_delivery")), period.name());
  }

  @Transactional
  public AnalysisPeriodConfiguration update(AnalysisPeriodConfiguration value) {
    if (!CronExpression.isValidExpression(value.cronExpression().trim())) {
      throw new IllegalArgumentException("Invalid Quartz Cron expression");
    }
    if (value.retentionMonths() <= 0) {
      throw new IllegalArgumentException("Retention months must be positive");
    }
    jdbcTemplate.update("update analysis_period_configurations set enabled=?,cron_expression=?,"
            + "enabled_modules=?,retention_months=?,include_evidence_in_delivery=?,"
            + "updated_at=current_timestamp where analysis_period=?", value.enabled(),
        value.cronExpression().trim(), String.join(",", value.enabledModules()),
        value.retentionMonths(), value.includeEvidenceInDelivery(), value.period().name());
    return get(value.period());
  }

  private static AnalysisPeriodConfiguration map(
      String period, boolean enabled, String cron, String modules, int retention, boolean evidence) {
    List<String> selected = StringUtils.hasText(modules)
        ? Arrays.stream(modules.split(",")).map(String::trim).filter(StringUtils::hasText).toList()
        : List.of();
    return new AnalysisPeriodConfiguration(
        AnalysisPeriod.valueOf(period), enabled, cron, selected, retention, evidence);
  }
}
