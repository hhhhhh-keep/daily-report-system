package com.company.daily.skills;

import static org.assertj.core.api.Assertions.assertThat;

import com.company.daily.analysis.LlmAnalysisAdapter;
import com.company.daily.analysis.LlmAnalysisResult;
import com.company.daily.config.EnvironmentProperties;
import com.company.daily.configuration.AnalysisConfiguration;
import com.company.daily.configuration.AnalysisConfigurationService;
import java.util.List;
import java.util.Map;
import java.io.ByteArrayOutputStream;
import java.nio.charset.StandardCharsets;
import java.util.LinkedHashMap;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import org.junit.jupiter.api.Test;
import tools.jackson.databind.ObjectMapper;

class SkillAnalysisExecutorTest {
  @Test
  void acceptsRuleOutputWrappedInAJsonCodeFence() {
    SkillAnalysisExecutor executor = new SkillAnalysisExecutor(
        new StubConfigurationService(), new StubAdapter(), new ObjectMapper());

    SkillAnalysisExecutor.SkillExecution result = executor.execute(
        null, null, "rule", "template", """
        {"period":"DAILY","periodStart":"2026-07-31","periodEnd":"2026-07-31",
        "statistics":[],"workdays":[],"projectStates":[],
        "tasks":[{"employee_name":"Alice","team_name":"Delivery","project_name":"Project A",
        "current_status":"blocked","collaboration_requirement":"vendor input",
        "progress_result":"raw task detail must not be sent"}]}
        """);

    assertThat(result.status()).isEqualTo("SUCCEEDED");
    assertThat(result.analysisDraft()).contains("conclusions");
    assertThat(result.renderedHtml()).isEqualTo("<section class=\"daily-analysis-report\"></section>");
  }

  @Test
  void acceptsRuleJsonAfterReasoningAndAPlainTextPreamble() {
    SkillAnalysisExecutor executor = new SkillAnalysisExecutor(
        new StubConfigurationService(), new PlainJsonStubAdapter(), new ObjectMapper());

    SkillAnalysisExecutor.SkillExecution result = executor.execute(
        null, null, "rule", "template", """
        {"period":"DAILY","periodStart":"2026-08-11","periodEnd":"2026-08-11",
        "statistics":[],"workdays":[],"projectStates":[],"tasks":[]}
        """);

    assertThat(result.status()).isEqualTo("SUCCEEDED");
    assertThat(result.analysisDraft()).isEqualTo("{\"conclusions\":[],\"summary\":\"ok\"}");
  }

  @Test
  void dispatchesScriptedPairThroughDeterministicRuntime() throws Exception {
    ObjectMapper mapper = new ObjectMapper();
    SkillAnalysisExecutor executor = new SkillAnalysisExecutor(new StubConfigurationService(),
        new ScriptedStubAdapter(), mapper, new SkillPackageValidator(), new DailyDataPackageAssembler(mapper),
        new StubScriptRuntime());
    byte[] rulePackage = scriptedPackage("daily-rule", "prepare_facts", "scripts/run_prepare_facts.py");
    byte[] templatePackage = scriptedPackage("daily-template", "render_docx", "scripts/run_render_docx.py");

    SkillAnalysisExecutor.SkillExecution result = executor.execute(null, null, "rule", "template", """
        {"period":"DAILY","periodStart":"2026-07-31","periodEnd":"2026-07-31",
         "workdays":[],"roster":[],"reports":[],"tasks":[]}
        """, rulePackage, templatePackage);

    assertThat(result.status()).isEqualTo("SUCCEEDED");
    assertThat(result.aiStatus()).isEqualTo("succeeded");
    assertThat(result.analysisDraft()).contains("work_summary");
    assertThat(result.renderedDocument()).containsExactly("docx".getBytes(StandardCharsets.UTF_8));
    assertThat(result.renderedHtml())
        .contains("应填写人数：3人。")
        .contains("截至17:30：已填写1人，填写率33.33%。")
        .contains("截至22:00：已填写2人，填写率66.67%。")
        .contains("未填写人员：未填人员。")
        .doesNotContain("确定性校验通过", "Word 报告已生成");
  }

  @Test
  void bindsKnownEvidenceToVersion11OverallJudgment() throws Exception {
    ObjectMapper mapper = new ObjectMapper();
    CapturingScriptRuntime runtime = new CapturingScriptRuntime();
    SkillAnalysisExecutor executor = new SkillAnalysisExecutor(new StubConfigurationService(),
        new Version11ScriptedAdapter(), mapper, new SkillPackageValidator(),
        new DailyDataPackageAssembler(mapper), runtime);
    byte[] rulePackage = scriptedPackage("daily-rule", "prepare_facts", "scripts/run_prepare_facts.py");
    byte[] templatePackage = scriptedPackage("daily-template", "render_docx", "scripts/run_render_docx.py");

    SkillAnalysisExecutor.SkillExecution result = executor.execute(null, null, "rule", "template", """
        {"period":"DAILY","periodStart":"2026-07-31","periodEnd":"2026-07-31",
         "workdays":[],"roster":[],"reports":[],"tasks":[]}
        """, rulePackage, templatePackage);

    assertThat(result.status()).isEqualTo("SUCCEEDED");
    assertThat(runtime.validatedAnalysis).contains("\"overall_judgment\"")
        .contains("\"evidence_ids\":[\"evidence-1\"]");
  }

  @Test
  void removesUnsupportedConclusionItemsBeforeEvidenceValidation() throws Exception {
    ObjectMapper mapper = new ObjectMapper();
    CapturingScriptRuntime runtime = new CapturingScriptRuntime();
    SkillAnalysisExecutor executor = new SkillAnalysisExecutor(new StubConfigurationService(),
        new UnsupportedReferencesAdapter(), mapper, new SkillPackageValidator(),
        new DailyDataPackageAssembler(mapper), runtime);
    byte[] rulePackage = scriptedPackage("daily-rule", "prepare_facts", "scripts/run_prepare_facts.py");
    byte[] templatePackage = scriptedPackage("daily-template", "render_docx", "scripts/run_render_docx.py");

    SkillAnalysisExecutor.SkillExecution result = executor.execute(null, null, "rule", "template", """
        {"period":"DAILY","periodStart":"2026-07-31","periodEnd":"2026-07-31",
         "workdays":[],"roster":[],"reports":[],"tasks":[]}
        """, rulePackage, templatePackage);

    assertThat(result.status()).isEqualTo("SUCCEEDED");
    assertThat(runtime.validatedAnalysis)
        .contains("\"overall_judgment\"")
        .contains("\"evidence_ids\":[\"evidence-1\"]")
        .contains("\"risk_items\":[]")
        .doesNotContain("fake-evidence", "fake-person", "fake-project");
  }

  @Test
  void removesDuplicateEvidenceReferencesBeforeValidation() throws Exception {
    ObjectMapper mapper = new ObjectMapper();
    CapturingScriptRuntime runtime = new CapturingScriptRuntime();
    SkillAnalysisExecutor executor = new SkillAnalysisExecutor(new StubConfigurationService(),
        new DuplicateReferencesAdapter(), mapper, new SkillPackageValidator(),
        new DailyDataPackageAssembler(mapper), runtime);
    byte[] rulePackage = scriptedPackage("daily-rule", "prepare_facts", "scripts/run_prepare_facts.py");
    byte[] templatePackage = scriptedPackage("daily-template", "render_docx", "scripts/run_render_docx.py");

    SkillAnalysisExecutor.SkillExecution result = executor.execute(null, null, "rule", "template", """
        {"period":"DAILY","periodStart":"2026-07-31","periodEnd":"2026-07-31",
         "workdays":[],"roster":[],"reports":[],"tasks":[]}
        """, rulePackage, templatePackage);

    assertThat(result.aiStatus()).isEqualTo("succeeded");
    assertThat(runtime.validatedAnalysis)
        .contains("\"evidence_ids\":[\"evidence-1\"]")
        .doesNotContain("\"evidence-1\",\"evidence-1\"");
  }

  @Test
  void normalizesVersion12SingletonSectionsWithoutAddingProjectAssociationWarnings() throws Exception {
    ObjectMapper mapper = new ObjectMapper();
    CapturingScriptRuntime runtime = new CapturingScriptRuntime();
    SkillAnalysisExecutor executor = new SkillAnalysisExecutor(new StubConfigurationService(),
        new Version12SingletonSectionsAdapter(), mapper, new SkillPackageValidator(),
        new DailyDataPackageAssembler(mapper), runtime);
    byte[] rulePackage = scriptedPackage("daily-rule", "prepare_facts", "scripts/run_prepare_facts.py");
    byte[] templatePackage = scriptedPackage("daily-template", "render_docx", "scripts/run_render_docx.py");

    SkillAnalysisExecutor.SkillExecution result = executor.execute(null, null, "rule", "template", """
        {"period":"DAILY","periodStart":"2026-07-31","periodEnd":"2026-07-31",
         "workdays":[],"roster":[],"reports":[],"tasks":[]}
        """, rulePackage, templatePackage);

    assertThat(result.aiStatus()).isEqualTo("succeeded");
    assertThat(runtime.validatedAnalysis)
        .contains("\"efficiency_insights\":[{")
        .contains("\"continuity_analysis\":[{")
        .contains("\"association_analysis\":[{")
        .contains("\"risk_items\":[{")
        .contains("\"next_day_actions\":[{")
        .contains("\"project_id\":\"project-candidate-1\"")
        .contains("\"project_id\":\"project-reconstructed-1\"")
        .contains("\"limitation_note\":null");
    assertThat(mapper.readTree(runtime.validatedAnalysis)
        .path("next_day_actions").path(0).path("limitation_note").asText())
        .isEmpty();
  }

  @Test
  void rejectsModelErrorPlaceholderAsSuccessfulAnalysis() throws Exception {
    ObjectMapper mapper = new ObjectMapper();
    SkillAnalysisExecutor executor = new SkillAnalysisExecutor(new StubConfigurationService(),
        new ErrorPlaceholderAdapter(), mapper, new SkillPackageValidator(),
        new DailyDataPackageAssembler(mapper), new StubScriptRuntime());
    byte[] rulePackage = scriptedPackage("daily-rule", "prepare_facts", "scripts/run_prepare_facts.py");
    byte[] templatePackage = scriptedPackage("daily-template", "render_docx", "scripts/run_render_docx.py");

    SkillAnalysisExecutor.SkillExecution result = executor.execute(null, null, "rule", "template", """
        {"period":"DAILY","periodStart":"2026-07-31","periodEnd":"2026-07-31",
         "workdays":[],"roster":[],"reports":[],"tasks":[]}
        """, rulePackage, templatePackage);

    assertThat(result.aiStatus()).isEqualTo("failed");
    assertThat(result.analysisDraft()).isNull();
  }

  @Test
  void rejectsChineseModelErrorPlaceholderAsSuccessfulAnalysis() throws Exception {
    ObjectMapper mapper = new ObjectMapper();
    SkillAnalysisExecutor executor = new SkillAnalysisExecutor(new StubConfigurationService(),
        new ChineseErrorPlaceholderAdapter(), mapper, new SkillPackageValidator(),
        new DailyDataPackageAssembler(mapper), new StubScriptRuntime());
    byte[] rulePackage = scriptedPackage("daily-rule", "prepare_facts", "scripts/run_prepare_facts.py");
    byte[] templatePackage = scriptedPackage("daily-template", "render_docx", "scripts/run_render_docx.py");

    SkillAnalysisExecutor.SkillExecution result = executor.execute(null, null, "rule", "template", """
        {"period":"DAILY","periodStart":"2026-07-31","periodEnd":"2026-07-31",
         "workdays":[],"roster":[],"reports":[],"tasks":[]}
        """, rulePackage, templatePackage);

    assertThat(result.aiStatus()).isEqualTo("failed");
    assertThat(result.analysisDraft()).isNull();
  }

  @Test
  void rendersFactsOnlyDocumentWhenModelAnalysisFailsEvidenceValidation() throws Exception {
    ObjectMapper mapper = new ObjectMapper();
    RejectingAnalysisRuntime runtime = new RejectingAnalysisRuntime();
    SkillAnalysisExecutor executor = new SkillAnalysisExecutor(new StubConfigurationService(),
        new ScriptedStubAdapter(), mapper, new SkillPackageValidator(), new DailyDataPackageAssembler(mapper),
        runtime);
    byte[] rulePackage = scriptedPackage("daily-rule", "prepare_facts", "scripts/run_prepare_facts.py");
    byte[] templatePackage = scriptedPackage("daily-template", "render_docx", "scripts/run_render_docx.py");

    SkillAnalysisExecutor.SkillExecution result = executor.execute(null, null, "rule", "template", """
        {"period":"DAILY","periodStart":"2026-07-31","periodEnd":"2026-07-31",
         "workdays":[],"roster":[],"reports":[],"tasks":[]}
        """, rulePackage, templatePackage);

    assertThat(result.status()).isEqualTo("SUCCEEDED");
    assertThat(result.aiStatus()).isEqualTo("failed");
    assertThat(result.analysisDraft()).isNull();
    assertThat(result.errorSummary()).contains("基础报告");
    assertThat(result.errorSummary()).doesNotContain("校验摘要").doesNotContain("invalid_analysis");
    assertThat(result.renderedDocument()).containsExactly("facts-only".getBytes(StandardCharsets.UTF_8));
    assertThat(runtime.factsOnlyRendered).isTrue();
  }

  @Test
  void skipsTheModelWhenThePeriodContainsNoReportEvidence() throws Exception {
    ObjectMapper mapper = new ObjectMapper();
    CountingScriptedAdapter adapter = new CountingScriptedAdapter();
    SkillAnalysisExecutor executor = new SkillAnalysisExecutor(new StubConfigurationService(),
        adapter, mapper, new SkillPackageValidator(), new DailyDataPackageAssembler(mapper),
        new NoEvidenceRuntime());
    byte[] rulePackage = scriptedPackage("daily-rule", "prepare_facts", "scripts/run_prepare_facts.py");
    byte[] templatePackage = scriptedPackage("daily-template", "render_docx", "scripts/run_render_docx.py");

    SkillAnalysisExecutor.SkillExecution result = executor.execute(null, null, "rule", "template", """
        {"period":"DAILY","periodStart":"2026-08-14","periodEnd":"2026-08-14",
         "workdays":[],"roster":[],"reports":[],"tasks":[]}
        """, rulePackage, templatePackage);

    assertThat(adapter.calls).isZero();
    assertThat(result.status()).isEqualTo("SUCCEEDED");
    assertThat(result.aiStatus()).isEqualTo("skipped");
    assertThat(result.analysisDraft()).isNull();
    assertThat(result.errorSummary()).contains("无日报证据");
  }

  @Test
  void normalizesThinkBlocksAndCaseInsensitiveJsonFencesBeforeValidation() throws Exception {
    ObjectMapper mapper = new ObjectMapper();
    JsonCheckingRuntime runtime = new JsonCheckingRuntime(mapper);
    SkillAnalysisExecutor executor = new SkillAnalysisExecutor(new StubConfigurationService(),
        new ThinkWrappedScriptedAdapter(), mapper, new SkillPackageValidator(),
        new DailyDataPackageAssembler(mapper), runtime);
    byte[] rulePackage = scriptedPackage("daily-rule", "prepare_facts", "scripts/run_prepare_facts.py");
    byte[] templatePackage = scriptedPackage("daily-template", "render_docx", "scripts/run_render_docx.py");

    SkillAnalysisExecutor.SkillExecution result = executor.execute(null, null, "rule", "template", """
        {"period":"DAILY","periodStart":"2026-07-31","periodEnd":"2026-07-31",
         "workdays":[],"roster":[],"reports":[],"tasks":[]}
        """, rulePackage, templatePackage);

    assertThat(result.status()).isEqualTo("SUCCEEDED");
    assertThat(result.errorSummary()).isNull();
    assertThat(result.analysisDraft()).startsWith("{");
    assertThat(runtime.factsOnlyRendered).isFalse();
  }

  @Test
  void retriesOnceWhenTheModelReturnsInvalidAnalysisJson() throws Exception {
    ObjectMapper mapper = new ObjectMapper();
    RejectOnceRuntime runtime = new RejectOnceRuntime();
    RepairingScriptedAdapter adapter = new RepairingScriptedAdapter();
    SkillAnalysisExecutor executor = new SkillAnalysisExecutor(new StubConfigurationService(),
        adapter, mapper, new SkillPackageValidator(), new DailyDataPackageAssembler(mapper), runtime);
    byte[] rulePackage = scriptedAnalysisPackage(
        "daily-rule", "prepare_facts", "scripts/run_prepare_facts.py");
    byte[] templatePackage = scriptedPackage("daily-template", "render_docx", "scripts/run_render_docx.py");

    SkillAnalysisExecutor.SkillExecution result = executor.execute(null, null, "rule", "template", """
        {"period":"DAILY","periodStart":"2026-07-31","periodEnd":"2026-07-31",
         "workdays":[],"roster":[],"reports":[],"tasks":[]}
        """, rulePackage, templatePackage);

    assertThat(result.status()).isEqualTo("SUCCEEDED");
    assertThat(result.errorSummary()).isNull();
    assertThat(adapter.calls).isEqualTo(2);
    assertThat(runtime.factsOnlyRendered).isFalse();
    assertThat(adapter.firstInstructions).contains("PACKAGED_RULE_REFERENCE")
        .contains("Required analysis JSON Schema").contains("data_contract_version")
        .contains("at most 5 items").contains("12,000 characters");
    assertThat(adapter.repairInstructions).contains("Repair the candidate")
        .contains("Required analysis JSON Schema");
    assertThat(adapter.repairInput.toString()).contains("validationError")
        .contains("SCHEMA_INVALID").contains("invalidDraft").contains("facts");
    assertThat(runtime.repairedAnalysis).contains("\"evidence_ids\":[\"evidence-1\"]");
  }

  private static byte[] scriptedPackage(String name, String entrypointName, String entrypoint) throws Exception {
    try (ByteArrayOutputStream output = new ByteArrayOutputStream(); ZipOutputStream zip = new ZipOutputStream(output)) {
      Map<String, String> entries = Map.of(
          "SKILL.md", "---\nname: " + name + "\ndescription: scripted\n---\n",
          "manifest.json", "{\"format_version\":\"2.0\",\"name\":\"" + name
              + "\",\"runtime_profile\":\"daily-python-3.12-v1\",\"entrypoints\":{\""
              + entrypointName + "\":\"" + entrypoint + "\"},\"permissions\":{\"network\":false}}",
          entrypoint, "print('ok')");
      for (Map.Entry<String, String> entry : entries.entrySet()) {
        zip.putNextEntry(new ZipEntry(entry.getKey()));
        zip.write(entry.getValue().getBytes(StandardCharsets.UTF_8));
        zip.closeEntry();
      }
      return output.toByteArray();
    }
  }

  private static byte[] scriptedAnalysisPackage(
      String name, String entrypointName, String entrypoint) throws Exception {
    Map<String, String> entries = new LinkedHashMap<>();
    entries.put("SKILL.md", "---\nname: " + name + "\ndescription: scripted\n---\nRoot rule.");
    entries.put("manifest.json", "{\"format_version\":\"2.0\",\"name\":\"" + name
        + "\",\"runtime_profile\":\"daily-python-3.12-v1\",\"contracts\":{"
        + "\"analysis\":\"daily-analysis/1.0.0\"},\"entrypoints\":{\"" + entrypointName
        + "\":\"" + entrypoint + "\"},\"permissions\":{\"network\":false}}");
    entries.put(entrypoint, "print('ok')");
    entries.put("references/rules.md", "PACKAGED_RULE_REFERENCE");
    entries.put("schemas/daily-analysis.schema.json", "{\"type\":\"object\","
        + "\"required\":[\"data_contract_version\"]}");
    try (ByteArrayOutputStream output = new ByteArrayOutputStream();
        ZipOutputStream zip = new ZipOutputStream(output)) {
      for (Map.Entry<String, String> entry : entries.entrySet()) {
        zip.putNextEntry(new ZipEntry(entry.getKey()));
        zip.write(entry.getValue().getBytes(StandardCharsets.UTF_8));
        zip.closeEntry();
      }
      return output.toByteArray();
  }
  }

  private static final class StubAdapter extends LlmAnalysisAdapter {
    private int calls;

    StubAdapter() { super(new EnvironmentProperties(), new ObjectMapper()); }

    @Override
    public LlmAnalysisResult analyzeSkill(
        AnalysisConfiguration configuration, String instructions, Object input) {
      calls++;
      if (calls == 1) {
        return new LlmAnalysisResult("succeeded", "<think>reasoning</think>\n```json\n{\"conclusions\":[]}\n```", null);
      }
      assertThat(input).isInstanceOf(String.class);
      assertThat((String) input).contains("analysisDraft").contains("sourceSummary")
          .contains("dailyReporting").contains("personnelEffectiveness").contains("projectManagement")
          .contains("resourceCoordination").doesNotContain("raw task detail must not be sent");
      return new LlmAnalysisResult("succeeded",
          "<think>reasoning</think><section class=\"daily-analysis-report\"></section>", null);
    }
  }

  private static final class ScriptedStubAdapter extends LlmAnalysisAdapter {
    ScriptedStubAdapter() { super(new EnvironmentProperties(), new ObjectMapper()); }

    @Override
    public LlmAnalysisResult analyzeSkill(AnalysisConfiguration configuration, String instructions, Object input) {
      return new LlmAnalysisResult("succeeded", "{\"work_summary\":{\"summary\":\"ok\",\"evidence_ids\":[]},"
          + "\"project_highlights\":[],\"risk_items\":[],\"next_day_actions\":[]}", null);
    }
  }

  private static final class Version11ScriptedAdapter extends LlmAnalysisAdapter {
    Version11ScriptedAdapter() { super(new EnvironmentProperties(), new ObjectMapper()); }

    @Override
    public LlmAnalysisResult analyzeSkill(AnalysisConfiguration configuration, String instructions, Object input) {
      return new LlmAnalysisResult("succeeded", "{\"data_contract_version\":\"1.1.0\","
          + "\"overall_judgment\":{\"summary\":\"ok\",\"person_ids\":[],\"project_id\":null,"
          + "\"evidence_ids\":[\"unknown\"],\"limitation_note\":null},"
          + "\"efficiency_insights\":[],\"project_highlights\":[],\"risk_items\":[],"
          + "\"next_day_actions\":[]}", null);
    }
  }

  private static final class Version12SingletonSectionsAdapter extends LlmAnalysisAdapter {
    Version12SingletonSectionsAdapter() { super(new EnvironmentProperties(), new ObjectMapper()); }

    @Override
    public LlmAnalysisResult analyzeSkill(AnalysisConfiguration configuration, String instructions, Object input) {
      String item = "{\"summary\":\"ok\",\"person_ids\":[],\"project_id\":null,"
          + "\"evidence_ids\":[\"evidence-1\"],\"limitation_note\":null}";
      String reconstructed = "{\"summary\":\"continuous\",\"person_ids\":[],"
          + "\"project_id\":\"project-candidate-1\",\"evidence_ids\":[\"evidence-1\"],"
          + "\"limitation_note\":null}";
      String reconstructedStatus = "{\"summary\":\"follow up\",\"person_ids\":[],"
          + "\"project_id\":\"project-reconstructed-1\",\"evidence_ids\":[\"evidence-1\"],"
          + "\"limitation_note\":null}";
      return new LlmAnalysisResult("succeeded", "{\"data_contract_version\":\"1.2.0\","
          + "\"overall_judgment\":" + item + ",\"efficiency_insights\":" + item + ","
          + "\"continuity_analysis\":" + reconstructed + ",\"association_analysis\":" + item + ","
          + "\"risk_items\":" + item + ",\"next_day_actions\":" + reconstructedStatus + "}", null);
    }
  }

  private static final class UnsupportedReferencesAdapter extends LlmAnalysisAdapter {
    UnsupportedReferencesAdapter() { super(new EnvironmentProperties(), new ObjectMapper()); }

    @Override
    public LlmAnalysisResult analyzeSkill(AnalysisConfiguration configuration, String instructions, Object input) {
      return new LlmAnalysisResult("succeeded", "{\"data_contract_version\":\"1.1.0\","
          + "\"overall_judgment\":{\"summary\":\"ok\",\"person_ids\":[\"fake-person\"],"
          + "\"project_id\":\"fake-project\",\"evidence_ids\":[\"fake-evidence\"],"
          + "\"limitation_note\":null},\"efficiency_insights\":[],\"project_highlights\":[],"
          + "\"risk_items\":[{\"summary\":\"unsupported\",\"person_ids\":[\"fake-person\"],"
          + "\"project_id\":null,\"evidence_ids\":[],\"limitation_note\":null}],"
          + "\"next_day_actions\":[]}", null);
    }
  }

  private static final class DuplicateReferencesAdapter extends LlmAnalysisAdapter {
    DuplicateReferencesAdapter() { super(new EnvironmentProperties(), new ObjectMapper()); }

    @Override
    public LlmAnalysisResult analyzeSkill(AnalysisConfiguration configuration, String instructions, Object input) {
      return new LlmAnalysisResult("succeeded", "{\"data_contract_version\":\"1.1.0\","
          + "\"overall_judgment\":{\"summary\":\"ok\",\"person_ids\":[],\"project_id\":null,"
          + "\"evidence_ids\":[\"evidence-1\",\"evidence-1\"],\"limitation_note\":null},"
          + "\"efficiency_insights\":[],\"project_highlights\":[],\"risk_items\":[],"
          + "\"next_day_actions\":[]}", null);
    }
  }

  private static final class ErrorPlaceholderAdapter extends LlmAnalysisAdapter {
    ErrorPlaceholderAdapter() { super(new EnvironmentProperties(), new ObjectMapper()); }

    @Override
    public LlmAnalysisResult analyzeSkill(AnalysisConfiguration configuration, String instructions, Object input) {
      return new LlmAnalysisResult("succeeded", "{\"data_contract_version\":\"1.0.0\","
          + "\"work_summary\":{\"summary\":\"Invalid input: data package or evidence is empty or unreadable\","
          + "\"evidence_ids\":[\"evidence-1\"]},\"project_highlights\":[],\"risk_items\":[],"
          + "\"next_day_actions\":[]}", null);
    }
  }

  private static final class ChineseErrorPlaceholderAdapter extends LlmAnalysisAdapter {
    ChineseErrorPlaceholderAdapter() { super(new EnvironmentProperties(), new ObjectMapper()); }

    @Override
    public LlmAnalysisResult analyzeSkill(AnalysisConfiguration configuration, String instructions, Object input) {
      return new LlmAnalysisResult("succeeded", "{\"data_contract_version\":\"1.0.0\","
          + "\"work_summary\":{\"summary\":\"事实包不完整或未提供，无法生成整体判断。\","
          + "\"evidence_ids\":[\"evidence-1\"]},\"project_highlights\":[],\"risk_items\":[],"
          + "\"next_day_actions\":[]}", null);
    }
  }

  private static final class ThinkWrappedScriptedAdapter extends LlmAnalysisAdapter {
    ThinkWrappedScriptedAdapter() { super(new EnvironmentProperties(), new ObjectMapper()); }

    @Override
    public LlmAnalysisResult analyzeSkill(AnalysisConfiguration configuration, String instructions, Object input) {
      return new LlmAnalysisResult("succeeded", "<think>reasoning</think>\n```JSON\n"
          + "{\"work_summary\":{\"summary\":\"ok\",\"evidence_ids\":[]},"
          + "\"project_highlights\":[],\"risk_items\":[],\"next_day_actions\":[]}\n```", null);
    }
  }

  private static final class RepairingScriptedAdapter extends LlmAnalysisAdapter {
    private int calls;
    private String firstInstructions;
    private String repairInstructions;
    private Object repairInput;

    RepairingScriptedAdapter() { super(new EnvironmentProperties(), new ObjectMapper()); }

    @Override
    public LlmAnalysisResult analyzeSkill(AnalysisConfiguration configuration, String instructions, Object input) {
      calls++;
      if (calls == 1) {
        firstInstructions = instructions;
        return new LlmAnalysisResult("succeeded", "{\"work_summary\":{}}", null);
      }
      repairInstructions = instructions;
      repairInput = input;
      return new LlmAnalysisResult("succeeded", "{\"data_contract_version\":\"1.0.0\","
          + "\"work_summary\":{\"summary\":\"ok\",\"evidence_ids\":[\"no-candidate-supplied\"]},"
          + "\"project_highlights\":[],\"risk_items\":[],\"next_day_actions\":[]}", null);
    }
  }

  private static final class RejectOnceRuntime implements SkillScriptRuntime {
    private int validations;
    private boolean factsOnlyRendered;
    private String repairedAnalysis;

    @Override
    public byte[] prepareFacts(byte[] skillPackage, byte[] dataPackage, String reportDate) {
      return "{\"evidence\":[{\"evidence_id\":\"evidence-1\",\"raw_text\":\"test\"}]}"
          .getBytes(StandardCharsets.UTF_8);
    }

    @Override
    public void validateAnalysis(byte[] skillPackage, byte[] facts, byte[] analysis) {
      if (validations++ == 0) {
        throw new IllegalArgumentException("SCHEMA_INVALID: data_contract_version is required");
      }
      repairedAnalysis = new String(analysis, StandardCharsets.UTF_8);
    }

    @Override
    public byte[] renderDocument(byte[] skillPackage, byte[] facts, byte[] analysis) {
      factsOnlyRendered = analysis == null;
      return "docx".getBytes(StandardCharsets.UTF_8);
    }
  }

  private static final class CountingScriptedAdapter extends LlmAnalysisAdapter {
    private int calls;

    CountingScriptedAdapter() { super(new EnvironmentProperties(), new ObjectMapper()); }

    @Override
    public LlmAnalysisResult analyzeSkill(AnalysisConfiguration configuration, String instructions, Object input) {
      calls++;
      return new LlmAnalysisResult("succeeded", "{}", null);
    }
  }

  private static final class NoEvidenceRuntime implements SkillScriptRuntime {
    @Override
    public byte[] prepareFacts(byte[] skillPackage, byte[] dataPackage, String reportDate) {
      return "{\"evidence\":[]}".getBytes(StandardCharsets.UTF_8);
    }

    @Override
    public void validateAnalysis(byte[] skillPackage, byte[] facts, byte[] analysis) {
      throw new AssertionError("Model analysis must not run without evidence");
    }

    @Override
    public byte[] renderDocument(byte[] skillPackage, byte[] facts, byte[] analysis) {
      return "facts-only".getBytes(StandardCharsets.UTF_8);
    }
  }

  private static final class StubScriptRuntime implements SkillScriptRuntime {
    @Override
    public byte[] prepareFacts(byte[] skillPackage, byte[] dataPackage, String reportDate) {
      return ("{\"evidence\":[{\"evidence_id\":\"evidence-1\"}],"
          + "\"attendance_summary\":{\"expected_people\":3,"
          + "\"submitted_by_1730_people\":1,\"submitted_by_1730_rate\":0.3333,"
          + "\"submitted_by_2200_people\":2,\"submitted_by_2200_rate\":0.6667,"
          + "\"missing_people\":[{\"name\":\"未填人员\"}],"
          + "\"full_day_leave_people\":[],\"half_day_leave_people\":[],"
          + "\"review_required_people\":[]}}")
          .getBytes(StandardCharsets.UTF_8);
    }

    @Override
    public void validateAnalysis(byte[] skillPackage, byte[] facts, byte[] analysis) {}

    @Override
    public byte[] renderDocument(byte[] skillPackage, byte[] facts, byte[] analysis) {
      return "docx".getBytes(StandardCharsets.UTF_8);
    }
  }

  private static final class CapturingScriptRuntime implements SkillScriptRuntime {
    private String validatedAnalysis;

    @Override
    public byte[] prepareFacts(byte[] skillPackage, byte[] dataPackage, String reportDate) {
      return ("{\"evidence\":[{\"evidence_id\":\"evidence-1\"}],"
          + "\"project_continuity\":[{\"project_candidate_id\":\"project-candidate-1\"}],"
          + "\"project_status_coverage\":[{\"project_id\":\"project-reconstructed-1\","
          + "\"snapshot_origin\":\"reconstructed\"}]}")
          .getBytes(StandardCharsets.UTF_8);
    }

    @Override
    public void validateAnalysis(byte[] skillPackage, byte[] facts, byte[] analysis) {
      validatedAnalysis = new String(analysis, StandardCharsets.UTF_8);
    }

    @Override
    public byte[] renderDocument(byte[] skillPackage, byte[] facts, byte[] analysis) {
      return "docx".getBytes(StandardCharsets.UTF_8);
    }
  }

  private static final class RejectingAnalysisRuntime implements SkillScriptRuntime {
    private boolean factsOnlyRendered;

    @Override
    public byte[] prepareFacts(byte[] skillPackage, byte[] dataPackage, String reportDate) {
      return "{\"evidence\":[{\"evidence_id\":\"evidence-1\"}]}".getBytes(StandardCharsets.UTF_8);
    }

    @Override
    public void validateAnalysis(byte[] skillPackage, byte[] facts, byte[] analysis) {
      throw new IllegalArgumentException("unknown evidence id");
    }

    @Override
    public byte[] renderDocument(byte[] skillPackage, byte[] facts, byte[] analysis) {
      factsOnlyRendered = analysis == null;
      return "facts-only".getBytes(StandardCharsets.UTF_8);
    }
  }

  private static final class JsonCheckingRuntime implements SkillScriptRuntime {
    private final ObjectMapper mapper;
    private boolean factsOnlyRendered;

    JsonCheckingRuntime(ObjectMapper mapper) {
      this.mapper = mapper;
    }

    @Override
    public byte[] prepareFacts(byte[] skillPackage, byte[] dataPackage, String reportDate) {
      return "{\"evidence\":[{\"evidence_id\":\"evidence-1\"}]}".getBytes(StandardCharsets.UTF_8);
    }

    @Override
    public void validateAnalysis(byte[] skillPackage, byte[] facts, byte[] analysis) {
      try {
        mapper.readTree(analysis);
      } catch (Exception exception) {
        throw new IllegalArgumentException("analysis is not JSON", exception);
      }
    }

    @Override
    public byte[] renderDocument(byte[] skillPackage, byte[] facts, byte[] analysis) {
      factsOnlyRendered = analysis == null;
      return "docx".getBytes(StandardCharsets.UTF_8);
    }
  }

  private static final class StubConfigurationService extends AnalysisConfigurationService {
    StubConfigurationService() { super(null); }

    @Override
    public AnalysisConfiguration get() {
      return new AnalysisConfiguration(false, "", List.of(), Map.of(), "", "", false, false,
          false, List.of(), List.of(), "", "", "", "", "", null, null, null, null, null);
    }
  }

  private static final class PlainJsonStubAdapter extends LlmAnalysisAdapter {
    private int calls;

    PlainJsonStubAdapter() { super(new EnvironmentProperties(), new ObjectMapper()); }

    @Override
    public LlmAnalysisResult analyzeSkill(
        AnalysisConfiguration configuration, String instructions, Object input) {
      calls++;
      if (calls == 1) {
        return new LlmAnalysisResult("succeeded",
            "<think>reasoning</think>\n以下是结果：\n"
                + "{\"conclusions\":[],\"summary\":\"ok\"}", null);
      }
      return new LlmAnalysisResult("succeeded",
          "<section class=\"daily-analysis-report\"></section>", null);
    }
  }
}
