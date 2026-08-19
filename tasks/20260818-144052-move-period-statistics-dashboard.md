# Task: move-period-statistics-dashboard

## Goal

将填报累计统计从日报明细页迁移至管理驾驶舱，保留统计查询、人员分页和 Excel 导出能力。

## Acceptance criteria

- [x] 日报明细页仅保留筛选、列表和任务详情。
- [x] 驾驶舱展示当日概览及独立的周期填报统计区。
- [x] 周统计、月统计、自定义日期、人员分页和 Excel 导出均可用。
- [x] 前端 lint、构建通过。

## Scope exclusions

- 不修改后端统计接口、统计口径和既有日报数据。

## Verification

```text
npm run lint
npm run build
```
