package com.company.daily.skills;

import com.company.daily.analysis.AnalysisPeriod;
import java.time.Instant;

public record AnalysisSkillVersion(
    long id,
    AnalysisPeriod period,
    AnalysisSkillKind kind,
    int versionNumber,
    AnalysisSkillStatus status,
    String skillName,
    String description,
    String packageName,
    String checksum,
    String validationMessage,
    Instant trialSucceededAt,
    Instant publishedAt,
    Instant createdAt) {}
