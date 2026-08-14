package com.company.daily.masterdata.state;

import java.time.LocalDate;

public record ProjectDerivedStateResponse(
    ProjectDerivedStateValue state,
    String lifecycle,
    String currentStage,
    LocalDate stateStartedDate,
    Long triggerTaskId) {}
