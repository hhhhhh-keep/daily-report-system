package com.company.daily.email;

import com.company.daily.analysis.AnalysisPeriod;
import com.company.daily.analysis.AnalysisPeriodConfiguration;
import java.time.LocalDate;
import java.util.List;

public record PeriodEmailDeliverySettings(
    boolean enabled,
    List<String> recipients,
    List<String> ccRecipients,
    String subject,
    String reportTitle) {
  public static PeriodEmailDeliverySettings from(
      AnalysisPeriodConfiguration configuration, LocalDate date) {
    return new PeriodEmailDeliverySettings(configuration.emailEnabled(),
        configuration.emailRecipients(), configuration.emailCcRecipients(),
        resolve(configuration.emailSubjectTemplate(), configuration.period(), date),
        resolve(configuration.reportTitleTemplate(), configuration.period(), date));
  }

  private static String resolve(String template, AnalysisPeriod period, LocalDate date) {
    return template.replace("{{period}}", periodLabel(period)).replace("{{date}}", date.toString());
  }

  private static String periodLabel(AnalysisPeriod period) {
    return switch (period) {
      case DAILY -> "日报";
      case WEEKLY -> "周报";
      case MONTHLY -> "月报";
    };
  }
}
