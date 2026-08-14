package com.company.daily.metrics;

import java.math.BigDecimal;
import java.time.LocalDate;

public record DashboardMetricsResponse(
    LocalDate date,
    int activeEmployeeCount,
    int submittedReportCount,
    int missingReportCount,
    int taskCount,
    int projectCount,
    int abnormalTaskCount,
    int morningTaskCount,
    int afternoonTaskCount,
    BigDecimal submissionRate,
    BigDecimal progress1730Rate,
    int progress1730SubmittedCount,
    int progress1730MissingCount) {}
