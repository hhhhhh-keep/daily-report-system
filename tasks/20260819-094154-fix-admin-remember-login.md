# Task: fix-admin-remember-login

## Goal

修复管理员“记住我（30 天）”无法自动恢复登录会话的问题。

## Acceptance criteria

- [x] 已记住的管理员会话打开登录页后自动进入驾驶舱。
- [x] 不保存或回填明文密码；未登录时仍显示登录表单。
- [x] 前端构建、静态检查和本机会话验证通过。

## Scope exclusions

- 不修改密码、权限、会话有效期或正式环境。

## Verification

```text
npm run build
npm run lint
本机登录响应与会话接口验证
```

## Evidence

- 登录响应包含 30 天有效期的会话 Cookie；携带该 Cookie 调用会话接口返回 HTTP 200。
- `AdminEntryView` 回归测试覆盖会话恢复跳转与未登录表单显示，2 项通过。
- `npm run build`、`npm run lint` 通过。

## Critique

PASS — 仅恢复既有会话，不保存密码、不改变会话有效期，且未部署正式环境。
