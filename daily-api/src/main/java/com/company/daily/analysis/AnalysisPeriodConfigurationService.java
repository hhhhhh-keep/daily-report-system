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
  private static final String DEFAULT_EMAIL_SUBJECT = "{{period}}分析报告｜{{date}}";
  private static final String DEFAULT_REPORT_TITLE = "{{period}}工作分析报告（截至{{date}}）";
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
            rs.getInt("retention_months"), rs.getBoolean("include_evidence_in_delivery"),
            rs.getBoolean("email_enabled"), rs.getString("email_recipients"),
            rs.getString("email_cc_recipients"), rs.getString("email_subject_template"),
            rs.getString("report_title_template")));
  }

  @Transactional(readOnly = true)
  public AnalysisPeriodConfiguration get(AnalysisPeriod period) {
    return jdbcTemplate.queryForObject("select * from analysis_period_configurations "
        + "where analysis_period=?", (rs, row) -> map(rs.getString("analysis_period"),
            rs.getBoolean("enabled"), rs.getString("cron_expression"),
            rs.getString("enabled_modules"), rs.getInt("retention_months"),
            rs.getBoolean("include_evidence_in_delivery"), rs.getBoolean("email_enabled"),
            rs.getString("email_recipients"), rs.getString("email_cc_recipients"),
            rs.getString("email_subject_template"), rs.getString("report_title_template")),
        period.name());
  }

  @Transactional
  public AnalysisPeriodConfiguration update(AnalysisPeriodConfiguration value) {
    if (!CronExpression.isValidExpression(value.cronExpression().trim())) {
      throw new IllegalArgumentException("Invalid Quartz Cron expression");
    }
    if (value.retentionMonths() <= 0) {
      throw new IllegalArgumentException("Retention months must be positive");
    }
    if (!StringUtils.hasText(value.emailSubjectTemplate())
        || !StringUtils.hasText(value.reportTitleTemplate())) {
      throw new IllegalArgumentException("邮件标题和报告标题不能为空");
    }
    jdbcTemplate.update("update analysis_period_configurations set enabled=?,cron_expression=?,"
            + "enabled_modules=?,retention_months=?,include_evidence_in_delivery=?,email_enabled=?,"
            + "email_recipients=?,email_cc_recipients=?,email_subject_template=?,report_title_template=?,"
            + "updated_at=current_timestamp where analysis_period=?", value.enabled(),
        value.cronExpression().trim(), String.join(",", value.enabledModules()),
        value.retentionMonths(), value.includeEvidenceInDelivery(), value.emailEnabled(),
        join(value.emailRecipients()), join(value.emailCcRecipients()),
        value.emailSubjectTemplate().trim(), value.reportTitleTemplate().trim(), value.period().name());
    return get(value.period());
  }

  private static AnalysisPeriodConfiguration map(
      String period, boolean enabled, String cron, String modules, int retention, boolean evidence,
      boolean emailEnabled, String recipients, String ccRecipients, String subject, String reportTitle) {
    List<String> selected = StringUtils.hasText(modules)
        ? Arrays.stream(modules.split(",")).map(String::trim).filter(StringUtils::hasText).toList()
        : List.of();
    return new AnalysisPeriodConfiguration(
        AnalysisPeriod.valueOf(period), enabled, cron, selected, retention, evidence, emailEnabled,
        csv(recipients), csv(ccRecipients), defaultText(subject, DEFAULT_EMAIL_SUBJECT),
        defaultText(reportTitle, DEFAULT_REPORT_TITLE));
  }

  private static List<String> csv(String value) {
    return StringUtils.hasText(value) ? Arrays.stream(value.split(",")).map(String::trim)
        .filter(StringUtils::hasText).toList() : List.of();
  }

  private static String join(List<String> values) {
    return values == null ? "" : values.stream().filter(StringUtils::hasText).map(String::trim)
        .collect(java.util.stream.Collectors.joining(","));
  }

  private static String defaultText(String value, String defaultValue) {
    return StringUtils.hasText(value) ? value.trim() : defaultValue;
  }
}
