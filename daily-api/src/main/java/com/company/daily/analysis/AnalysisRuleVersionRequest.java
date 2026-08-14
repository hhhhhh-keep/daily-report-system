package com.company.daily.analysis;

import jakarta.validation.constraints.NotBlank;

public record AnalysisRuleVersionRequest(
    @NotBlank String changeNote,
    @NotBlank String rulesJson,
    @NotBlank String promptTemplate,
    @NotBlank String customSchemaJson) {}
