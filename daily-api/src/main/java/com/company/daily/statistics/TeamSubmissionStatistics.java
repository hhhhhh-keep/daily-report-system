package com.company.daily.statistics;

import java.math.BigDecimal;

public record TeamSubmissionStatistics(
    String teamName,
    int expectedCount,
    int submittedCount,
    int missingCount,
    BigDecimal submissionRate) {}
