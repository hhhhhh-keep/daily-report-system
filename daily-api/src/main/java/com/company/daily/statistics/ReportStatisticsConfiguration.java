package com.company.daily.statistics;

public record ReportStatisticsConfiguration(
    boolean earlySnapshotEnabled,
    String earlySnapshotCronExpression,
    boolean finalSnapshotEnabled,
    String finalSnapshotCronExpression) {}
