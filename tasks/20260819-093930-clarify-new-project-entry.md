# Task: clarify-new-project-entry

## Goal

精简项目名称输入提示，并明确支持直接输入新项目名称后随日报新增。

## Acceptance criteria

- [x] 项目名称输入提示简洁且说明可直接新增。
- [x] 已有项目仍可按关键字筛选选择，直接输入名称仍保留保存逻辑。
- [x] 前端构建与静态检查通过；仅修改测试环境。

## Scope exclusions

- 不修改项目维护页面、后端新增逻辑、数据库或正式环境。

## Verification

```text
npm run build
npm run lint
```

## Evidence

- 后端 `CurrentReportService` 已有未匹配名称自动创建项目的实现，本次未修改该行为。
- `npm run build`、`npm run lint` 通过；测试页面返回 HTTP 200，新增项目提示源码断言通过。

## Critique

PASS — 仅明确既有的自动新增能力，未改变后端、数据库或正式环境。
