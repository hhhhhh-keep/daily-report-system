package com.company.daily.configuration;

import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import org.springframework.jdbc.core.JdbcTemplate;
import org.quartz.CronExpression;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

@Service
public class AnalysisConfigurationService {
  private final JdbcTemplate jdbcTemplate;

  public AnalysisConfigurationService(JdbcTemplate jdbcTemplate) {
    this.jdbcTemplate = jdbcTemplate;
  }

  @Transactional(readOnly = true)
  public AnalysisConfiguration get() {
    return jdbcTemplate.queryForObject("select * from analysis_configurations where id=1", (rs, row) ->
        new AnalysisConfiguration(
            rs.getBoolean("enabled"), rs.getString("cron_expression"),
            split(rs.getString("selected_dimensions")), thresholds(rs.getString("rule_thresholds")),
            rs.getString("prompt_version"), rs.getString("prompt_template"),
            rs.getBoolean("dashboard_enabled"), rs.getBoolean("report_enabled"),
            rs.getBoolean("email_enabled"), split(rs.getString("recipients")),
            split(rs.getString("cc_recipients")), rs.getString("email_subject_template"),
            rs.getString("report_template"), rs.getString("model_endpoint"),
            rs.getString("model_name"), rs.getString("model_api_key"),
            rs.getString("smtp_host"), (Integer) rs.getObject("smtp_port"),
            rs.getString("smtp_username"), rs.getString("smtp_password"),
            rs.getString("smtp_from")));
  }

  @Transactional
  public AnalysisConfiguration update(AnalysisConfigurationRequest request) {
    if (!CronExpression.isValidExpression(request.cronExpression().trim())) {
      throw new IllegalArgumentException("Quartz Cron 表达式无效");
    }
    request.ruleThresholds().forEach((key, value) -> {
      if (!StringUtils.hasText(key) || value == null || value < 0) {
        throw new IllegalArgumentException("规则阈值必须为非负整数");
      }
    });
    if (request.emailEnabled() && clean(request.recipients()).isEmpty()) {
      throw new IllegalArgumentException("启用邮件时必须配置收件人");
    }
    if (request.emailEnabled() && !request.reportEnabled()) {
      throw new IllegalArgumentException("启用邮件时必须启用报告生成");
    }
    if (request.smtpPort() != null && (request.smtpPort() <= 0 || request.smtpPort() > 65535)) {
      throw new IllegalArgumentException("SMTP 端口必须在 1-65535 之间");
    }
    jdbcTemplate.update("""
        update analysis_configurations set enabled=?, cron_expression=?, selected_dimensions=?,
        rule_thresholds=?, prompt_version=?, prompt_template=?, dashboard_enabled=?, report_enabled=?,
        email_enabled=?, recipients=?, cc_recipients=?, email_subject_template=?, report_template=?,
        model_endpoint=?, model_name=?, model_api_key=?,
        smtp_host=?, smtp_port=?, smtp_username=?, smtp_password=?, smtp_from=?,
        updated_at=current_timestamp where id=1
        """, request.enabled(), request.cronExpression().trim(), join(request.selectedDimensions()),
        serialize(request.ruleThresholds()), request.promptVersion().trim(), request.promptTemplate().trim(),
        request.dashboardEnabled(), request.reportEnabled(), request.emailEnabled(),
        join(clean(request.recipients())), join(clean(request.ccRecipients())),
        request.emailSubjectTemplate().trim(), request.reportTemplate().trim(),
        optional(request.modelEndpoint()), optional(request.modelName()),
        optional(request.modelApiKey()),
        optional(request.smtpHost()), request.smtpPort(),
        optional(request.smtpUsername()), optional(request.smtpPassword()),
        optional(request.smtpFrom()));
    return get();
  }

  private static List<String> split(String value) {
    return StringUtils.hasText(value) ? Arrays.stream(value.split(","))
        .map(String::trim).filter(StringUtils::hasText).toList() : List.of();
  }

  private static Map<String, Integer> thresholds(String value) {
    Map<String, Integer> result = new LinkedHashMap<>();
    if (!StringUtils.hasText(value)) {
      return result;
    }
    for (String entry : value.split(";")) {
      String[] parts = entry.split("=", 2);
      if (parts.length == 2) {
        result.put(parts[0].trim(), Integer.parseInt(parts[1].trim()));
      }
    }
    return result;
  }

  private static String serialize(Map<String, Integer> values) {
    return values.entrySet().stream().map(entry -> entry.getKey() + "=" + entry.getValue())
        .collect(Collectors.joining(";"));
  }

  private static List<String> clean(List<String> values) {
    return values == null ? List.of() : values.stream().filter(StringUtils::hasText)
        .map(String::trim).toList();
  }

  private static String join(List<String> values) { return String.join(",", clean(values)); }
  private static String optional(String value) { return StringUtils.hasText(value) ? value.trim() : null; }
}
