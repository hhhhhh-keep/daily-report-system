package com.company.daily.skills;

import com.company.daily.analysis.AnalysisPeriod;
import java.time.Instant;
import java.time.LocalDate;

public record AnalysisSkillTrial(
    long id,
    AnalysisPeriod period,
    long ruleSkillVersionId,
    long templateSkillVersionId,
    LocalDate periodStart,
    LocalDate periodEnd,
    String status,
    String analysisDraft,
    String renderedHtml,
    boolean hasDocument,
    String errorSummary,
    Instant startedAt,
    Instant finishedAt) {}
