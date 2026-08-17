package com.company.daily.report.api.dto;

import java.math.BigDecimal;

public record PersonReportPeriodStatistics(
    long employeeId,
    String employeeName,
    String teamName,
    int expectedReportCount,
    int earlySubmittedCount,
    BigDecimal earlySubmissionRate,
    int missingCount,
    int leaveOccurrences,
    BigDecimal leaveEquivalentDays,
    int trainingCount) {}
