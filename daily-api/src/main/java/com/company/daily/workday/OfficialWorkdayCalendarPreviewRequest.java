package com.company.daily.workday;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record OfficialWorkdayCalendarPreviewRequest(
    @Min(2000) @Max(9999) int year,
    @NotBlank @Size(max = 1000) String noticeUrl) {}
