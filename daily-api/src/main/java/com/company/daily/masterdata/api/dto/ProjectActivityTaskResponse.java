package com.company.daily.masterdata.api.dto;

import java.time.LocalDate;

public record ProjectActivityTaskResponse(
    long taskId,
    LocalDate reportDate,
    long employeeId,
    String employeeName,
    String workStage,
    String currentStatus,
    String progressResult,
    String issueType,
    String collaborationRequirement) {}
