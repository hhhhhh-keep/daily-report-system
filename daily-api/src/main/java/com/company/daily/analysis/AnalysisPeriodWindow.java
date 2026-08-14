package com.company.daily.analysis;

import java.time.LocalDate;

public record AnalysisPeriodWindow(AnalysisPeriod period, LocalDate startDate, LocalDate endDate) {}
