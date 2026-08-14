package com.company.daily.report.api.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.time.LocalDate;
import java.util.List;

public record CurrentReportRequest(
    @NotNull Long employeeId,
    @NotNull LocalDate date,
    @NotBlank @Size(max = 50) String attendance,
    @Size(max = 2000) String note,
    List<@Valid CurrentTaskRequest> tasks) {}
