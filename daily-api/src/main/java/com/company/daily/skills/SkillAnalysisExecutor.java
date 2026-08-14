package com.company.daily.skills;

import com.company.daily.analysis.LlmAnalysisAdapter;
import com.company.daily.analysis.LlmAnalysisResult;
import com.company.daily.configuration.AnalysisConfiguration;
import com.company.daily.configuration.AnalysisConfigurationService;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import tools.jackson.databind.JsonNode;
import tools.jackson.databind.ObjectMapper;

@Service
public class SkillAnalysisExecutor {
  private final AnalysisConfigurationService configurationService;
  private final LlmAnalysisAdapter adapter;
  private final ObjectMapper objectMapper;

  public SkillAnalysisExecutor(
      AnalysisConfigurationService configurationService,
      LlmAnalysisAdapter adapter,
      ObjectMapper objectMapper) {
    this.configurationService = configurationService;
    this.adapter = adapter;
    this.objectMapper = objectMapper;
  }

  public SkillExecution execute(
      AnalysisSkillVersion rule, AnalysisSkillVersion template, String ruleMarkdown,
      String templateMarkdown, String sourceSnapshot) {
    AnalysisConfiguration configuration = configurationService.get();
    LlmAnalysisResult analysis = adapter.analyzeSkill(configuration, ruleMarkdown, sourceSnapshot);
    if (analysis.errorSummary() != null) {
      return SkillExecution.ruleFailed(sourceSnapshot, analysis.errorSummary());
    }
    String analysisDraft = unwrapJsonCodeFence(analysis.advisoryText());
    if (!validDraft(analysisDraft)) {
      return SkillExecution.ruleFailed(sourceSnapshot, "规则 Skill 必须返回包含 conclusions 的 JSON 对象");
    }
    Map<String, String> input = new LinkedHashMap<>();
    input.put("analysisDraft", analysisDraft);
    input.put("sourceSummary", templateSummary(sourceSnapshot));
    String templateInput;
    try {
      templateInput = objectMapper.writeValueAsString(input);
    } catch (Exception exception) {
      return SkillExecution.templateFailed(sourceSnapshot, analysisDraft, "模板输入序列化失败");
    }
    LlmAnalysisResult report = adapter.analyzeSkill(configuration, templateMarkdown, templateInput);
    if (report.errorSummary() != null) {
      return SkillExecution.templateFailed(sourceSnapshot, analysisDraft, report.errorSummary());
    }
    return SkillExecution.succeeded(sourceSnapshot, analysisDraft, sanitizeHtml(stripThinkBlock(report.advisoryText())));
  }

  private static String unwrapJsonCodeFence(String draft) {
    if (draft == null) {
      return null;
    }
    String trimmed = draft.trim();
    int codeFenceStart = trimmed.indexOf("```json");
    if (codeFenceStart >= 0) {
      int contentStart = codeFenceStart + 7;
      int codeFenceEnd = trimmed.indexOf("```", contentStart);
      if (codeFenceEnd >= 0) {
        return trimmed.substring(contentStart, codeFenceEnd).trim();
      }
    }
    return trimmed;
  }

  private boolean validDraft(String draft) {
    try {
      JsonNode root = objectMapper.readTree(draft);
      return root.isObject() && root.path("conclusions").isArray();
    } catch (Exception exception) {
      return false;
    }
  }

  private String templateSummary(String sourceSnapshot) {
    try {
      JsonNode root = objectMapper.readTree(sourceSnapshot);
      List<JsonNode> tasks = new ArrayList<>();
      root.path("tasks").forEach(tasks::add);
      Map<String, Object> summary = new LinkedHashMap<>();
      summary.put("period", root.path("period").asText());
      summary.put("periodStart", root.path("periodStart").asText());
      summary.put("periodEnd", root.path("periodEnd").asText());
      summary.put("dailyReporting", Map.of(
          "statisticsAvailable", !root.path("statistics").isEmpty(),
          "workdaysAvailable", !root.path("workdays").isEmpty(),
          "taskCount", tasks.size()));
      summary.put("personnelEffectiveness", Map.of(
          "teamTaskCounts", count(tasks, "team_name"),
          "statusCounts", count(tasks, "current_status")));
      summary.put("projectManagement", Map.of(
          "projectTaskCounts", count(tasks, "project_name"),
          "projectStateRecords", root.path("projectStates").size()));
      summary.put("resourceCoordination", Map.of(
          "blockedTaskCount", tasks.stream().filter(task -> "blocked".equals(task.path("current_status").asText())).count(),
          "issueTypeCounts", count(tasks, "issue_type"),
          "collaborationRoleCounts", count(tasks, "collaboration_role")));
      return objectMapper.writeValueAsString(summary);
    } catch (Exception exception) {
      throw new IllegalArgumentException("Unable to build template summary", exception);
    }
  }

  private static Map<String, Long> count(List<JsonNode> tasks, String field) {
    Map<String, Long> counts = new LinkedHashMap<>();
    for (JsonNode task : tasks) {
      String value = task.path(field).asText("");
      if (!value.isBlank()) {
        counts.merge(value, 1L, Long::sum);
      }
    }
    return counts;
  }

  private static String stripThinkBlock(String value) {
    return value == null ? "" : value.replaceAll("(?is)<think>.*?</think>", "").trim();
  }

  private static String sanitizeHtml(String html) {
    return html.replaceAll("(?is)<script[^>]*>.*?</script>", "")
        .replaceAll("(?i)\\son\\w+\\s*=\\s*(['\"]).*?\\1", "")
        .replaceAll("(?i)(href|src)\\s*=\\s*(['\"])(?:javascript:|https?://).*?\\2", "");
  }

  public record SkillExecution(String status, String sourceSnapshot, String analysisDraft,
      String renderedHtml, String errorSummary) {
    static SkillExecution succeeded(String snapshot, String draft, String html) {
      return new SkillExecution("SUCCEEDED", snapshot, draft, html, null);
    }
    static SkillExecution ruleFailed(String snapshot, String error) {
      return new SkillExecution("RULE_FAILED", snapshot, null, null, error);
    }
    static SkillExecution templateFailed(String snapshot, String draft, String error) {
      return new SkillExecution("TEMPLATE_FAILED", snapshot, draft, null, error);
    }
  }
}
