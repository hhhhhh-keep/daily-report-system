# Task: simplify-ai-fallback-message

## Goal

AI 降级时只向管理员展示简短中文说明，不展示内部 JSON 或英文校验码。

## Acceptance criteria

- [x] 新降级记录不保存原始校验 JSON。
- [x] 历史任务记录的“AI 降级原因”和“失败原因”都以简短中文展示。
- [x] 前端定向测试和构建通过。

## Scope exclusions

- 不影响后台日志中的完整诊断信息，不改变降级机制。

## Verification

```text
Maven 定向测试、Vitest 组件测试、前端构建。

## Verification evidence

- `SkillAnalysisExecutorTest` 通过。
- `npx vitest run tests/views/admin-analysis.spec.ts tests/views/admin-skills.spec.ts`：12 项通过。
- `npm run build` 通过；后端重启后的健康检查为 `UP`。

- “失败原因”列的历史校验 JSON 已使用同一中文摘要规则展示；`admin-analysis.spec.ts` 与前端构建通过。

## Verification evidence

- `AnalysisSkillServicePersistenceTest` 通过。
- `npx vitest run tests/views/admin-skills.spec.ts`：8 项通过。
- `npm run build` 通过；本机后端健康检查为 `UP`。
- 已发布 Daily 规则 v10 / 模板 v15 的重复发布接口调用成功。
```

