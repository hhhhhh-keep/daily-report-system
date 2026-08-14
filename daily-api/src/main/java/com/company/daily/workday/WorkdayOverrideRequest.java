package com.company.daily.workday;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.time.LocalDate;

public record WorkdayOverrideRequest(
    @NotNull LocalDate date,
    @NotNull Boolean workday,
    @Size(max = 500) String note) {}
