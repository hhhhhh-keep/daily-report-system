package com.company.daily.statistics;

import java.time.Instant;

public record SnapshotEmployee(Long employeeId, String name, String teamName, Instant submittedAt) {}
