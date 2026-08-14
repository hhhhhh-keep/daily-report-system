package com.company.daily.report.api.dto;

public record CurrentTaskResponse(
    Long id,
    String timePeriod,
    Long projectId,
    String projectName,
    String workType,
    String workStage,
    String participationRole,
    String progressResult,
    String currentStatus,
    String issueType,
    String collaborationRole,
    String collaborationRequirement) {}
