package com.company.daily.masterdata.state;

import java.time.LocalDate;

public record ProjectStateFact(
    long taskId, LocalDate reportDate, String workType, String workStage, String currentStatus) {}
