# Task: enable-admin-browser-password-save

## Goal

在内嵌浏览器未提供密码管理器提示时，让管理员可选择在本机浏览器保存密码并自动回填。

## Acceptance criteria

- [x] 勾选后仅在当前浏览器保存账号和密码，保存期为 30 天。
- [x] 密码在成功登录后才保存；过期或取消勾选时清除。
- [x] 页面明确说明仅适用于个人受控电脑。
- [x] 前端单测、构建与静态检查通过；仅修改测试环境。

## Scope exclusions

- 不传输密码到登录接口之外；不改动后端接口、权限或正式环境。

## Verification

```text
npx vitest run tests/views/admin-entry.spec.ts
npm run build
npm run lint
```

## 验证证据

- 成功登录后仅在当前浏览器的本地存储中写入账号、密码和 30 天到期时间；未勾选或到期时清除。
- `npx vitest run tests/views/admin-entry.spec.ts` 通过（6 项），覆盖回填、过期清理和成功登录后保存；`npm run build`、`npm run lint`、`git diff --check` 通过。
- 相关中文页面和测试文件未发现乱码。

## 独立复核

PASS — 用户明确要求在本机记住密码；实现只在勾选且成功登录后保存，提供个人受控电脑提示，未改动后端与正式环境。

## 验证证据

- 管理员登录表单设置 `autocomplete="on"`；用户名和密码字段分别使用 `name="username"`、`name="password"` 与对应的自动填充语义。
- `npx vitest run tests/views/admin-entry.spec.ts` 通过（3 项）；`npm run build`、`npm run lint` 通过。

## 独立复核

PASS — 使用浏览器原生密码管理器保存凭据，不在系统或服务端明文保存密码；仅改动测试环境前端。
