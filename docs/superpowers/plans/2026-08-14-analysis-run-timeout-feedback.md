# AI 分析手动运行超时与状态反馈 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 让 AI 分析中心等待长耗时 Skill 流程完成，不再在 15 秒时误报断线，并向管理员展示运行、AI 和邮件结果。

**Architecture:** 保留全局 Axios 15 秒超时，仅在 `adminApi.runNow` 上覆盖为 240 秒。页面继续使用同步请求和已有 `pending` 防重入状态，在等待期间显示耗时说明，返回后使用 `AnalysisRun` 的状态字段生成管理提示。

**Tech Stack:** Vue 3、TypeScript、Axios、Vitest、Vue Test Utils、Vite

## Global Constraints

- 仅修改手动分析请求和 AI 分析中心反馈，不修改后端分析、报告、邮件流程。
- 专用超时固定为 `240_000` 毫秒；全局超时继续为 `15_000` 毫秒。
- 不新增异步任务、轮询、队列或基础设施。
- 使用现有 `pending` 状态禁止重复提交。
- 所有行为修改必须先有失败测试。

---

### Task 1: 手动分析请求专用超时

**Files:**
- Create: `daily-web/tests/api/admin-runs.spec.ts`
- Modify: `daily-web/src/api/admin.ts`

**Interfaces:**
- Consumes: `http.post<AnalysisRun>(url, body, config)`
- Produces: `adminApi.runNow(date?: string, period?: AnalysisPeriod)`，其请求配置包含 `timeout: 240_000`

- [ ] **Step 1: 写失败测试**

```ts
import { describe, expect, it, vi } from 'vitest'

const { post } = vi.hoisted(() => ({ post: vi.fn() }))
vi.mock('@/api/http', () => ({ http: { post } }))

import { adminApi } from '@/api/admin'

describe('adminApi.runNow', () => {
  it('allows enough time for the model-backed analysis to finish', () => {
    adminApi.runNow('2026-07-31', 'DAILY')

    expect(post).toHaveBeenCalledWith('/admin/runs', undefined, {
      params: { date: '2026-07-31', period: 'DAILY' },
      timeout: 240_000,
    })
  })
})
```

- [ ] **Step 2: 运行测试并确认失败**

Run: `pnpm --dir daily-web vitest run tests/api/admin-runs.spec.ts`

Expected: FAIL，因为当前调用配置没有 `timeout: 240_000`。

- [ ] **Step 3: 最小实现专用超时**

将 `daily-web/src/api/admin.ts` 中的实现改为：

```ts
runNow: (date?: string, period: AnalysisPeriod = 'DAILY') =>
  http.post<AnalysisRun>('/admin/runs', undefined, {
    params: { date, period },
    timeout: 240_000,
  }),
```

- [ ] **Step 4: 运行测试并确认通过**

Run: `pnpm --dir daily-web vitest run tests/api/admin-runs.spec.ts`

Expected: PASS，1 个测试通过。

- [ ] **Step 5: 提交**

```bash
git add daily-web/tests/api/admin-runs.spec.ts daily-web/src/api/admin.ts
git commit -m "fix: allow long-running manual analysis"
```

### Task 2: 分析中提示和完成状态

**Files:**
- Modify: `daily-web/tests/views/admin-analysis.spec.ts`
- Modify: `daily-web/src/views/admin/analysis/AdminAnalysisView.vue`

**Interfaces:**
- Consumes: `adminApi.runNow(...): Promise<AxiosResponse<AnalysisRun>>`
- Produces: 等待提示“AI 分析中，预计需要 1～3 分钟，请勿重复提交。”以及包含运行、AI、邮件状态的完成提示

- [ ] **Step 1: 写失败测试**

在 `daily-web/tests/views/admin-analysis.spec.ts` 增加：

```ts
it('keeps the action disabled and shows progress while analysis is running', async () => {
  let finish!: (value: unknown) => void
  api.runNow.mockImplementation(() => new Promise(resolve => { finish = resolve }))
  const wrapper = shallowMount(AdminAnalysisView, {
    global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
  })
  await flushPromises()

  await wrapper.find('[data-testid="run-analysis"]').trigger('click')

  expect(wrapper.find('[data-testid="run-analysis"]').attributes('disabled')).toBeDefined()
  expect(wrapper.text()).toContain('AI 分析中，预计需要 1～3 分钟，请勿重复提交')
  finish({ data: { status: 'succeeded', llmStatus: 'succeeded', emailStatus: 'sent' } })
})

it('shows run, AI and email status after completion', async () => {
  api.runNow.mockResolvedValue({
    data: { status: 'succeeded', llmStatus: 'succeeded', emailStatus: 'sent' },
  })
  const wrapper = shallowMount(AdminAnalysisView, {
    global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
  })
  await flushPromises()

  await wrapper.find('[data-testid="run-analysis"]').trigger('click')
  await flushPromises()

  expect(wrapper.text()).toContain('运行：成功')
  expect(wrapper.text()).toContain('AI：成功')
  expect(wrapper.text()).toContain('邮件：已发送')
})
```

- [ ] **Step 2: 运行页面测试并确认失败**

Run: `pnpm --dir daily-web vitest run tests/views/admin-analysis.spec.ts`

Expected: FAIL，因为页面尚无耗时提示和三项状态文案。

- [ ] **Step 3: 实现状态映射和页面反馈**

在 `AdminAnalysisView.vue` 中加入状态映射：

```ts
function runStatus(value: string | null | undefined) {
  return ({ succeeded: '成功', 'partial-failure': '部分失败', failed: '失败', running: '运行中' } as Record<string, string>)[value || ''] || '未知'
}
function llmStatus(value: string | null | undefined) {
  return ({ succeeded: '成功', failed: '失败', skipped: '未执行' } as Record<string, string>)[value || ''] || '未执行'
}
function emailStatus(value: string | null | undefined) {
  return ({ sent: '已发送', failed: '发送失败', 'skipped-duplicate': '已跳过（该日期已发送）', 'not-requested': '未启用' } as Record<string, string>)[value || ''] || '未执行'
}
```

将 `runNow` 成功分支改为读取响应：

```ts
const response = await adminApi.runNow(endDate.value, period.value)
const run = response.data
message.value = `分析完成。运行：${runStatus(run.status)}；AI：${llmStatus(run.llmStatus)}；邮件：${emailStatus(run.emailStatus)}`
await load()
```

在操作区后增加：

```vue
<p v-if="pending" class="feedback" role="status">AI 分析中，预计需要 1～3 分钟，请勿重复提交。</p>
```

- [ ] **Step 4: 运行页面测试并确认通过**

Run: `pnpm --dir daily-web vitest run tests/views/admin-analysis.spec.ts`

Expected: PASS，全部分析中心页面测试通过。

- [ ] **Step 5: 提交**

```bash
git add daily-web/tests/views/admin-analysis.spec.ts daily-web/src/views/admin/analysis/AdminAnalysisView.vue
git commit -m "fix: show manual analysis progress and outcomes"
```

### Task 3: 构建、部署和端到端验证

**Files:**
- Modify only if verification exposes a defect: files from Tasks 1–2

**Interfaces:**
- Consumes: built `daily-web` Docker image and existing `/api/admin/runs`
- Produces: deployed AI 分析中心，15 秒后仍保持“分析中”，最终展示真实状态

- [ ] **Step 1: 运行前端测试**

Run: `pnpm --dir daily-web test`

Expected: PASS，0 个失败。

- [ ] **Step 2: 运行生产构建**

Run: `pnpm --dir daily-web build`

Expected: exit code 0。

- [ ] **Step 3: 重建并部署前端**

```powershell
docker compose -p daily-phase2 -f docker/docker-compose.yml build daily-web
docker compose -p daily-phase2 -f docker/docker-compose.yml up -d daily-web nginx
```

Expected: `daily-web` 和 `nginx` 均为 healthy。

- [ ] **Step 4: 浏览器端到端验证**

选择 `DAILY`、结束日期 `2026-07-31`，点击一次“运行分析”。等待超过 15 秒，确认页面仍显示分析中且按钮不可用；等待完成后确认页面展示运行、AI、邮件状态，不出现“暂时无法连接服务器”。

- [ ] **Step 5: 数据库验证**

只读查询最新 `analysis_runs` 和 `email_deliveries`，确认最新运行结束、AI 状态与页面一致，邮件遵循成功去重规则。

- [ ] **Step 6: 最终提交检查**

```bash
git diff --check
git status --short
```

Expected: 无未提交的本次任务改动；用户原有未跟踪文件保持不变。

