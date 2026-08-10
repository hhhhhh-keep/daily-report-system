# 验证指南

## 前置条件

通过环境变量提供 PostgreSQL、LLM endpoint 和 SMTP credentials。实施提供可运行命令后，启动 `nginx`、`daily-web`、`daily-api` 和 `postgres`。

## 场景

1. 创建 Employee 和 Project 主数据，包含一个 non-formal option。
2. 打开 `/report`，选择 employee/date/attendance，新增 morning/afternoon 任务并保存。
3. 当天重新打开，更新一条任务，验证仍只有一份含多个明细的日报。
4. 登录 `/admin`；验证日报、任务、主数据、驾驶舱和配置。
5. 配置 AI rules、Prompt、dimensions、schedule 和 recipients；运行分析并验证人员效能、项目风险、资源建议、HTML/PDF 输出、邮件和运行记录。
6. 模拟模型/邮件失败；验证错误可见且可 manual retry，且不会重复成功邮件。

## 完成门禁

代码完成前，前端/后端 `test`、`lint`、`build`、migration、契约和容器检查必须通过。本规划不创建应用代码或任务列表。
