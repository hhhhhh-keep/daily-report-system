# Task: import-official-workday-calendar

## Goal

管理员粘贴国务院官方公告链接后，系统自动解析节假日和补班日期，预览确认后写入所选年度日历。

## Acceptance criteria

- [x] 仅接受 HTTPS 的 `gov.cn` 官方链接，并可从公告正文提取节假日及补班日期。
- [x] 管理页可预览解析结果并由管理员确认后导入，不能自动覆盖日历。
- [x] 以 2026 年中国政府网公告完成实际解析验证；前后端测试、构建与静态检查通过。

## Scope exclusions

- 不修改已存在的人工配置、不修改正式环境、不引入 AI 或第三方日历服务。

## Verification

```text
./mvnw.cmd -Dtest=OfficialWorkdayCalendarNoticeParserTest test
npx vitest run tests/views/admin-workday-calendar.spec.ts
npm run build
npm run lint
```

## Verification evidence

- 后端独立目录：`OfficialWorkdayCalendarNoticeParserTest` 1 项通过，Checkstyle 0 违规。
- 前端：工作日历组件测试 2 项通过，`npm run build`、`npm run lint` 通过。
- 本机测试后端健康检查为 `UP`。以中国政府网 2026 年官方公告实际预览并确认导入：33 个节假日、6 个补班，共 39 条；未改动人工配置。
