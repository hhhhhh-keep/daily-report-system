package com.company.daily.masterdata.api.dto;

import java.time.LocalDate;
import java.util.List;
import com.company.daily.masterdata.state.ProjectDerivedStateResponse;
import com.company.daily.masterdata.state.ProjectStateEventResponse;

public record ProjectActivityResponse(
    long projectId,
    int participantCount,
    LocalDate latestReportDate,
    int completedCount,
    int inProgressCount,
    int blockedOrPausedCount,
    ProjectDerivedStateResponse derivedState,
    List<ProjectStateEventResponse> stateEvents,
    List<ProjectActivityTaskResponse> tasks,
    int page,
    int pageSize,
    long totalItems) {}
