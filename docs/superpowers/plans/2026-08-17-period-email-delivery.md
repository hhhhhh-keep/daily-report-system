# 周期任务独立邮件发送 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 让日报、周报、月报各自保存并使用独立的邮件收件人、标题和报告标题。

**Architecture:** SMTP 凭据继续由 `analysis_configurations` 提供；周期邮件策略写入 `analysis_period_configurations`。运行编排器将周期配置传给报告和邮件服务，统一替换 `{{period}}`、`{{date}}`，并将最终标题用于预览、报告文档与邮件主题。

**Tech Stack:** Spring Boot 4、PostgreSQL/Flyway、Vue 3、TypeScript、Vitest、JUnit 6。

## Global Constraints

- SMTP 授权码不得返回到页面、写入日志或测试断言。
- `{{period}}` 只替换为“日报”“周报”“月报”；`{{date}}` 使用 `yyyy-MM-dd` 截止日期。
- 邮件未启用时不得调用 SMTP。
- 旧全局邮件设置仅迁移到日报；周报、月报迁移后必须关闭。
- 不在当前脏工作区创建混合提交；实施前保留已有用户改动。

---

### Task 1: 持久化周期邮件策略与迁移

**Files:**
- Create: `daily-api/src/main/resources/db/migration/V026__add_period_email_delivery.sql`
- Modify: `daily-api/src/main/java/com/company/daily/analysis/AnalysisPeriodConfiguration.java`
- Modify: `daily-api/src/main/java/com/company/daily/analysis/AnalysisPeriodConfigurationRequest.java`
- Modify: `daily-api/src/main/java/com/company/daily/analysis/AnalysisPeriodConfigurationService.java`
- Test: `daily-api/src/test/java/com/company/daily/analysis/AnalysisPeriodConfigurationServiceTest.java`

**Interfaces:**
- Produces `AnalysisPeriodConfiguration` 字段：`emailEnabled`、`emailRecipients`、`emailCcRecipients`、`emailSubjectTemplate`、`reportTitleTemplate`。
- Consumed by `AnalysisOrchestrator`、`EmailService`、运行计划 API。

- [ ] **Step 1: Write the failing migration/service test**

```java
assertThat(configuration.emailEnabled()).isTrue();
assertThat(configuration.emailRecipients()).containsExactly("daily@example.test");
assertThat(configuration.emailSubjectTemplate()).isEqualTo("{{period}}分析报告｜{{date}}");
assertThat(configuration.reportTitleTemplate()).isEqualTo("{{period}}工作分析报告（截至{{date}}）");
```

- [ ] **Step 2: Run the focused test and verify it fails**

Run: `mvn -Dtest=AnalysisPeriodConfigurationServiceTest test` with JDK 21.

Expected: FAIL because the period configuration has no email fields.

- [ ] **Step 3: Add schema and service mapping**

```sql
alter table analysis_period_configurations
  add column email_enabled boolean not null default false,
  add column email_recipients text not null default '',
  add column email_cc_recipients text not null default '',
  add column email_subject_template varchar(500) not null default '{{period}}分析报告｜{{date}}',
  add column report_title_template varchar(500) not null default '{{period}}工作分析报告（截至{{date}}）';

update analysis_period_configurations
set email_enabled = c.email_enabled,
    email_recipients = c.recipients,
    email_cc_recipients = c.cc_recipients,
    email_subject_template = c.email_subject_template
from analysis_configurations c
where analysis_period = 'DAILY';
```

Map CSV safely with trimmed, nonempty values; validate title templates are nonblank; include the five columns in `list`, `get`, and `update` SQL.

- [ ] **Step 4: Run focused test and Flyway migration verification**

Run: `mvn -Dtest=AnalysisPeriodConfigurationServiceTest test` with JDK 21.

Expected: PASS; DAILY contains migrated data and WEEKLY/MONTHLY have `emailEnabled=false`.

### Task 2: 周期标题解析、报告与邮件发送

**Files:**
- Create: `daily-api/src/main/java/com/company/daily/email/PeriodEmailDeliverySettings.java`
- Modify: `daily-api/src/main/java/com/company/daily/email/EmailService.java`
- Modify: `daily-api/src/main/java/com/company/daily/reporting/ReportService.java`
- Modify: `daily-api/src/main/java/com/company/daily/scheduling/AnalysisOrchestrator.java`
- Modify: `daily-api/src/main/java/com/company/daily/skills/SkillAnalysisExecutor.java`
- Test: `daily-api/src/test/java/com/company/daily/email/EmailServiceTest.java`
- Test: `daily-api/src/test/java/com/company/daily/reporting/ReportServiceTest.java`
- Test: `daily-api/src/test/java/com/company/daily/scheduling/AnalysisOrchestratorTest.java`

**Interfaces:**
- `PeriodEmailDeliverySettings.from(AnalysisPeriodConfiguration, LocalDate)` returns resolved recipients, copy recipients, email subject and report title.
- `EmailService.deliver(long, LocalDate, AnalysisConfiguration, PeriodEmailDeliverySettings, ReportArtifact)` returns `not-requested`, `sent`, or `failed`.
- `ReportService.generate(..., String reportTitle)` returns HTML/PDF with that title.

- [ ] **Step 1: Write failing delivery tests**

```java
assertThat(settings.subject()).isEqualTo("周报分析报告｜2026-08-17");
assertThat(settings.reportTitle()).isEqualTo("周报工作分析报告（截至2026-08-17）");
assertThat(result.status()).isEqualTo("not-requested");
verifyNoInteractions(gateway);
```

Add a separate enabled case asserting the gateway receives only the current period's recipients and the resolved subject.

- [ ] **Step 2: Run focused tests and verify they fail**

Run: `mvn -Dtest=EmailServiceTest,ReportServiceTest,AnalysisOrchestratorTest test` with JDK 21.

Expected: FAIL because delivery still reads global recipients/title and reports have no period title input.

- [ ] **Step 3: Implement the single settings boundary and route it through both orchestration paths**

```java
public record PeriodEmailDeliverySettings(
    boolean enabled, List<String> recipients, List<String> ccRecipients,
    String subject, String reportTitle) {}
```

Resolve placeholders once at the boundary. Make `EmailService` reject an enabled empty-recipient setting as `failed` with `该周期已启用邮件发送，但未配置收件人` and use only period recipients when saving `email_deliveries`. In both `AnalysisOrchestrator.execute` overloads, fetch the matching period configuration, generate/fallback-render using the resolved report title, and call the new `EmailService` signature.

For Skill-rendered reports, prepend a sanitized `<h1>` title to the HTML preview and pass the resolved title to document generation metadata so generated Word/PDF uses the same title. Preserve the Skill report body; do not ask the LLM to generate a title.

- [ ] **Step 4: Run focused tests and inspect generated title**

Run: `mvn -Dtest=EmailServiceTest,ReportServiceTest,AnalysisOrchestratorTest test` with JDK 21.

Expected: PASS; disabled delivery skips SMTP, the enabled weekly case uses only weekly addresses, and the rendered title contains the resolved Chinese title.

### Task 3: 运行计划与技术连接页面

**Files:**
- Modify: `daily-web/src/api/admin.ts`
- Modify: `daily-web/src/views/admin/schedule/AdminRunScheduleView.vue`
- Modify: `daily-web/src/views/admin/config/AdminTechnicalConnectionView.vue`
- Test: `daily-web/tests/views/admin-run-schedule.spec.ts`
- Test: `daily-web/tests/views/admin-technical-connections.spec.ts`

**Interfaces:**
- `AnalysisPeriodConfiguration` TypeScript type includes the five period email fields from Task 1.
- `updateAnalysisPeriodConfiguration(period)` persists all fields from one card.

- [ ] **Step 1: Write failing view tests**

```ts
expect(wrapper.text()).toContain('邮件发送设置')
expect(wrapper.text()).toContain('{{period}}')
expect(wrapper.findAll('input[type="email"]')).toHaveLength(6)
```

Add a technical-connection assertion that it no longer renders “收件人（逗号分隔）” or “通过 SMTP 发送邮件”.

- [ ] **Step 2: Run focused frontend tests and verify they fail**

Run: `npm run test -- admin-run-schedule admin-technical-connections` from `daily-web`.

Expected: FAIL because the period cards do not expose email fields.

- [ ] **Step 3: Add period-specific controls and remove global business controls**

```vue
<label class="check-field"><input v-model="period.emailEnabled" type="checkbox" /> 发送本周期报告邮件</label>
<label>邮件标题<input v-model.trim="period.emailSubjectTemplate" placeholder="{{period}}分析报告｜{{date}}" /></label>
<label>报告标题<input v-model.trim="period.reportTitleTemplate" placeholder="{{period}}工作分析报告（截至{{date}}）" /></label>
<p class="hint">{{period}} 会替换为日报、周报或月报；{{date}} 会替换为报告截止日期。</p>
```

Use comma-separated text adapters for recipient arrays. Keep only SMTP connection fields and the test-mail action in technical connections. The test-mail action must send to the selected DAILY recipients or state explicitly that it uses the daily task recipients.

- [ ] **Step 4: Run focused frontend tests and type check**

Run: `npm run test -- admin-run-schedule admin-technical-connections && npm run build` from `daily-web`.

Expected: PASS; each period card saves independent settings and technical connections no longer has global recipients.

### Task 4: 端到端验证与数据安全检查

**Files:**
- Modify: `daily-api/src/test/java/com/company/daily/scheduling/AnalysisJobIntegrationTest.java`
- Modify: `daily-api/src/test/java/com/company/daily/email/SmtpTestEmailServiceTest.java`

**Interfaces:**
- Scheduled and manual DAILY/WEEKLY/MONTHLY runs share the same period delivery behavior.

- [ ] **Step 1: Write failing integration test**

```java
assertThat(emailDelivery("WEEKLY").recipients()).isEqualTo("weekly@example.test");
assertThat(emailDelivery("WEEKLY").subject()).isEqualTo("周报分析报告｜2026-08-17");
assertThat(emailDelivery("DAILY").recipients()).doesNotContain("weekly@example.test");
```

- [ ] **Step 2: Run it and verify it fails**

Run: `mvn -Dtest=AnalysisJobIntegrationTest,SmtpTestEmailServiceTest test` with JDK 21.

Expected: FAIL until period settings flow through scheduled/manual delivery and SMTP test recipient resolution.

- [ ] **Step 3: Align SMTP test behavior and migration verification**

Make the SMTP test use DAILY period recipients and subject, because the technical-connections page has no task selector. Retain the existing requirement that SMTP configuration is saved before testing. Verify Flyway migration seeds the expected daily migration and disabled weekly/monthly policy.

- [ ] **Step 4: Run final verification**

Run: `mvn test` with JDK 21, then `npm run test && npm run build` from `daily-web`.

Expected: all tests pass; no authorization code, continuous-question-mark garbling, or mojibake appears in Java, SQL, TypeScript, or rendered templates.

## Plan Self-Review

- Spec coverage: Tasks 1–4 cover independent settings, global SMTP retention, migration, placeholders, report/email titles, disabled behavior, UI examples, and regression checks.
- Placeholder scan: no unfinished design choices remain; all fields, messages, and commands are specified.
- Type consistency: `AnalysisPeriodConfiguration` is the source of the five settings; `PeriodEmailDeliverySettings` is the only runtime delivery boundary.
