package com.company.daily.statistics;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.util.List;

public record ReportStatisticsSnapshotResponse(
    Long id,
    ReportStatisticsSnapshotType snapshotType,
    LocalDate snapshotDate,
    Instant capturedAt,
    int expectedCount,
    int submittedCount,
    int missingCount,
    BigDecimal submissionRate,
    List<SnapshotEmployee> submittedEmployees,
    List<SnapshotEmployee> missingEmployees,
    List<SnapshotEmployee> lateSubmittedEmployees,
    List<TeamSubmissionStatistics> teamStatistics) {}
