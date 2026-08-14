package com.company.daily.statistics;

import java.time.Instant;

public record StatisticsSubmission(Long employeeId, Instant submittedAt) {}
