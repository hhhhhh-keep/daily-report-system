# 分析配置页系统保护规则说明 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 在分析配置页展示不可绕过的 AI 分析保护规则说明。

**Architecture:** 仅修改 Vue 配置视图与其现有 Vitest 视图测试。说明卡片位于统计计划和可编辑分析配置之前，不接入任何 API，因此不会改变保存或调度行为。

**Tech Stack:** Vue 3、TypeScript、Vitest、Vue Test Utils。

## Global Constraints

- 不新增后端接口、数据库字段或权限。
- 保持现有统计计划与分析配置保存行为不变。
- 所有中文文本必须为 UTF-8，不得出现乱码或替换字符。

---

### Task 1: 在配置页展示保护规则说明

**Files:**
- Modify: `daily-web/src/views/admin/config/AdminConfigurationView.vue`
- Modify: `daily-web/tests/views/admin-configuration.spec.ts`

**Interfaces:**
- Consumes: 现有 `AdminConfigurationView` 与测试中的 `shallowMount`。
- Produces: 不依赖 API 的只读 `.analysis-guardrails` 说明区域。

- [ ] **Step 1: 写入失败测试**

在 `AdminConfigurationView` 的视图测试中新增断言：

```ts
expect(wrapper.text()).toContain('系统保护规则')
expect(wrapper.text()).toContain('AI 辅助判定')
expect(wrapper.text()).toContain('不得自动用于绩效、奖惩或人员处置')
expect(wrapper.find('.analysis-guardrails').exists()).toBe(true)
```

- [ ] **Step 2: 运行测试确认失败**

Run: `npm test -- tests/views/admin-configuration.spec.ts`

Expected: 新增断言因页面尚无说明卡片而失败。

- [ ] **Step 3: 实现最小页面说明**

在配置页标题之后、统计计划表单之前添加：

```vue
<section class="analysis-guardrails" aria-labelledby="analysis-guardrails-title">
  <h2 id="analysis-guardrails-title">系统保护规则</h2>
  <p>业务分析规则与 Prompt 模板可自由维护；以下保护规则始终生效，不能通过配置关闭。</p>
  <ul>
    <li>所有个人负荷和风险结论均为 AI 辅助判定，并展示判断依据与日报证据。</li>
    <li>漏填人员单独统计，不推断其工作负荷；17:30 快照仅作为辅助信号。</li>
    <li>分析结果仅供管理参考，不得自动用于绩效、奖惩或人员处置。</li>
  </ul>
</section>
```

并使用现有页面卡片风格添加最小样式。

- [ ] **Step 4: 运行视图测试确认通过**

Run: `npm test -- tests/views/admin-configuration.spec.ts`

Expected: PASS。

- [ ] **Step 5: 完整前端验证**

Run: `npm test && npm run lint && npm run build`

Expected: 三个命令均成功。
