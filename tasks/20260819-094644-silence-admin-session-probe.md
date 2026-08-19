# Task: silence-admin-session-probe

## Goal

修复管理员登录页会话探测失败时错误弹窗的问题。

## Acceptance criteria

- [x] 未登录打开管理员入口不再出现“操作失败”弹窗。
- [x] 其他接口错误仍保留提示，空错误信息显示中文兜底文案。
- [x] 前端单测、构建与静态检查通过；仅修改测试环境。

## 验证证据

- 会话探测接口使用 `silent` 标记，未登录时不再触发全局错误提示。
- `apiError` 会将 `No message available` 归一为“操作失败，请稍后重试。 ”
- `npx vitest run tests/api/http.spec.ts tests/views/admin-entry.spec.ts` 通过（5 项）；`npm run build`、`npm run lint` 通过；`http://localhost:5180/admin` 返回 200。

## 独立复核

PASS — 仅让登录会话探测静默，其他业务接口的错误提示仍保留；未改动后端或正式环境。

## Scope exclusions

- 不改变登录会话、密码、权限、后端接口或正式环境。

## Verification

```text
npx vitest run tests/api/http.spec.ts tests/views/admin-entry.spec.ts
npm run build
npm run lint
```
