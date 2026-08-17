# SMTP Test Email Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add an administrator-only action that sends one real test email using the currently saved SMTP and recipient configuration without invoking AI, Skills, reports, or scheduled analysis.

**Architecture:** A focused `SmtpTestEmailService` loads the persisted analysis configuration, merges SMTP fields with environment defaults through the existing `SmtpSettings`, validates the minimum delivery inputs, and calls the existing `EmailGateway`. A dedicated admin controller exposes the action; the technical-connections view invokes it and renders pending, success, or safe failure feedback.

**Tech Stack:** Java 21, Spring Boot 4.1, Jakarta Mail gateway, JUnit 5, Mockito, Vue 3, TypeScript, Axios, Vitest.

## Global Constraints

- The test action must not invoke AI, Skills, report generation, scheduling, `analysis_runs`, or `email_deliveries`.
- The request body is empty and the backend uses only the currently saved configuration.
- Errors must not expose SMTP passwords, authorization codes, model API keys, or stack traces.
- The test message has no attachment and uses subject `日报分析系统 SMTP 测试邮件`.
- Existing formal email delivery and idempotency behavior must remain unchanged.

---

### Task 1: Backend SMTP test boundary

**Files:**
- Create: `daily-api/src/main/java/com/company/daily/email/SmtpTestEmailService.java`
- Create: `daily-api/src/main/java/com/company/daily/email/SmtpTestEmailController.java`
- Create: `daily-api/src/main/java/com/company/daily/email/SmtpTestEmailResponse.java`
- Test: `daily-api/src/test/java/com/company/daily/email/SmtpTestEmailServiceTest.java`

**Interfaces:**
- Consumes: `AnalysisConfigurationService#get()`, `SmtpSettings#fromConfiguration(...)`, `EmailGateway#send(...)`, `EnvironmentProperties`.
- Produces: `SmtpTestEmailService#send(): SmtpTestEmailResponse` and `POST /api/admin/configuration/email/test`.

- [ ] **Step 1: Write the failing service tests**

Create tests that construct `SmtpTestEmailService` with mocked `AnalysisConfigurationService` and `EmailGateway`. Assert that a valid saved configuration sends an `EmailMessage` with the saved recipients/CC, the fixed subject, an empty PDF, and merged SMTP settings. Add separate tests asserting disabled email, empty recipients, unusable SMTP host, and missing sender throw safe `IllegalArgumentException` messages.

```java
@Test
void sendsAStandaloneTestMessageUsingSavedConfiguration() {
  when(configurationService.get()).thenReturn(configuration());
  SmtpTestEmailResponse response = service.send();
  assertThat(response.sent()).isTrue();
  verify(gateway).send(messageCaptor.capture(), settingsCaptor.capture());
  assertThat(messageCaptor.getValue().subject()).isEqualTo("日报分析系统 SMTP 测试邮件");
  assertThat(messageCaptor.getValue().recipients()).containsExactly("manager@example.test");
  assertThat(messageCaptor.getValue().pdf()).isNull();
}
```

- [ ] **Step 2: Run the tests and verify RED**

Run:

```powershell
$env:JAVA_HOME='D:\codex\日报\.worktrees\scripted-skill-runtime\.tools\jdk21\jdk-21.0.12+8'
.\mvnw.cmd -Dtest=SmtpTestEmailServiceTest test
```

Expected: compilation fails because `SmtpTestEmailService` and `SmtpTestEmailResponse` do not exist.

- [ ] **Step 3: Implement the minimal test service and endpoint**

The service must build a message like this and call the gateway exactly once:

```java
EmailMessage message = new EmailMessage(configuration.recipients(), configuration.ccRecipients(),
    "日报分析系统 SMTP 测试邮件",
    "<p>这是一封由日报分析系统管理员主动触发的 SMTP 测试邮件。</p>"
        + "<p>发送时间：" + OffsetDateTime.now(BUSINESS_ZONE) + "</p>",
    null, null);
gateway.send(message, settings);
return new SmtpTestEmailResponse(true, "测试邮件已发送，请检查收件箱和垃圾邮件目录。");
```

Expose it through:

```java
@RestController
@RequestMapping("/api/admin/configuration/email")
class SmtpTestEmailController {
  @PostMapping("/test")
  SmtpTestEmailResponse test() { return service.send(); }
}
```

Validate `emailEnabled`, recipients, `settings.isUsable()`, and nonblank `settings.from()` before invoking the gateway. Use only fixed safe validation messages.

- [ ] **Step 4: Verify backend GREEN and lint**

Run:

```powershell
.\mvnw.cmd -Dtest=SmtpTestEmailServiceTest test checkstyle:check
```

Expected: all `SmtpTestEmailServiceTest` tests pass and Checkstyle reports 0 violations.

- [ ] **Step 5: Commit backend boundary**

```powershell
git add daily-api/src/main/java/com/company/daily/email daily-api/src/test/java/com/company/daily/email/SmtpTestEmailServiceTest.java
git commit -m "feat: add standalone smtp test email endpoint"
```

### Task 2: Technical-connections test action and end-to-end delivery

**Files:**
- Modify: `daily-web/src/api/admin.ts`
- Modify: `daily-web/src/views/admin/config/AdminTechnicalConnectionView.vue`
- Modify: `daily-web/tests/views/admin-configuration.spec.ts`

**Interfaces:**
- Consumes: `POST /api/admin/configuration/email/test` returning `{ sent: boolean; message: string }`.
- Produces: `adminApi.sendTestEmail()` and a `[data-testid="send-test-email"]` button.

- [ ] **Step 1: Write the failing front-end test**

Extend the hoisted API mock with `sendTestEmail`. Mount the view, trigger the SMTP test button, and assert the API call and success message.

```ts
it('sends a standalone test email from the saved configuration', async () => {
  api.sendTestEmail.mockResolvedValue({ data: { sent: true, message: '测试邮件已发送' } })
  const wrapper = shallowMount(AdminTechnicalConnectionView, {
    global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
  })
  await flushPromises()
  await wrapper.find('[data-testid="send-test-email"]').trigger('click')
  await flushPromises()
  expect(api.sendTestEmail).toHaveBeenCalledOnce()
  expect(wrapper.text()).toContain('测试邮件已发送')
})
```

- [ ] **Step 2: Run the front-end test and verify RED**

Run:

```powershell
npm.cmd test -- --run tests/views/admin-configuration.spec.ts
```

Expected: test fails because the button and `sendTestEmail` API call do not exist.

- [ ] **Step 3: Implement the API method and UI state**

Add:

```ts
sendTestEmail: () => http.post<{ sent: boolean; message: string }>('/admin/configuration/email/test'),
```

Add `smtpTestPending` and `smtpTestMessage` refs plus a `sendTestEmail()` handler. Render the button in the SMTP card:

```vue
<button data-testid="send-test-email" type="button" class="button-secondary"
  :disabled="smtpTestPending" @click="sendTestEmail">
  {{ smtpTestPending ? '发送中…' : '发送测试邮件' }}
</button>
<span v-if="smtpTestMessage" class="feedback" role="status">{{ smtpTestMessage }}</span>
```

On failure, route the safe API error message through the existing `errorMessage` state.

- [ ] **Step 4: Verify frontend GREEN and production build**

Run:

```powershell
npm.cmd test -- --run tests/views/admin-configuration.spec.ts
npm.cmd run build
```

Expected: all configuration-view tests pass and Vite production build exits 0.

- [ ] **Step 5: Commit frontend action**

```powershell
git add daily-web/src/api/admin.ts daily-web/src/views/admin/config/AdminTechnicalConnectionView.vue daily-web/tests/views/admin-configuration.spec.ts
git commit -m "feat: add smtp test action to technical connections"
```

- [ ] **Step 6: Rebuild and perform real delivery verification**

Rebuild `daily-api` and `daily-web` in the existing `daily-phase2` Compose project without recreating PostgreSQL. Confirm all four containers are healthy. Log in to `/admin/technical-connections`, click “发送测试邮件” once, and verify the page returns the success response. Then inspect `/admin/runs` to confirm no new formal analysis run was created.

- [ ] **Step 7: Final verification**

Run the backend service tests, front-end view tests, front-end build, `git diff --check`, and Docker health inspection again. Report the exact result and ask the administrator to confirm receipt in the configured inbox and CC inbox.
