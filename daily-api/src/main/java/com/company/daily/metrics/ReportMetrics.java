package com.company.daily.metrics;

import java.time.LocalDate;

public record ReportMetrics(
    LocalDate date,
    int activeEmployeeCount,
    int submittedReportCount,
    int missingReportCount,
    int taskCount,
    int projectCount,
    int morningTaskCount,
    int afternoonTaskCount,
    int abnormalTaskCount,
    int waitingFeedbackTaskCount,
    int temporarySupportTaskCount,
    int vagueTaskCount,
    int multiProjectEmployeeCount,
    int multiPersonProjectCount,
    int maxConsecutiveSupportDays,
    int maxConsecutiveWaitingFeedbackDays) {}
