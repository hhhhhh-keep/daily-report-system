package com.company.daily.workday;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.time.LocalDate;

public record WorkdayCalendarImportItem(
    @NotNull LocalDate date,
    @NotNull Boolean workday,
    @NotNull WorkdaySource source,
    @Size(max = 500) String note) {}
