package com.company.daily.masterdata.state;

import java.time.LocalDate;

public record ProjectStateEventResponse(
    LocalDate occurredDate,
    ProjectDerivedStateValue state,
    String currentStage,
    long triggerTaskId) {}
