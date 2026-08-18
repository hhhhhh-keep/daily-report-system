# 填报累计统计优化设计

## 目标

让管理员按任意起止日期查看人员填报累计统计，并可分页浏览和导出完整 Excel。

## 交互

- “周统计”和“月统计”仍按所选结束日期定位完整自然周或自然月。
- 管理员可输入“统计开始日期”和“统计结束日期”，点击“查询统计”后按闭区间计算；日期不完整或开始晚于结束时不发起请求并显示错误。
- 部门合计始终固定显示。人员明细每页 20 条，使用既有分页组件。
- “导出 Excel”下载当前选定范围的完整人员清单，不受当前页影响。

## 接口

- 原 `GET /api/admin/reports/period-statistics?period&anchor` 保持兼容。
- 新增 `GET /api/admin/reports/period-statistics?start&end`，返回相同统计结构，`period=CUSTOM`。
- 新增 `GET /api/admin/reports/period-statistics/export?start&end`，返回 XLSX；文件包含统计范围、工作日数、部门合计和全部人员明细。

## 边界

- 统计范围为含起止日期的闭区间，仅工作日计入应填数。
- 导出使用与页面完全相同的统计服务，避免数据口径不一致。
- Excel 只提供该统计页已展示的字段，不包含日报原文或任务明细。
