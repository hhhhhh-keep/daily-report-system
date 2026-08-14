package com.company.daily.workday;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import java.util.List;

public record WorkdayCalendarImportRequest(
    @Min(2000) @Max(9999) int year,
    @NotEmpty List<@Valid WorkdayCalendarImportItem> entries) {}
