package com.company.daily.workday;

import java.time.LocalDate;

public record WorkdayCalendarResponse(
    Long id,
    LocalDate date,
    boolean workday,
    WorkdaySource source,
    String note,
    boolean active) {}
