# Scripted Skill Model Contract Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 让脚本型分析 Skill 的首次模型调用和一次修复调用都获得 ZIP 内的完整规则引用与正式 JSON Schema，使合格 AI 内容能够通过证据门禁进入 Word。

**Architecture:** `SkillPackageValidator` 负责在受控 ZIP 已完成安全校验后装配只读 `analysisInstructions`，并通过 `ValidatedSkillPackage` 暴露给执行器。`SkillAnalysisExecutor` 使用该完整指令发起首次调用；失败时将同一契约、原候选和截断后的校验错误交给模型修复一次，结果仍经过原 Python 校验器。

**Tech Stack:** Java 21、Spring Boot、Jackson、JUnit 6、AssertJ、Python 3.12 Skill runtime、Docker Compose。

## Global Constraints

- 不放宽 Schema、人员、项目或证据 ID 校验。
- 不把脚本、测试、Word 资产或二进制内容传给模型。
- 提示词型旧 Skill 行为保持不变。
- 脚本型分析最多修复一次，第二次失败继续生成基础报告。
- 已上传 v2 ZIP 直接生效，不要求重新上传。

---

### Task 1: 从 Skill Package 2.0 装配完整分析契约

**Files:**
- Modify: `daily-api/src/main/java/com/company/daily/skills/SkillPackageValidator.java`
- Test: `daily-api/src/test/java/com/company/daily/skills/SkillPackageValidatorTest.java`

**Interfaces:**
- Consumes: `manifest.contracts.analysis`，格式为 `<contract-name>/<semantic-version>`。
- Produces: `ValidatedSkillPackage.analysisInstructions(): String`；`SkillManifest.contracts(): Map<String, String>`。

- [ ] **Step 1: 写入完整契约装配和缺失 Schema 的失败测试**

在 `SkillPackageValidatorTest` 增加：

```java
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
  org.junit.jupiter.api.Assertions.assertTrue(value.analysisInstructions().contains("Return exactly one JSON object"));
  org.junit.jupiter.api.Assertions.assertFalse(value.analysisInstructions().contains("MODEL_MUST_NOT_SEE_THIS"));
}

@Test
void rejectsDeclaredAnalysisContractWithoutItsSchema() throws Exception {
  assertThrows(IllegalArgumentException.class,
      () -> validator.validate(zip(scriptedAnalysisEntries())));
}
```

增加测试数据助手：

```java
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
```

- [ ] **Step 2: 运行测试确认新行为尚不存在**

Run:

```powershell
mvn.cmd -Dtest=SkillPackageValidatorTest test
```

Expected: 编译或断言失败，因为 `contracts()` 与 `analysisInstructions()` 尚不存在。

- [ ] **Step 3: 实现清单契约解析和安全指令装配**

在 `SkillManifest` 增加 `Map<String, String> contracts`；在 `ValidatedSkillPackage` 增加 `String analysisInstructions`。

在 `validate` 中使用已读取的 `entries` 调用：

```java
String analysisInstructions = buildAnalysisInstructions(markdown, manifest, entries);
return new ValidatedSkillPackage(metadata.name(), metadata.description(), markdown,
    analysisInstructions, checksum(archiveBytes), manifest);
```

新增装配方法：

```java
private static String buildAnalysisInstructions(
    String markdown, SkillManifest manifest, Map<String, byte[]> entries) {
  if (manifest == null || manifest.contracts() == null
      || manifest.contracts().get("analysis") == null) {
    return markdown;
  }
  String contract = manifest.contracts().get("analysis");
  String contractName = contract.split("/", 2)[0];
  String schemaPath = "schemas/" + contractName + ".schema.json";
  byte[] schemaBytes = entries.get(schemaPath);
  if (schemaBytes == null) {
    throw new IllegalArgumentException("分析契约缺少对应 Schema: " + schemaPath);
  }
  String schema = decodeUtf8(schemaBytes, schemaPath);
  try {
    OBJECT_MAPPER.readTree(schema);
  } catch (Exception exception) {
    throw new IllegalArgumentException("分析契约 Schema 不是有效 JSON: " + schemaPath, exception);
  }
  StringBuilder result = new StringBuilder(markdown);
  entries.entrySet().stream()
      .filter(entry -> entry.getKey().startsWith("references/") && entry.getKey().endsWith(".md"))
      .sorted(Map.Entry.comparingByKey())
      .forEach(entry -> result.append("\n\n# ").append(entry.getKey()).append('\n')
          .append(decodeUtf8(entry.getValue(), entry.getKey())));
  result.append("\n\n# Required analysis JSON Schema\n").append(schema)
      .append("\n\n# Host output requirement\n")
      .append("Return exactly one JSON object matching the schema. Do not return Markdown, reasoning, ")
      .append("or additional properties. Use only person, project, and evidence IDs present in the facts.");
  return result.toString();
}
```

`decodeUtf8` 使用 `StandardCharsets.UTF_8.newDecoder()`，将 malformed/unmappable 输入设为 `CodingErrorAction.REPORT`，失败时抛出包含相对路径的 `IllegalArgumentException`。

- [ ] **Step 4: 运行验证器测试确认通过**

Run: `mvn.cmd -Dtest=SkillPackageValidatorTest test`

Expected: 8 tests passed。

- [ ] **Step 5: 提交契约装配**

```powershell
git add daily-api/src/main/java/com/company/daily/skills/SkillPackageValidator.java daily-api/src/test/java/com/company/daily/skills/SkillPackageValidatorTest.java
git commit -m "feat: load scripted skill model contracts"
```

---

### Task 2: 首次调用和修复调用使用完整契约

**Files:**
- Modify: `daily-api/src/main/java/com/company/daily/skills/SkillAnalysisExecutor.java`
- Test: `daily-api/src/test/java/com/company/daily/skills/SkillAnalysisExecutorTest.java`

**Interfaces:**
- Consumes: `ValidatedSkillPackage.analysisInstructions()`。
- Produces: 第二次模型调用输入键 `facts`、`invalidDraft`、`validationError`；校验错误最长 6000 字符。

- [ ] **Step 1: 写入首次与修复调用契约传递的失败测试**

扩展测试 ZIP 助手，使规则包可包含 `contracts.analysis`、引用文件和 Schema。新增捕获型适配器与一次失败运行时：首次返回错误候选，运行时抛出 `SCHEMA_INVALID: data_contract_version is required`；第二次返回合法候选。

断言：

```java
assertThat(adapter.firstInstructions)
    .contains("PACKAGED_RULE_REFERENCE")
    .contains("Required analysis JSON Schema")
    .contains("data_contract_version");
assertThat(adapter.repairInstructions)
    .contains("Repair the candidate")
    .contains("Required analysis JSON Schema");
assertThat(adapter.repairInput.toString())
    .contains("validationError")
    .contains("SCHEMA_INVALID")
    .contains("invalidDraft")
    .contains("facts");
assertThat(result.errorSummary()).isNull();
```

- [ ] **Step 2: 运行测试确认执行器仍只使用根 Markdown**

Run: `mvn.cmd -Dtest=SkillAnalysisExecutorTest test`

Expected: FAIL，首次指令缺少 `PACKAGED_RULE_REFERENCE`，修复输入缺少 `validationError`。

- [ ] **Step 3: 使用完整契约并传递截断后的真实校验错误**

在脚本型分支中设置：

```java
String modelInstructions = validatedRule.analysisInstructions();
```

首次调用使用 `modelInstructions`。修复指令使用：

```java
String repairInstructions = modelInstructions + "\n\n# Repair requirement\n"
    + "Repair the candidate. Return a syntactically valid JSON object only. "
    + "Do not invent data or identifiers.";
String validationError = exception.getMessage() == null ? exception.getClass().getSimpleName()
    : exception.getMessage().substring(0, Math.min(exception.getMessage().length(), 6000));
LlmAnalysisResult repair = adapter.analyzeSkill(configuration, repairInstructions,
    Map.of("facts", factsJson, "invalidDraft", analysisDraft == null ? "" : analysisDraft,
        "validationError", validationError));
```

修复结果继续调用 `scriptRuntime.validateAnalysis`，不得绕过门禁。

- [ ] **Step 4: 运行执行器和验证器回归测试**

Run:

```powershell
mvn.cmd -Dtest=SkillPackageValidatorTest,SkillAnalysisExecutorTest,DailyDataPackageAssemblerTest,AnalysisSkillServiceUploadTest test
```

Expected: 全部通过。

- [ ] **Step 5: 提交执行器修复**

```powershell
git add daily-api/src/main/java/com/company/daily/skills/SkillAnalysisExecutor.java daily-api/src/test/java/com/company/daily/skills/SkillAnalysisExecutorTest.java
git commit -m "fix: apply full contracts to skill analysis"
```

---

### Task 3: 部署与真实试运行核验

**Files:**
- No source changes expected.

**Interfaces:**
- Consumes: 当前数据库内 v2 规则包、v2 模板包和既有 MiniMax 连接配置。
- Produces: 通过证据门禁的分析草稿与包含 AI 语义章节的 Word，或带明确校验错误的安全降级结果。

- [ ] **Step 1: 运行生产构建与差异检查**

Run: `mvn.cmd -DskipTests package`，随后运行 `git diff --check`。

Expected: BUILD SUCCESS；无 whitespace error。

- [ ] **Step 2: 重建 API 容器**

使用当前容器中已存在的数据库、管理员、MiniMax 与邮件配置，运行：

```powershell
docker compose -p daily-phase2 -f docker/docker-compose.yml up --build -d daily-api
```

Expected: `daily-phase2-daily-api-1` 为 healthy。

- [ ] **Step 3: 使用现有 v2 版本试运行 2026-08-11**

在 Skills 中心选择日报规则 v2、日报模板 v2、日期 `2026-08-11`，点击“试运行所选版本”。

Expected: 页面显示无降级警告的“试运行成功，可查看结果并下载报告”；若模型仍不合规，日志必须显示具体 Schema/证据错误，Word 继续安全降级。

- [ ] **Step 4: 检查分析草稿和 Word**

确认分析草稿包含且只包含 `data_contract_version`、`work_summary`、`project_highlights`、`risk_items`、`next_day_actions`；Word 的重点项目、风险、次日建议不再统一显示“待人工补充”。
