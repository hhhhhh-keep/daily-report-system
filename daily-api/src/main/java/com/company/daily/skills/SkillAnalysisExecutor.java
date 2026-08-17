package com.company.daily.skills;

import com.company.daily.analysis.LlmAnalysisAdapter;
import com.company.daily.analysis.LlmAnalysisResult;
import com.company.daily.configuration.AnalysisConfiguration;
import com.company.daily.configuration.AnalysisConfigurationService;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tools.jackson.databind.JsonNode;
import tools.jackson.databind.ObjectMapper;
import tools.jackson.databind.node.ArrayNode;
import tools.jackson.databind.node.ObjectNode;

@Service
public class SkillAnalysisExecutor {
  private static final Pattern JSON_CODE_FENCE =
      Pattern.compile("(?is)```(?:json)?\\s*(.*?)\\s*```");
  private static final Logger LOGGER = LoggerFactory.getLogger(SkillAnalysisExecutor.class);
  private final AnalysisConfigurationService configurationService;
  private final LlmAnalysisAdapter adapter;
  private final ObjectMapper objectMapper;
  private final SkillPackageValidator packageValidator;
  private final DailyDataPackageAssembler dataPackageAssembler;
  private final SkillScriptRuntime scriptRuntime;

  @Autowired
  public SkillAnalysisExecutor(
      AnalysisConfigurationService configurationService,
      LlmAnalysisAdapter adapter,
      ObjectMapper objectMapper,
      SkillPackageValidator packageValidator,
      DailyDataPackageAssembler dataPackageAssembler,
      SkillScriptRuntime scriptRuntime) {
    this.configurationService = configurationService;
    this.adapter = adapter;
    this.objectMapper = objectMapper;
    this.packageValidator = packageValidator;
    this.dataPackageAssembler = dataPackageAssembler;
    this.scriptRuntime = scriptRuntime;
  }

  public SkillAnalysisExecutor(
      AnalysisConfigurationService configurationService,
      LlmAnalysisAdapter adapter,
      ObjectMapper objectMapper) {
    this(configurationService, adapter, objectMapper, null, null, null);
  }

  public SkillExecution execute(
      AnalysisSkillVersion rule, AnalysisSkillVersion template, String ruleMarkdown,
      String templateMarkdown, String sourceSnapshot) {
    AnalysisConfiguration configuration = configurationService.get();
    LlmAnalysisResult analysis = adapter.analyzeSkill(configuration, ruleMarkdown, sourceSnapshot);
    if (analysis.errorSummary() != null) {
      return SkillExecution.ruleFailed(sourceSnapshot, analysis.errorSummary());
    }
    String analysisDraft = extractJsonDraft(analysis.advisoryText());
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

  public SkillExecution execute(
      AnalysisSkillVersion rule, AnalysisSkillVersion template, String ruleMarkdown,
      String templateMarkdown, String sourceSnapshot, byte[] rulePackage, byte[] templatePackage) {
    SkillPackageValidator.ValidatedSkillPackage validatedRule = packageValidator.validate(rulePackage);
    SkillPackageValidator.ValidatedSkillPackage validatedTemplate = packageValidator.validate(templatePackage);
    boolean scriptedRule = validatedRule.manifest() != null;
    boolean scriptedTemplate = validatedTemplate.manifest() != null;
    if (!scriptedRule && !scriptedTemplate) {
      return execute(rule, template, ruleMarkdown, templateMarkdown, sourceSnapshot);
    }
    if (!scriptedRule || !scriptedTemplate) {
      return SkillExecution.ruleFailed(sourceSnapshot, "规则与模板必须使用相同的 Skill 运行模式");
    }
    byte[] facts;
    try {
      byte[] dataPackage = dataPackageAssembler.assemble(sourceSnapshot);
      String reportDate = objectMapper.readTree(sourceSnapshot).path("periodEnd").asText();
      facts = scriptRuntime.prepareFacts(rulePackage, dataPackage, reportDate);
    } catch (Exception exception) {
      LOGGER.warn("Deterministic daily facts generation failed", exception);
      return SkillExecution.ruleFailed(sourceSnapshot, "确定性日报事实生成失败");
    }
    String analysisDraft = null;
    String factsJson = new String(facts, StandardCharsets.UTF_8);
    if (!hasEvidence(factsJson)) {
      return factsOnly(sourceSnapshot, templatePackage, facts,
          "skipped",
          "该周期无日报证据，未调用 AI，已生成基础报告");
    }
    AnalysisConfiguration configuration = configurationService.get();
    String modelInstructions = validatedRule.analysisInstructions();
    try {
      LlmAnalysisResult analysis = adapter.analyzeSkill(configuration, modelInstructions, factsJson);
      if (analysis.errorSummary() != null) {
        LOGGER.warn("AI skill analysis call failed: {}", analysis.errorSummary());
        return factsOnly(sourceSnapshot, templatePackage, facts,
            "failed", "AI 语义分析不可用，已生成基础报告");
      }
      analysisDraft = bindSummaryEvidence(
          unwrapJsonCodeFence(analysis.advisoryText()), factsJson);
      rejectErrorPlaceholder(analysisDraft);
      byte[] analysisBytes = analysisDraft.getBytes(StandardCharsets.UTF_8);
      scriptRuntime.validateAnalysis(rulePackage, facts, analysisBytes);
    } catch (Exception exception) {
      LOGGER.warn("Initial AI analysis validation failed; retrying once", exception);
      try {
        String repairInstructions = modelInstructions + "\n\n# Repair requirement\n"
            + "Repair the candidate. Return a syntactically valid JSON object only. "
            + "Do not invent data or identifiers. The efficiency_insights, continuity_analysis, "
            + "association_analysis, risk_items, and next_day_actions fields must each be JSON arrays. "
            + "Do not omit a required section when the facts contain the corresponding evidence.";
        String errorMessage = exception.getMessage() == null
            ? exception.getClass().getSimpleName() : exception.getMessage();
        String validationError = errorMessage.substring(0, Math.min(errorMessage.length(), 6000));
        LlmAnalysisResult repair = adapter.analyzeSkill(configuration, repairInstructions,
            Map.of("facts", factsJson, "invalidDraft", analysisDraft == null ? "" : analysisDraft,
                "validationError", validationError));
        if (repair.errorSummary() != null) {
          throw new IllegalArgumentException(repair.errorSummary());
        }
        analysisDraft = bindSummaryEvidence(
            unwrapJsonCodeFence(repair.advisoryText()), factsJson);
        rejectErrorPlaceholder(analysisDraft);
        scriptRuntime.validateAnalysis(rulePackage, facts,
            analysisDraft.getBytes(StandardCharsets.UTF_8));
      } catch (Exception repairException) {
        LOGGER.warn("AI analysis repair validation failed; rendering facts-only report", repairException);
        return factsOnly(sourceSnapshot, templatePackage, facts,
            "failed",
            "AI 语义分析未通过证据校验，已生成基础报告");
      }
    }
    try {
      byte[] analysisBytes = analysisDraft.getBytes(StandardCharsets.UTF_8);
      byte[] document = scriptRuntime.renderDocument(templatePackage, facts, analysisBytes);
      String preview = "<section class=\"daily-analysis-report\"><h2>日报分析报告</h2>"
          + "<p>确定性校验通过，Word 报告已生成。</p></section>";
      return SkillExecution.succeededDocument(sourceSnapshot, analysisDraft, preview, document);
    } catch (Exception exception) {
      LOGGER.warn("Daily Word report generation failed", exception);
      return SkillExecution.templateFailed(sourceSnapshot, analysisDraft, "Word 报告生成失败");
    }
  }

  private SkillExecution factsOnly(
      String sourceSnapshot, byte[] templatePackage, byte[] facts, String aiStatus, String warning) {
    try {
      byte[] document = scriptRuntime.renderDocument(templatePackage, facts, null);
      String preview = "<section class=\"daily-analysis-report\"><h2>日报基础报告</h2><p>" + warning
          + "。</p></section>";
      return SkillExecution.succeededFallback(sourceSnapshot, preview, document, aiStatus, warning);
    } catch (Exception exception) {
      LOGGER.warn("Facts-only daily Word report generation failed", exception);
      return SkillExecution.templateFailed(sourceSnapshot, null, "基础 Word 报告生成失败");
    }
  }

  private static String unwrapJsonCodeFence(String draft) {
    if (draft == null) {
      return null;
    }
    String normalized = stripThinkBlock(draft).trim();
    Matcher matcher = JSON_CODE_FENCE.matcher(normalized);
    if (matcher.find()) {
      return matcher.group(1).trim();
    }
    int objectStart = normalized.indexOf('{');
    int objectEnd = normalized.lastIndexOf('}');
    if (objectStart >= 0 && objectEnd > objectStart) {
      return normalized.substring(objectStart, objectEnd + 1).trim();
    }
    return normalized;
  }

  private String bindSummaryEvidence(String draft, String factsJson) {
    try {
      JsonNode candidate = objectMapper.readTree(draft);
      JsonNode facts = objectMapper.readTree(factsJson);
      normalizeSingletonSections(candidate);
      Set<String> knownEvidenceIds = new LinkedHashSet<>();
      for (JsonNode evidence : facts.path("evidence")) {
        String evidenceId = evidence.path("evidence_id").asText();
        if (!evidenceId.isBlank()) {
          knownEvidenceIds.add(evidenceId);
        }
      }
      sanitizeReferences(candidate, "person_ids", collectKnownValues(facts, "person_id"));
      sanitizeReferences(candidate, "evidence_ids", knownEvidenceIds);
      sanitizeProjectReferences(candidate, collectKnownValues(facts, "project_id"),
          collectKnownValues(facts, "project_candidate_id"));
      Set<String> reconstructedProjectIds = new LinkedHashSet<>(
          collectKnownValues(facts, "project_candidate_id"));
      collectReconstructedProjectIds(facts, reconstructedProjectIds);
      markReconstructedProjectLimitations(candidate, reconstructedProjectIds);
      for (String summaryField : List.of("overall_judgment", "work_summary")) {
        JsonNode summary = candidate.path(summaryField);
        JsonNode evidenceIds = summary.path("evidence_ids");
        if (!(summary instanceof ObjectNode summaryObject) || !evidenceIds.isArray()) {
          continue;
        }
        List<String> validCandidateIds = new ArrayList<>();
        for (JsonNode evidenceId : evidenceIds) {
          String value = evidenceId.asText();
          if (knownEvidenceIds.contains(value)) {
            validCandidateIds.add(value);
          }
        }
        summaryObject.withArray("evidence_ids").removeAll();
        (validCandidateIds.isEmpty() ? knownEvidenceIds : validCandidateIds)
            .forEach(value -> summaryObject.withArray("evidence_ids").add(value));
      }
      for (String section : List.of(
          "efficiency_insights", "project_highlights", "continuity_analysis",
          "association_analysis", "risk_items", "next_day_actions")) {
        JsonNode items = candidate.path(section);
        if (items instanceof ArrayNode array) {
          array.removeIf(item -> !item.path("evidence_ids").isArray()
              || item.path("evidence_ids").isEmpty());
        }
      }
      return objectMapper.writeValueAsString(candidate);
    } catch (Exception exception) {
      return draft;
    }
  }

  private void normalizeSingletonSections(JsonNode candidate) {
    if (!(candidate instanceof ObjectNode object)) {
      return;
    }
    for (String section : List.of(
        "efficiency_insights", "project_highlights", "continuity_analysis",
        "association_analysis", "risk_items", "next_day_actions")) {
      JsonNode value = object.get(section);
      if (value != null && value.isObject()) {
        ArrayNode normalized = objectMapper.createArrayNode();
        normalized.add(value);
        object.set(section, normalized);
      }
    }
  }

  private void markReconstructedProjectLimitations(JsonNode node, Set<String> candidateIds) {
    if (node == null) {
      return;
    }
    if (node instanceof ObjectNode object) {
      String projectId = object.path("project_id").asText("");
      JsonNode limitation = object.get("limitation_note");
      if (candidateIds.contains(projectId)
          && (limitation == null || limitation.isNull() || limitation.asText("").isBlank())) {
        object.put("limitation_note", "该项目由日报文本重建，需人工核验项目名称与归并关系。");
      }
      object.properties().forEach(entry ->
          markReconstructedProjectLimitations(entry.getValue(), candidateIds));
    } else if (node.isArray()) {
      node.forEach(item -> markReconstructedProjectLimitations(item, candidateIds));
    }
  }

  private void collectReconstructedProjectIds(JsonNode node, Set<String> projectIds) {
    if (node == null) {
      return;
    }
    if (node.isObject()) {
      if ("reconstructed".equals(node.path("snapshot_origin").asText())) {
        String projectId = node.path("project_id").asText("");
        if (!projectId.isBlank()) {
          projectIds.add(projectId);
        }
      }
      node.properties().forEach(entry ->
          collectReconstructedProjectIds(entry.getValue(), projectIds));
    } else if (node.isArray()) {
      node.forEach(item -> collectReconstructedProjectIds(item, projectIds));
    }
  }

  private Set<String> collectKnownValues(JsonNode node, String fieldName) {
    Set<String> values = new LinkedHashSet<>();
    collectKnownValues(node, fieldName, values);
    return values;
  }

  private void collectKnownValues(JsonNode node, String fieldName, Set<String> values) {
    if (node == null) {
      return;
    }
    if (node.isObject()) {
      node.properties().forEach(entry -> {
        if (entry.getKey().equals(fieldName) && entry.getValue().isTextual()
            && !entry.getValue().asText().isBlank()) {
          values.add(entry.getValue().asText());
        }
        collectKnownValues(entry.getValue(), fieldName, values);
      });
    } else if (node.isArray()) {
      node.forEach(item -> collectKnownValues(item, fieldName, values));
    }
  }

  private void sanitizeReferences(JsonNode node, String fieldName, Set<String> knownValues) {
    if (node == null) {
      return;
    }
    if (node.isObject()) {
      node.properties().forEach(entry -> {
        if (entry.getKey().equals(fieldName) && entry.getValue() instanceof ArrayNode references) {
          Set<String> seen = new LinkedHashSet<>();
          references.removeIf(reference -> !reference.isTextual()
              || !knownValues.contains(reference.asText()) || !seen.add(reference.asText()));
        } else {
          sanitizeReferences(entry.getValue(), fieldName, knownValues);
        }
      });
    } else if (node.isArray()) {
      node.forEach(item -> sanitizeReferences(item, fieldName, knownValues));
    }
  }

  private void sanitizeProjectReferences(
      JsonNode node, Set<String> knownProjectIds, Set<String> knownCandidateIds) {
    Set<String> knownValues = new LinkedHashSet<>(knownProjectIds);
    knownValues.addAll(knownCandidateIds);
    if (node == null) {
      return;
    }
    if (node.isObject()) {
      node.properties().forEach(entry -> {
        if (entry.getKey().equals("project_id") && entry.getValue().isTextual()
            && !knownValues.contains(entry.getValue().asText()) && node instanceof ObjectNode object) {
          object.putNull("project_id");
        } else {
          sanitizeProjectReferences(entry.getValue(), knownProjectIds, knownCandidateIds);
        }
      });
    } else if (node.isArray()) {
      node.forEach(item -> sanitizeProjectReferences(item, knownProjectIds, knownCandidateIds));
    }
  }

  private void rejectErrorPlaceholder(String draft) {
    try {
      if (containsErrorPlaceholder(objectMapper.readTree(draft))) {
        throw new IllegalArgumentException("Model returned an error placeholder instead of analysis");
      }
    } catch (IllegalArgumentException exception) {
      throw exception;
    } catch (Exception exception) {
      // Syntax and schema errors are reported by the packaged validator below.
    }
  }

  private boolean containsErrorPlaceholder(JsonNode node) {
    if (node == null) {
      return false;
    }
    if (node.isObject()) {
      for (Map.Entry<String, JsonNode> entry : node.properties()) {
        if (entry.getKey().equals("summary") && entry.getValue().isTextual()) {
          String summary = entry.getValue().asText().toLowerCase();
          if (summary.contains("invalid input")
              || summary.contains("data package or evidence is empty or unreadable")
              || summary.contains("事实包不完整或未提供")
              || summary.contains("无法生成整体判断")
              || summary.contains("未调用模型或模型结果未通过校验")) {
            return true;
          }
        }
        if (containsErrorPlaceholder(entry.getValue())) {
          return true;
        }
      }
      return false;
    }
    if (node.isArray()) {
      for (JsonNode item : node) {
        if (containsErrorPlaceholder(item)) {
          return true;
        }
      }
    }
    return false;
  }

  private boolean hasEvidence(String factsJson) {
    try {
      JsonNode evidence = objectMapper.readTree(factsJson).path("evidence");
      return evidence.isArray() && !evidence.isEmpty();
    } catch (Exception exception) {
      return false;
    }
  }

  private String extractJsonDraft(String output) {
    String candidate = unwrapJsonCodeFence(stripThinkBlock(output));
    if (validDraft(candidate) || candidate == null) {
      return candidate;
    }
    int objectStart = candidate.indexOf('{');
    int objectEnd = candidate.lastIndexOf('}');
    if (objectStart >= 0 && objectEnd > objectStart) {
      return candidate.substring(objectStart, objectEnd + 1).trim();
    }
    return candidate;
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
      String renderedHtml, byte[] renderedDocument, String aiStatus, String errorSummary) {
    static SkillExecution succeeded(String snapshot, String draft, String html) {
      return new SkillExecution("SUCCEEDED", snapshot, draft, html, null, "succeeded", null);
    }
    static SkillExecution succeededDocument(String snapshot, String draft, String html, byte[] document) {
      return new SkillExecution("SUCCEEDED", snapshot, draft, html, document, "succeeded", null);
    }
    static SkillExecution succeededFallback(
        String snapshot, String html, byte[] document, String aiStatus, String warning) {
      return new SkillExecution("SUCCEEDED", snapshot, null, html, document, aiStatus, warning);
    }
    static SkillExecution ruleFailed(String snapshot, String error) {
      return new SkillExecution("RULE_FAILED", snapshot, null, null, null, "failed", error);
    }
    static SkillExecution templateFailed(String snapshot, String draft, String error) {
      String aiStatus = draft == null ? "failed" : "succeeded";
      return new SkillExecution("TEMPLATE_FAILED", snapshot, draft, null, null, aiStatus, error);
    }
  }
}
