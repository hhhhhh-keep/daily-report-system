package com.company.daily.analysis;

import java.time.Instant;

public record AnalysisRuleVersion(
    long id,
    AnalysisPeriod period,
    int versionNumber,
    AnalysisRuleVersionStatus status,
    String changeNote,
    String rulesJson,
    String promptTemplate,
    String customSchemaJson,
    Instant trialSucceededAt,
    Instant publishedAt) {}
