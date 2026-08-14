package com.company.daily.configuration;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import java.util.List;
import java.util.Map;

public record AnalysisConfigurationRequest(
    boolean enabled,
    @NotBlank String cronExpression,
    @NotEmpty List<@NotBlank String> selectedDimensions,
    @NotNull Map<String, Integer> ruleThresholds,
    @NotBlank String promptVersion,
    @NotBlank String promptTemplate,
    boolean dashboardEnabled,
    boolean reportEnabled,
    boolean emailEnabled,
    List<String> recipients,
    List<String> ccRecipients,
    @NotBlank String emailSubjectTemplate,
    @NotBlank String reportTemplate,
    String modelEndpoint,
    String modelName,
    /** 可选：API key；留空回落到环境变量 LLM_API_KEY。 */
    String modelApiKey,
    String smtpHost,
    Integer smtpPort,
    String smtpUsername,
    String smtpPassword,
    String smtpFrom) {}
