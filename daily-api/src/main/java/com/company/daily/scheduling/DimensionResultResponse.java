package com.company.daily.scheduling;

import java.time.LocalDate;

public record DimensionResultResponse(
    Long runId, LocalDate analysisDate, String dimension, String resultText) {}
