package com.company.daily.scheduling;

import java.time.Instant;
import java.time.LocalDate;
import java.util.List;

public record AnalysisRunResponse(
    Long id,
    LocalDate analysisDate,
    String analysisPeriod,
    LocalDate periodStart,
    LocalDate periodEnd,
    Long ruleVersionId,
    String promptVersion,
    String taskName,
    String triggerType,
    String status,
    List<String> selectedDimensions,
    Instant startedAt,
    Instant finishedAt,
    int analyzedEmployeeCount,
    String metricsJson,
    String rulesJson,
    String advisoryText,
    String llmStatus,
    String llmErrorSummary,
    boolean reportAvailable,
    String reportFileName,
    String reportMimeType,
    String emailStatus,
    String errorSummary,
    Long retryOfRunId,
    int retryCount) {}
