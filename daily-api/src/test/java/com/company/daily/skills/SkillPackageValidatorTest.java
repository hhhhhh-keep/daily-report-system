package com.company.daily.skills;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

import java.io.ByteArrayOutputStream;
import java.nio.charset.StandardCharsets;
import java.util.LinkedHashMap;
import java.util.Map;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import org.junit.jupiter.api.Test;

class SkillPackageValidatorTest {
  private final SkillPackageValidator validator = new SkillPackageValidator();

  @Test
  void acceptsSkillMarkdownAtArchiveRoot() throws Exception {
    SkillPackageValidator.ValidatedSkillPackage value = validator.validate(zip("SKILL.md", """
        ---
        name: daily-rule
        description: Daily report rule
        ---
        Use only supplied data.
        """));

    assertEquals("daily-rule", value.skillName());
  }

  @Test
  void rejectsArchiveWithoutRootSkillMarkdown() throws Exception {
    assertThrows(IllegalArgumentException.class, () -> validator.validate(zip("assets/style.css", "body{}")));
  }

  @Test
  void rejectsExecutableOrUnsafeContent() throws Exception {
    assertThrows(IllegalArgumentException.class, () -> validator.validate(zip("assets/run.sh", "echo no")));
  }

  @Test
  void acceptsDeclaredPythonEntrypointsAndDocumentAssets() throws Exception {
    Map<String, String> entries = new LinkedHashMap<>();
    entries.put("SKILL.md", """
        ---
        name: daily-scripted-rule
        description: Deterministic daily analysis
        ---
        Follow the packaged contract.
        """);
    entries.put("manifest.json", """
        {"format_version":"2.0","name":"daily-scripted-rule",
         "runtime_profile":"daily-python-3.12-v1",
         "entrypoints":{"prepare_facts":"scripts/run_prepare_facts.py"},
         "permissions":{"network":false}}
        """);
    entries.put("scripts/run_prepare_facts.py", "print('ok')");
    entries.put("schemas/daily-facts.schema.json", "{}");
    entries.put("references/rules.md", "# Rules");
    entries.put("assets/daily-report-template.docx", "placeholder");

    SkillPackageValidator.ValidatedSkillPackage value = validator.validate(zip(entries));

    assertEquals("daily-python-3.12-v1", value.manifest().runtimeProfile());
    assertEquals("scripts/run_prepare_facts.py", value.manifest().entrypoints().get("prepare_facts"));
  }

  @Test
  void rejectsUndeclaredPythonScript() throws Exception {
    Map<String, String> entries = new LinkedHashMap<>();
    entries.put("SKILL.md", "---\nname: daily-rule\ndescription: rule\n---\n");
    entries.put("manifest.json", """
        {"format_version":"2.0","name":"daily-rule",
         "runtime_profile":"daily-python-3.12-v1","entrypoints":{},
         "permissions":{"network":false}}
        """);
    entries.put("scripts/hidden.py", "print('not declared')");

    assertThrows(IllegalArgumentException.class, () -> validator.validate(zip(entries)));
  }

  @Test
  void acceptsBuiltDailyRuleAndTemplatePackages() throws Exception {
    Path packages = Path.of("..", "deliverables", "skill-packages");

    SkillPackageValidator.ValidatedSkillPackage rule = validator.validate(
        Files.readAllBytes(packages.resolve("daily-work-analysis-v3.1.0.zip")));
    SkillPackageValidator.ValidatedSkillPackage template = validator.validate(
        Files.readAllBytes(packages.resolve("daily-report-docx-template-v3.1.0.zip")));

    assertEquals("daily-work-analysis", rule.skillName());
    assertEquals("daily-report-docx-template", template.skillName());
    assertEquals("daily-facts/1.2.0", rule.manifest().contracts().get("facts"));
    assertEquals("daily-analysis/1.2.0", rule.manifest().contracts().get("analysis"));
    assertEquals("daily-facts/1.2.0", template.manifest().contracts().get("facts"));
    assertEquals("daily-analysis/1.2.0", template.manifest().contracts().get("analysis"));
  }

  @Test
  void assemblesAnalysisInstructionsFromRootReferencesAndDeclaredSchema() throws Exception {
    Map<String, String> entries = scriptedAnalysisEntries();
    entries.put("references/rules.md", "# Evidence rules\nUse known evidence only.");
    entries.put("schemas/daily-analysis.schema.json",
        "{\"type\":\"object\",\"required\":[\"data_contract_version\"]}");
    entries.put("scripts/hidden-content.py", "MODEL_MUST_NOT_SEE_THIS");
    entries.put("manifest.json", entries.get("manifest.json").replace(
        "\"modules\":[]", "\"modules\":[\"scripts/hidden-content.py\"]"));

    SkillPackageValidator.ValidatedSkillPackage value = validator.validate(zip(entries));

    assertEquals("daily-analysis/1.0.0", value.manifest().contracts().get("analysis"));
    org.junit.jupiter.api.Assertions.assertTrue(value.analysisInstructions().contains("Use known evidence only"));
    org.junit.jupiter.api.Assertions.assertTrue(value.analysisInstructions().contains("data_contract_version"));
    org.junit.jupiter.api.Assertions.assertTrue(
        value.analysisInstructions().contains("Return exactly one JSON object"));
    org.junit.jupiter.api.Assertions.assertFalse(
        value.analysisInstructions().contains("MODEL_MUST_NOT_SEE_THIS"));
  }

  @Test
  void rejectsDeclaredAnalysisContractWithoutItsSchema() throws Exception {
    assertThrows(IllegalArgumentException.class,
        () -> validator.validate(zip(scriptedAnalysisEntries())));
  }

  private static Map<String, String> scriptedAnalysisEntries() {
    Map<String, String> entries = new LinkedHashMap<>();
    entries.put("SKILL.md", "---\nname: daily-rule\ndescription: rule\n---\nRoot instructions.");
    entries.put("manifest.json", """
        {"format_version":"2.0","name":"daily-rule",
         "runtime_profile":"daily-python-3.12-v1",
         "contracts":{"analysis":"daily-analysis/1.0.0"},
         "entrypoints":{"prepare_facts":"scripts/run.py"},"modules":[],
         "permissions":{"network":false}}
        """);
    entries.put("scripts/run.py", "print('ok')");
    return entries;
  }

  private static byte[] zip(String name, String content) throws Exception {
    return zip(Map.of(name, content));
  }

  private static byte[] zip(Map<String, String> entries) throws Exception {
    try (ByteArrayOutputStream output = new ByteArrayOutputStream(); ZipOutputStream zip = new ZipOutputStream(output)) {
      for (Map.Entry<String, String> entry : entries.entrySet()) {
        zip.putNextEntry(new ZipEntry(entry.getKey()));
        zip.write(entry.getValue().getBytes(StandardCharsets.UTF_8));
        zip.closeEntry();
      }
      zip.finish();
      return output.toByteArray();
    }
  }
}
