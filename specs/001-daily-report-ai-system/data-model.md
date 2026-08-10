# 数据模型

| 实体 | 字段与规则 |
|---|---|
| 人员基础数据（Employee） | id、姓名、所属小组、岗位/类型、是否在岗；由管理员维护。 |
| 项目基础数据（Project） | id、名称、客户、行业、阶段、负责人、优先级、状态、可选编码。 |
| 日报主表（DailyReport） | id、report_date、employee_id、attendance_status、status、submitted_at、created_at、updated_at；`(employee_id, report_date)` 唯一。 |
| 工作任务明细（DailyTask） | id、report_id、time_period、project_id、work_type、participation_role、progress_result、current_status、issue_type、collaboration_role、collaboration_requirement；一份日报有 N 条。 |
| AnalysisConfig | dictionaries、AI rules、prompt versions、dimensions、schedules、recipients、templates 和 model settings。 |
| AnalysisRun | timing、selected dimensions、outcome、report reference、email result、error 和 retry metadata。 |

`time_period`：morning、afternoon、full-day、fragmented。`participation_role`：owner、collaborator、temporary-support。`current_status`：completed、progressing、waiting-feedback、at-risk、blocked。

Employee 1—N DailyReport；DailyReport 1—N DailyTask；Project 1—N DailyTask。当日保存更新既有日报。分析读取 reports/tasks，仅写入结果和运行产物。
