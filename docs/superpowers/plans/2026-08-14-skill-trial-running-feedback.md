# Skill Trial Running Feedback Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 在 Skills 中心试运行期间立即显示进行中提示并阻止重复提交，结束后恢复现有成功、降级或失败反馈。

**Architecture:** 仅在 `AdminSkillsView.vue` 内增加一个本地布尔状态，不改变同步 API 或后端协议。`runTrial()` 使用 `try/catch/finally` 管理状态生命周期，模板根据状态切换按钮文字、禁用属性和状态提示。

**Tech Stack:** Vue 3 Composition API、TypeScript、Vue Test Utils、Vitest。

## Global Constraints

- 保持现有同步试运行 API，不新增任务查询或进度接口。
- 不显示百分比或不可验证的阶段进度。
- 请求结束后必须恢复按钮，无论成功、业务失败或异常。
- 不改变“成对发布”的资格判断。

---

### Task 1: 试运行进行中反馈

**Files:**
- Modify: `daily-web/src/views/admin/skills/AdminSkillsView.vue`
- Test: `daily-web/tests/views/admin-skills.spec.ts`

**Interfaces:**
- Consumes: `adminApi.trialAnalysisSkills(period, endDate, ruleVersionId, templateVersionId)` 返回的 Promise。
- Produces: 组件本地 `trialRunning: Ref<boolean>`；运行中状态文案“正在试运行，请稍候…”；按钮文案“正在试运行…”。

- [ ] **Step 1: 写入未完成 Promise 的失败测试**

在 `daily-web/tests/views/admin-skills.spec.ts` 增加测试：

```ts
it('shows a running state immediately and prevents duplicate trials', async () => {
  api.analysisSkills.mockImplementation((_period: string, kind: string) => Promise.resolve({
    data: [{ id: kind === 'RULE' ? 1 : 2, versionNumber: 1, status: 'DRAFT' }],
  }))
  let resolveTrial!: (value: unknown) => void
  api.trialAnalysisSkills.mockImplementation(() => new Promise(resolve => { resolveTrial = resolve }))
  const wrapper = shallowMount(AdminSkillsView, {
    global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
  })
  await flushPromises()

  const trialButton = wrapper.findAll('button').find(button => button.text() === '试运行所选版本')!
  await trialButton.trigger('click')

  expect(wrapper.find('[role="status"]').text()).toBe('正在试运行，请稍候…')
  expect(trialButton.attributes('disabled')).toBeDefined()
  expect(trialButton.text()).toBe('正在试运行…')

  resolveTrial({ data: {
    id: 10, period: 'DAILY', ruleSkillVersionId: 1, templateSkillVersionId: 2,
    periodStart: '2026-08-11', periodEnd: '2026-08-11', status: 'SUCCEEDED',
    analysisDraft: '{}', renderedHtml: '<section>report</section>', errorSummary: null,
    startedAt: '2026-08-14T03:00:00Z', finishedAt: '2026-08-14T03:00:01Z',
  } })
  await flushPromises()

  expect(trialButton.attributes('disabled')).toBeUndefined()
  expect(trialButton.text()).toBe('试运行所选版本')
  expect(wrapper.find('[role="status"]').text()).toContain('试运行成功')
})
```

- [ ] **Step 2: 运行测试确认其因缺少运行状态而失败**

Run:

```powershell
npm.cmd test -- --run tests/views/admin-skills.spec.ts
```

Expected: FAIL，状态提示为空或按钮仍显示“试运行所选版本”。

- [ ] **Step 3: 增加最小运行状态实现**

在 `AdminSkillsView.vue` 的状态区增加：

```ts
const trialRunning = ref(false)
```

将 `runTrial()` 改为：

```ts
async function runTrial() {
  if (!selected.value.RULE || !selected.value.TEMPLATE || trialRunning.value) return
  trialRunning.value = true
  message.value = '正在试运行，请稍候…'
  try {
    const response = await adminApi.trialAnalysisSkills(
      period.value, endDate.value, selected.value.RULE, selected.value.TEMPLATE,
    )
    const trial = response.data
    message.value = trial.status === 'SUCCEEDED'
      ? `试运行成功${trial.errorSummary ? `：${trial.errorSummary}` : '，可查看结果并下载报告'}`
      : `试运行失败：${trial.errorSummary ?? '请检查规则与模板 Skill'}`
    await load()
  }
  catch (error) { message.value = apiError(error).message }
  finally { trialRunning.value = false }
}
```

将试运行按钮改为：

```vue
<button
  class="button-secondary"
  type="button"
  :disabled="!selected.RULE || !selected.TEMPLATE || trialRunning"
  @click="runTrial"
>{{ trialRunning ? '正在试运行…' : '试运行所选版本' }}</button>
```

- [ ] **Step 4: 运行针对性测试并确认通过**

Run:

```powershell
npm.cmd test -- --run tests/views/admin-skills.spec.ts
```

Expected: 4 tests passed。

- [ ] **Step 5: 运行生产构建**

Run:

```powershell
npm.cmd run build
```

Expected: `vite build` 成功且 TypeScript 无错误。

- [ ] **Step 6: 重建 Web 与 Nginx 并做页面验证**

Run:

```powershell
docker compose -p daily-phase2 -f docker/docker-compose.yml up --build -d daily-web nginx
```

Expected: `daily-web` 与 `nginx` 容器处于 healthy；点击试运行后立即看到进行中提示和禁用按钮。

- [ ] **Step 7: 提交实现**

```powershell
git add daily-web/src/views/admin/skills/AdminSkillsView.vue daily-web/tests/views/admin-skills.spec.ts
git commit -m "fix: show skill trial running state"
```
