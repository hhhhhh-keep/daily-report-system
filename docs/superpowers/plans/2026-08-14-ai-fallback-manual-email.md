# AI Fallback and Manual Email Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make MiniMax-M3 produce usable structured analysis, persist truthful AI fallback states, and allow every administrator-triggered manual run to resend email while scheduled runs remain idempotent.

**Architecture:** Keep report generation and AI execution separate: `SkillExecution` reports both document execution status and AI status, and the orchestrator persists each independently. Make email idempotency depend on the run trigger instead of only the analysis date. Adapt MiniMax-M3 requests to direct-answer mode and retry one empty successful response.

**Tech Stack:** Java 21, Spring Boot, JdbcTemplate, Flyway/PostgreSQL, JUnit 5, Mockito, Vue 3, TypeScript, Vitest, Docker Compose.

## Global Constraints

- Do not change the daily analysis rule or Word template content.
- Do not change the configured model provider or model name.
- Manual runs may resend; scheduled and retry runs retain duplicate-email protection.
- Never log model response bodies, API keys, SMTP credentials, recipients, or personal report data.
- Every behavior change follows red-green-refactor and receives an automated regression test.

---

### Task 1: MiniMax-M3 Direct Structured Output

**Files:**
- Modify: `daily-api/src/test/java/com/company/daily/analysis/LlmAnalysisAdapterTest.java`
- Modify: `daily-api/src/main/java/com/company/daily/analysis/LlmAnalysisAdapter.java`

**Interfaces:**
- Consumes: `analyzeSkill(AnalysisConfiguration, String, Object)`.
- Produces: the same public method, with MiniMax-M3 `thinking.type=disabled`, no `reasoning_split`, and one retry for an HTTP-200 response whose `message.content` is blank.

- [ ] **Step 1: Write failing adapter tests**

Add tests that capture request bodies and return sequential stub responses:

```java
@Test
void disablesThinkingForMiniMaxM3StructuredAnalysis() {
  LlmAnalysisResult result = adapterFor("MiniMax-M3", success("{\"ok\":true}"))
      .analyzeSkill(configuration(), "Return JSON", Map.of("facts", true));
  assertThat(result.status()).isEqualTo("succeeded");
  assertThat(requestBody.get()).contains("\"thinking\":{\"type\":\"disabled\"}");
  assertThat(requestBody.get()).doesNotContain("reasoning_split");
}

@Test
void retriesOneEmptyMiniMaxResponse() {
  LlmAnalysisResult result = adapterFor("MiniMax-M3", empty(), success("{\"ok\":true}"))
      .analyzeSkill(configuration(), "Return JSON", Map.of("facts", true));
  assertThat(result.status()).isEqualTo("succeeded");
  assertThat(requestCount).hasValue(2);
}

@Test
void reportsFailureAfterTwoEmptyResponses() {
  LlmAnalysisResult result = adapterFor("MiniMax-M3", empty(), empty())
      .analyzeSkill(configuration(), "Return JSON", Map.of("facts", true));
  assertThat(result.status()).isEqualTo("failed");
  assertThat(requestCount).hasValue(2);
}
```

- [ ] **Step 2: Run the tests and verify RED**

Run:

```powershell
./mvnw -Dtest=LlmAnalysisAdapterTest test
```

Expected: M3 request still contains `reasoning_split`, lacks `thinking.disabled`, and the empty-response test observes one request.

- [ ] **Step 3: Implement the minimal adapter change**

Extract one HTTP exchange into a private helper. In the payload branch use:

```java
if (isMiniMaxM3(model)) {
  payload.put("thinking", Map.of("type", "disabled"));
  payload.put("max_completion_tokens", 8192);
} else if (isMiniMax(endpoint, model)) {
  payload.put("reasoning_split", true);
  payload.put("max_completion_tokens", 8192);
}
```

Call the helper at most twice when the first response is a successful HTTP response with blank `message.content`. Preserve the existing failure result on non-2xx responses and exceptions.

- [ ] **Step 4: Run tests and verify GREEN**

Run `./mvnw -Dtest=LlmAnalysisAdapterTest test` and expect all tests to pass.

- [ ] **Step 5: Commit**

```powershell
git add daily-api/src/main/java/com/company/daily/analysis/LlmAnalysisAdapter.java daily-api/src/test/java/com/company/daily/analysis/LlmAnalysisAdapterTest.java
git commit -m "fix: stabilize MiniMax M3 analysis output"
```

### Task 2: Truthful AI Status Through the Skill Pipeline

**Files:**
- Modify: `daily-api/src/test/java/com/company/daily/skills/SkillAnalysisExecutorTest.java`
- Modify: `daily-api/src/main/java/com/company/daily/skills/SkillAnalysisExecutor.java`
- Modify: `daily-api/src/test/java/com/company/daily/scheduling/AnalysisJobIntegrationTest.java`
- Modify: `daily-api/src/main/java/com/company/daily/scheduling/AnalysisOrchestrator.java`

**Interfaces:**
- Produces: `SkillExecution(..., String aiStatus, String errorSummary)` where `aiStatus` is `succeeded`, `skipped`, or `failed`.
- Consumes: `AnalysisRunStore.complete(..., llmStatus, ..., errorSummary)` without changing its signature.

- [ ] **Step 1: Write failing Skill execution tests**

Add assertions to existing success, no-evidence, and fallback cases:

```java
assertThat(success.aiStatus()).isEqualTo("succeeded");
assertThat(noEvidence.aiStatus()).isEqualTo("skipped");
assertThat(aiFailureFallback.aiStatus()).isEqualTo("failed");
```

- [ ] **Step 2: Verify Skill tests fail**

Run `./mvnw -Dtest=SkillAnalysisExecutorTest test` and expect compilation failure because `aiStatus()` does not exist.

- [ ] **Step 3: Add the explicit AI status field**

Extend `SkillExecution` and set constructor values:

```java
succeededDocument(..., "succeeded", null)
succeededFallback(..., aiStatus, warning)
ruleFailed(..., "failed", error)
templateFailed(..., draft == null ? "failed" : "succeeded", error)
```

Pass `"skipped"` from the no-evidence branch and `"failed"` from model-call or evidence-validation fallback branches.

- [ ] **Step 4: Write a failing orchestrator integration test**

For a published scripted Skill whose model returns no content, assert:

```java
assertThat(run.status()).isEqualTo("partial-failure");
assertThat(run.llmStatus()).isEqualTo("failed");
assertThat(run.advisoryText()).contains("基础报告");
```

For no evidence, assert `succeeded/skipped`.

- [ ] **Step 5: Verify the integration test is RED**

Run the targeted scheduling test and expect current hard-coded `succeeded` AI status.

- [ ] **Step 6: Persist truthful status**

In the period-window orchestrator:

```java
boolean aiFailed = "failed".equals(skillExecution.aiStatus());
List<String> errors = new ArrayList<>();
if (aiFailed && skillExecution.errorSummary() != null) errors.add(skillExecution.errorSummary());
if (email.errorSummary() != null) errors.add(email.errorSummary());
String status = errors.isEmpty() ? "succeeded" : "partial-failure";
runStore.complete(..., skillExecution.aiStatus(), ..., errors.isEmpty() ? null : String.join("; ", errors));
```

- [ ] **Step 7: Run Skill and orchestrator tests**

Expect both targeted suites to pass.

- [ ] **Step 8: Commit**

```powershell
git add daily-api/src/main/java/com/company/daily/skills/SkillAnalysisExecutor.java daily-api/src/main/java/com/company/daily/scheduling/AnalysisOrchestrator.java daily-api/src/test/java/com/company/daily/skills/SkillAnalysisExecutorTest.java daily-api/src/test/java/com/company/daily/scheduling/AnalysisJobIntegrationTest.java
git commit -m "fix: persist truthful AI fallback status"
```

### Task 3: Manual Email Resend With Scheduled Idempotency

**Files:**
- Create: `daily-api/src/main/resources/db/migration/V023__allow_manual_email_resend.sql`
- Modify: `daily-api/src/test/java/com/company/daily/email/EmailServiceTest.java`
- Modify: `daily-api/src/main/java/com/company/daily/email/EmailService.java`
- Modify: `daily-api/src/main/java/com/company/daily/scheduling/AnalysisOrchestrator.java`
- Modify: `daily-api/src/test/java/com/company/daily/scheduling/AnalysisJobIntegrationTest.java`
- Modify: `daily-api/src/test/java/com/company/daily/migration/MigrationVerificationTest.java`

**Interfaces:**
- Changes: `EmailService.deliver(long runId, LocalDate date, String triggerType, AnalysisConfiguration configuration, ReportArtifact artifact)`.
- Behavior: `manual` never uses date-level deduplication; `scheduled` and `retry` skip after any successful delivery for the date.

- [ ] **Step 1: Write failing email service tests**

```java
@Test
void sendsManualRunEvenWhenDateWasAlreadyDelivered() {
  when(jdbcTemplate.queryForObject(anyString(), eq(Integer.class), eq(date))).thenReturn(1);
  EmailDeliveryResult result = service.deliver(7, date, "manual", configuration(), artifact());
  assertThat(result.status()).isEqualTo("sent");
  verify(gateway).send(any(), any());
}

@Test
void skipsScheduledRunWhenDateWasAlreadyDelivered() {
  EmailDeliveryResult result = service.deliver(8, date, "scheduled", configuration(), artifact());
  assertThat(result.status()).isEqualTo("skipped-duplicate");
  verifyNoInteractions(gateway);
}
```

- [ ] **Step 2: Verify email tests are RED**

Run `./mvnw -Dtest=EmailServiceTest test`; expect signature/behavior failures.

- [ ] **Step 3: Implement trigger-aware delivery**

Skip the `successfulDeliveryExists` check only for `manual`. Include `trigger_type` in every `email_deliveries` insert. Update both orchestrator call sites to pass `triggerType`.

- [ ] **Step 4: Write and test the migration**

Migration contents:

```sql
alter table email_deliveries add column trigger_type varchar(30);
update email_deliveries d set trigger_type = r.trigger_type
from analysis_runs r where r.id = d.run_id;
alter table email_deliveries alter column trigger_type set not null;
alter table email_deliveries add constraint ck_email_delivery_trigger
  check (trigger_type in ('scheduled', 'manual', 'retry'));
drop index uk_email_delivery_success_date;
create unique index uk_email_delivery_automatic_success_date
  on email_deliveries(analysis_date)
  where status = 'sent' and trigger_type in ('scheduled', 'retry');
```

Update migration verification to prove two manual successful rows for one date are accepted while a second automatic successful row is rejected.

- [ ] **Step 5: Run targeted migration, email, and scheduling tests**

Run the three targeted suites and expect all to pass.

- [ ] **Step 6: Commit**

```powershell
git add daily-api/src/main/resources/db/migration/V023__allow_manual_email_resend.sql daily-api/src/main/java/com/company/daily/email/EmailService.java daily-api/src/main/java/com/company/daily/scheduling/AnalysisOrchestrator.java daily-api/src/test/java/com/company/daily/email/EmailServiceTest.java daily-api/src/test/java/com/company/daily/scheduling/AnalysisJobIntegrationTest.java daily-api/src/test/java/com/company/daily/migration/MigrationVerificationTest.java
git commit -m "feat: allow manual analysis email resend"
```

### Task 4: Frontend Status Regression Coverage

**Files:**
- Modify: `daily-web/tests/views/admin-analysis.spec.ts`
- Modify only if tests expose a gap: `daily-web/src/views/admin/analysis/AdminAnalysisView.vue`

**Interfaces:**
- Consumes existing `AnalysisRun` fields `status`, `llmStatus`, and `emailStatus`.
- Produces user-facing messages that distinguish AI failed/skipped/succeeded and never label a manual resend as duplicate.

- [ ] **Step 1: Add status matrix tests**

```ts
it.each([
  [{ status: 'partial-failure', llmStatus: 'failed', emailStatus: 'sent' }, '运行：部分失败；AI：失败；邮件：已发送'],
  [{ status: 'succeeded', llmStatus: 'skipped', emailStatus: 'sent' }, '运行：成功；AI：未执行；邮件：已发送'],
])('shows truthful outcomes', async (run, expected) => { /* click and assert */ })
```

- [ ] **Step 2: Run the view test**

Run `npm test -- tests/views/admin-analysis.spec.ts`. If it passes, retain the test-only commit; if it fails, make the smallest mapping/copy correction and rerun.

- [ ] **Step 3: Commit**

```powershell
git add daily-web/tests/views/admin-analysis.spec.ts daily-web/src/views/admin/analysis/AdminAnalysisView.vue
git commit -m "test: cover AI fallback run feedback"
```

### Task 5: Full Verification, Migration, Deployment, and E2E

**Files:**
- No new production files expected.

**Interfaces:**
- Verifies all prior tasks together through Docker and the administrator UI.

- [ ] **Step 1: Run backend verification**

Run targeted suites, then the full backend test suite. Expect no new failures.

- [ ] **Step 2: Run frontend verification**

Run the analysis API/view tests, TypeScript check, and production build. Record any unrelated baseline failures separately.

- [ ] **Step 3: Rebuild and deploy**

Run Docker Compose build/up for API, web, and nginx. Confirm Flyway applies V023 and all four containers are healthy.

- [ ] **Step 4: Run real 2026-07-31 analysis**

In `/admin/analysis`, run DAILY for 2026-07-31 and verify:

- progress remains visible while pending;
- final status is `运行：成功；AI：成功；邮件：已发送`;
- the latest conclusion contains AI-generated structured content, not the fallback sentence;
- another manual run for the same date sends again rather than showing duplicate skip.

- [ ] **Step 5: Query non-sensitive run evidence**

Verify the newest `analysis_runs` row has `llm_status=succeeded`, `email_status=sent`, non-fallback advisory text, and no error summary. Do not print recipients or credentials.

- [ ] **Step 6: Final verification and commit state**

Run `git diff --check`, confirm only intended tracked changes, and report the merge/push state without pushing unless requested.
