package com.company.daily.configuration;

import java.util.List;
import java.util.Map;

public record AnalysisConfiguration(
    boolean enabled,
    String cronExpression,
    List<String> selectedDimensions,
    Map<String, Integer> ruleThresholds,
    String promptVersion,
    String promptTemplate,
    boolean dashboardEnabled,
    boolean reportEnabled,
    boolean emailEnabled,
    List<String> recipients,
    List<String> ccRecipients,
    String emailSubjectTemplate,
    String reportTemplate,
    String modelEndpoint,
    String modelName,
    /** API key，直接写值；为空则回落到环境变量 LLM_API_KEY。 */
    String modelApiKey,
    String smtpHost,
    Integer smtpPort,
    String smtpUsername,
    String smtpPassword,
    String smtpFrom) {}
