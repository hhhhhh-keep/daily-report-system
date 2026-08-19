package com.company.daily.workday;

import java.util.List;

public record OfficialWorkdayCalendarPreviewResponse(
    int year, String noticeUrl, List<WorkdayCalendarImportItem> entries) {}
