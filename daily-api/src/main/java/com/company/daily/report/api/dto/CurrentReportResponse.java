package com.company.daily.report.api.dto;

import java.time.Instant;
import java.time.LocalDate;
import java.util.List;

public record CurrentReportResponse(
    Long id,
    Long employeeId,
    String employeeName,
    LocalDate date,
    String attendance,
    String note,
    String status,
    Instant submittedAt,
    Instant updatedAt,
    List<CurrentTaskResponse> tasks) {}
