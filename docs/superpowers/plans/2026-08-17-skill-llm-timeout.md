# Skill 模型调用超时配置 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 将 Skill 的模型请求超时配置为默认 300 秒，并将浏览器请求等待上限提升至 360 秒。

**Architecture:** `EnvironmentProperties.Llm` 绑定 Spring 配置。`LlmAnalysisAdapter.analyzeSkill` 读取该值；普通日报分析继续使用固定 90 秒。前端 API 客户端仅调整成对试运行的 Axios 覆盖超时。

**Tech Stack:** Java 21、Spring Boot 4、JUnit 5、Vue 3、TypeScript、Vitest。

## Global Constraints

- 默认后端 Skill 超时为 `PT300S`，可由 `daily.llm.skill-request-timeout` 覆盖。
- 成对 Skill 试运行前端超时为 `360_000` 毫秒。
- 不更改模型请求负载、认证头、重试次数、普通日报分析的 90 秒超时或数据库模型配置。

---

### Task 1: 后端可配置的 Skill 请求超时

**Files:**
- Modify: `daily-api/src/main/java/com/company/daily/config/EnvironmentProperties.java`
- Modify: `daily-api/src/main/java/com/company/daily/analysis/LlmAnalysisAdapter.java`
- Modify: `daily-api/src/test/java/com/company/daily/analysis/LlmAnalysisAdapterTest.java`

**Interfaces:**
- Produces: `EnvironmentProperties.Llm#getSkillRequestTimeout(): Duration`，默认 `Duration.ofSeconds(300)`。
- Consumes: `analyzeSkill(...)` 使用该 getter 设置 HTTP 请求超时。

- [ ] **Step 1: 写入失败测试**

```java
@Test
void defaultsSkillRequestTimeoutToFiveMinutes() {
  assertThat(new EnvironmentProperties().getLlm().getSkillRequestTimeout())
      .isEqualTo(Duration.ofSeconds(300));
}
```

- [ ] **Step 2: 运行测试并确认失败**

Run: `cd daily-api; .\mvnw.cmd -Dtest=LlmAnalysisAdapterTest test`

Expected: 编译失败，提示 `getSkillRequestTimeout()` 未定义。

- [ ] **Step 3: 实现最小配置绑定**

```java
private Duration skillRequestTimeout = Duration.ofSeconds(300);
public Duration getSkillRequestTimeout() { return skillRequestTimeout; }
public void setSkillRequestTimeout(Duration value) { this.skillRequestTimeout = value; }
```

移除 `SKILL_REQUEST_TIMEOUT`，在 `analyzeSkill` 中使用：

```java
.timeout(environment.getLlm().getSkillRequestTimeout())
```

- [ ] **Step 4: 运行聚焦测试**

Run: `cd daily-api; .\mvnw.cmd -Dtest=LlmAnalysisAdapterTest test`

Expected: 测试通过。

- [ ] **Step 5: 提交后端变更**

Run: `git add daily-api/src/main/java/com/company/daily/config/EnvironmentProperties.java daily-api/src/main/java/com/company/daily/analysis/LlmAnalysisAdapter.java daily-api/src/test/java/com/company/daily/analysis/LlmAnalysisAdapterTest.java; git commit -m "fix: configure skill LLM request timeout"`

### Task 2: 前端试运行等待时间

**Files:**
- Modify: `daily-web/src/api/admin.ts:352-355`
- Modify: `daily-web/tests/api/admin-skills.spec.ts`

**Interfaces:**
- Produces: `adminApi.trialAnalysisSkills(...)` 发送 Axios 配置 `{ timeout: 360_000 }`。
- Consumes: 后端默认 300 秒超时，保留 60 秒网络与持久化缓冲。

- [ ] **Step 1: 更新失败断言**

将 `admin-skills.spec.ts` 的期望改为：

```ts
timeout: 360_000,
```

- [ ] **Step 2: 运行测试并确认失败**

Run: `cd daily-web; npm test -- tests/api/admin-skills.spec.ts`

Expected: 断言失败，实际调用仍为 `240_000`。

- [ ] **Step 3: 实现最小前端调整**

将 `adminApi.trialAnalysisSkills` 的覆盖超时改为 `360_000`。

- [ ] **Step 4: 运行聚焦测试**

Run: `cd daily-web; npm test -- tests/api/admin-skills.spec.ts`

Expected: 1 个测试通过。

- [ ] **Step 5: 提交前端变更**

Run: `git add daily-web/src/api/admin.ts daily-web/tests/api/admin-skills.spec.ts; git commit -m "fix: extend skill trial client timeout"`

### Task 3: 回归验证与任务交接

**Files:**
- Modify: `tasks/active.md`
- Modify: `.codex/state/progress.md`
- Modify: `.codex/state/critique.md`
- Modify: `.codex/state/handoff.md`

- [ ] **Step 1: 执行完整后端验证**

Run: `cd daily-api; $env:JAVA_HOME='D:\Program Files\Java\jdk-21'; .\mvnw.cmd -B -DskipTests compile`

Expected: Maven 返回 0，生产源代码编译通过；本机不启动 Docker/Testcontainers。

- [ ] **Step 2: 执行前端质量检查与生产构建**

Run: `cd daily-web; npm run lint; npm run build`

Expected: 命令均返回 0。

- [ ] **Step 3: 更新 Harness 验收证据并提交**

记录命令、结果和审查结论；所有验收项通过后记录 `LOOP_COMPLETE`。

Run: `git add tasks/active.md .codex/state/progress.md .codex/state/critique.md .codex/state/handoff.md; git commit -m "docs: record skill timeout verification"`
