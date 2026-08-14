package com.company.daily.report.api.dto;

import java.time.Instant;
import java.time.LocalDate;

public record AdminReportSummaryResponse(
    Long id,
    LocalDate date,
    Long employeeId,
    String employeeName,
    String attendance,
    String status,
    int taskCount,
    Instant submittedAt,
    Instant updatedAt) {}
