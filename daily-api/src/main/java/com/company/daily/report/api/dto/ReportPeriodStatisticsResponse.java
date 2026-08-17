package com.company.daily.report.api.dto;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

public record ReportPeriodStatisticsResponse(
    String period,
    LocalDate periodStart,
    LocalDate periodEnd,
    int workdayCount,
    String coverageMode,
    Totals totals,
    List<PersonReportPeriodStatistics> people) {

  public record Totals(
      int expectedReportCount,
      int earlySubmittedCount,
      BigDecimal earlySubmissionRate,
      int missingCount,
      int leaveOccurrences,
      BigDecimal leaveEquivalentDays,
      int trainingCount) {}
}
