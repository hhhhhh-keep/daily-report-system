package com.company.daily.analysis;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import java.util.List;

public record AnalysisPeriodConfigurationRequest(
    boolean enabled,
    @NotBlank String cronExpression,
    @NotEmpty List<@NotBlank String> enabledModules,
    @Min(1) int retentionMonths,
    boolean includeEvidenceInDelivery,
    boolean emailEnabled,
    List<String> emailRecipients,
    List<String> emailCcRecipients,
    String emailSubjectTemplate,
    String reportTitleTemplate) {}
