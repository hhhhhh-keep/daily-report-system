package com.company.daily.analysis;

import java.util.List;

public record AnalysisPeriodConfiguration(
    AnalysisPeriod period,
    boolean enabled,
    String cronExpression,
    List<String> enabledModules,
    int retentionMonths,
    boolean includeEvidenceInDelivery,
    boolean emailEnabled,
    List<String> emailRecipients,
    List<String> emailCcRecipients,
    String emailSubjectTemplate,
    String reportTitleTemplate) {
  public AnalysisPeriodConfiguration(
      AnalysisPeriod period,
      boolean enabled,
      String cronExpression,
      List<String> enabledModules,
      int retentionMonths,
      boolean includeEvidenceInDelivery) {
    this(period, enabled, cronExpression, enabledModules, retentionMonths, includeEvidenceInDelivery,
        false, List.of(), List.of(), "{{period}}分析报告｜{{date}}",
        "{{period}}工作分析报告（截至{{date}}）");
  }
}
