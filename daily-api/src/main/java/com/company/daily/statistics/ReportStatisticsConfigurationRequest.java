package com.company.daily.statistics;

import jakarta.validation.constraints.NotBlank;

public record ReportStatisticsConfigurationRequest(
    boolean earlySnapshotEnabled,
    @NotBlank String earlySnapshotCronExpression,
    boolean finalSnapshotEnabled,
    @NotBlank String finalSnapshotCronExpression) {}
