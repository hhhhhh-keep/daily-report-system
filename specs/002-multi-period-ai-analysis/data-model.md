# 数据模型

## 已有实体的增量

| 实体 | 增量 | 规则 |
|---|---|---|
| `daily_reports` | `first_submitted_at`、`locked_at`、最终质量提示 | 首次提交不可改；锁定后拒绝一切修改 |
| `daily_tasks` | 复用 `work_stage`、`issue_description`、`current_status` | 阻碍/暂停必填说明，非阻碍/暂停清空说明 |
| 团队成员 | 启用状态 | 22:00 快照读取启用成员 |

## 新实体

| 实体 | 关键字段 | 规则 |
|---|---|---|
| `workday_calendar` | `calendar_date`, `is_workday`, `source`, `active` | `(calendar_date, source)` 唯一；人工覆盖优先 |
| `report_statistics_configuration` | 17:30/22:00 启用与 Cron | Cron 可编辑，服务内统一工作日守卫 |
| `report_statistics_snapshot` | `snapshot_date`, `snapshot_type`, `expected_people`, `submitted_people`, `missing_people`, `late_people`, `team_breakdown`, `report_snapshot` | `(snapshot_date, snapshot_type)` 唯一；EARLY/FINAL 独立 |
| `analysis_rule_version` | `period`, `version`, `status`, `change_note`, `rules`, `prompt`, `custom_schema` | 每周期最多一个 PUBLISHED；草稿不可调度 |
| `analysis_execution` | `period`, `period_start/end`, `trigger`, `status`, `attempt`, `source_snapshot`, `rule_snapshot`, `prompt_snapshot`, `schema_snapshot`, `model_name`, `result` | 每次成功或失败均保留；历史不覆盖 |
| `analysis_report` | `execution_id`, `version`, `display_data`, `html`, `pdf_reference`, `distribution_status` | 默认查询最新成功版本 |
| `analysis_distribution` | `report_id`, `sent_at`, `recipients`, `cc`, `mode`, `status`, `error_summary` | 自动、重试、手动重发各一条 |

## 当前实现映射

`analysis_runs` 承担 `analysis_execution` 的存储职责：已保存 `analysis_period`、周期起止日、规则/Prompt/Schema/模型快照及源快照；`analysis_rule_versions` 保存旧版规则历史。V014 新增 `analysis_skill_versions` 与 `analysis_skill_trials`：日报、周报、月报各固定规则/模板两个槽位，ZIP 包经校验后版本化保存；只有同一次试运行成功的一对草稿可成对发布。新运行关联已发布的两个 Skill 版本与输入快照。数据库迁移为 V007（工作日历）、V008（填报快照）、V009（日锁定）、V010/V011（多周期分析与默认规则）、V014（Skills 中心）。

## 源快照结构

`source_snapshot` 必须包含：周期工作日列表、22:00 最终快照、17:30 快照、应填成员名单、已提交/漏填名单、每份日报和任务的稳定 ID、出勤、首次提交时间、最终工作内容、阶段、角色、状态与阻碍说明。

## AI 结果基础结构

```json
{
  "summary": {},
  "workload": [{"employeeId": 1, "label": "high|medium|low|insufficient", "confidence": "high|medium|low", "reasons": [], "taskIds": []}],
  "projects": [{"name": "", "status": "", "risks": [], "taskIds": []}],
  "collaboration": [],
  "qualityHints": [],
  "managementSuggestions": [{"suggestion": "", "taskIds": []}],
  "custom": {}
}
```

所有 `taskIds` 必须属于源快照；自定义字段按 `custom_schema` 验证。
