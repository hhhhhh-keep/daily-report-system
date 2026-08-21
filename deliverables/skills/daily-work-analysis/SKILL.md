---
name: daily-work-analysis
description: 基于受控日报数据包生成可追溯、可校验的日报管理事实与语义分析；适用于日报填报、出勤、人员工作事项、项目动态、协同、风险和次日关注分析。
---

# 日报规则分析

本 Skill 只分析宿主提供的受控 DataPackage，不访问数据库或网络，不生成 Word。详细业务口径见 [references/rules.md](references/rules.md)。

## 固定执行顺序

1. 读取根目录 `manifest.json`，由宿主按 `runtime_profile=daily-python-3.12-v1` 启动隔离运行时。
2. 执行 `scripts/run_prepare_facts.py`，校验数据包并生成 `daily-facts.json`。
3. 所有人数、比率、事项数、项目停滞工作日数均以 `daily-facts.json` 为准，模型不得重算或覆盖。
4. 如宿主启用大模型，只向模型提供事实包；按下述“模型输出配方”生成 JSON，不得输出解释、Markdown 或代码围栏。
5. 执行 `scripts/run_validate_analysis.py`。模型结果未通过 Schema 或证据校验时，丢弃模型结果，但仍将完整确定性事实交给模板 Skill。

## 必须产生的确定性事实

- `attendance_summary`：应填人数、17:30/22:00提交人数及比率、未填/全天请假/半天请假/待核验实名名单。
- `efficiency_summary`：逐人事项数、完成/进行中/阻塞数、涉及项目数，并作为模型关联具体项目、动作、产出和协同证据的人员索引。仅作管理观察，不直接等同绩效排名。
- `formal_project_dynamics`：正式项目状态、阶段、负责人、当天主导/协同人员、事项与产出及证据。
- `unlinked_project_dynamics`：日报出现但尚未与正式项目关联的候选事项。
- `stale_project_alerts`：正式在管项目超过阈值工作日无日报动态的关注项。
- `project_continuity`：覆盖窗口内项目出现日期、人员、动作、产出、状态证据及“新增/持续/中断候选”等确定性分类。
- `project_associations`：仅依据任务项目 ID 与主导/协同关系，生成同项目多人、一人多项目和跨组协同事实。
- `risk_assessment`：依据明确阻塞、连续动态集中、信息中断候选和超期无动态项目生成风险候选，并保留边界说明。

## 模型输出配方

模型接收的是已经完整计算的 `daily-facts/1.2.0`，必须直接综合这些事实，不得声称“未提供原始数据”或要求再次上传数据。输出且只输出一个 `daily-analysis/1.2.0` JSON 对象，字段顺序如下：

1. `data_contract_version`：固定为 `1.2.0`；
2. `overall_judgment`：整体管理判断；
3. `efficiency_insights`：人员效能观察；
4. `continuity_analysis`：项目连续性分析；
5. `association_analysis`：项目关联性及协同分析；
6. `risk_items`：风险分析；
7. `next_day_actions`：管理建议与下一步行动。

除版本号外，每个对象统一使用：

```json
{
  "summary": "基于事实的管理结论",
  "person_ids": [],
  "project_id": null,
  "evidence_ids": ["已有证据ID"],
  "limitation_note": null
}
```

- `overall_judgment` 是单个对象，其余六个语义章节是对象数组。
- 当对应确定性事实数组非空时，`continuity_analysis`、`association_analysis`、`risk_items` 不得为空。
- 每项只引用事实包中存在的人员、项目和证据；无法证明的单项直接省略，不得把整份分析替换成错误提示。
- 结论需解释管理含义，但不得新增项目阶段、完成、验收、付款、收入或期限事实。
- 所有 `summary` 与 `limitation_note` 必须使用面向管理者的中文表述；不得输出字段名、枚举值、代码、英文角色或内部标识（例如 `merge_status`、`manual_confirmation_status`、`lead`、`unmerged`、`project_status_coverage`）。日报中新出现的项目仅说明当日动态，不得要求“确认关联关系”。
- `efficiency_insights` 不得为空；每项至少填写一个 `person_id`，正文必须写出真实姓名，并结合证据说明具体项目/专项、动作、产出、主导/协同或明确问题，不得只写事项数量或笼统评价。
- `暂无正式项目`、`内部专项`仅为系统占位分类，不得进入任何面向领导的语义结论。

## 校验失败后的定向修复

宿主会把校验器返回的 `repair_requirements` 连同原候选 JSON 交给修复轮。修复轮必须仅修改这些 `path` 及其必要关联字段，保留已通过校验的内容：

- `EFFICIENCY_MISSING_PERSON_NAME`：在对应 `summary` 写出 `person_ids` 中至少一人的真实姓名；
- `MISSING_REQUIRED_ANALYSIS`：对应事实区块非空时，补充至少一条引用已有 `evidence_ids` 的分析；
- 未知人员、项目或证据 ID：删除虚构 ID，改用事实包已有 ID；
- 重建项目：补充说明“状态为事后重建”的 `limitation_note`。

修复后必须仍输出完整的 `daily-analysis/1.2.0` JSON 对象，不得清空其他必填语义区块。

## 阻断原则

- 不得编造人员、项目、阶段、产出、风险或证据 ID。
- 全天请假不要求任务且不计未填；半天请假只核验另一个应工作时段。
- `first_submitted_at` 用于17:30口径；修改不得改变首次提交判定。
- 项目状态来自项目维护快照；历史快照若为重建值，必须保留 `snapshot_origin=reconstructed`。
- 模型失败不得导致报告关键章节为空；模板必须使用事实包生成完整基础报告。
- “事实包不完整或未提供”“无法生成整体判断”“未调用模型或模型结果未通过校验”等占位文本属于失败结果，必须阻断，不能进入报告。
- 引用 `snapshot_origin=reconstructed` 项目的语义结论必须填写 `limitation_note`，明确该状态为事后重建，不得当作分析日实时快照。
