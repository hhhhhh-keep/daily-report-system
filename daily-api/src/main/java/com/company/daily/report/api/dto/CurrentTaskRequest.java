package com.company.daily.report.api.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record CurrentTaskRequest(
    @NotBlank String timePeriod,
    Long projectId,
    @Size(max = 200) String projectName,
    @NotBlank @Size(max = 100) String workType,
    @Size(max = 100) String workStage,
    @NotBlank String participationRole,
    @NotBlank @Size(max = 4000) String progressResult,
    @NotBlank String currentStatus,
    @Size(max = 100) String issueType,
    @Size(max = 100) String collaborationRole,
    @Size(max = 2000) String collaborationRequirement) {
  public CurrentTaskRequest(
      String timePeriod,
      Long projectId,
      String workType,
      String workStage,
      String participationRole,
      String progressResult,
      String currentStatus,
      String issueType,
      String collaborationRole,
      String collaborationRequirement) {
    this(timePeriod, projectId, null, workType, workStage, participationRole, progressResult,
        currentStatus, issueType, collaborationRole, collaborationRequirement);
  }
}
