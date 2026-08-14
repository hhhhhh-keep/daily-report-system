package com.company.daily.analysis;

import java.util.List;

public record AnalysisPeriodConfiguration(
    AnalysisPeriod period,
    boolean enabled,
    String cronExpression,
    List<String> enabledModules,
    int retentionMonths,
    boolean includeEvidenceInDelivery) {}
