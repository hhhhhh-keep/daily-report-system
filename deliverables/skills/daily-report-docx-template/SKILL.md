---
name: daily-report-docx-template
description: 将日报规则 Skill 生成的确定性事实和可选的证据校验AI分析，渲染为固定格式、适合领导阅读的Word日报。
---

# 日报 Word 模板

本 Skill 只负责排版，不访问数据库或网络，不重新计算指标。输入必须是规则 Skill 生成并通过 Schema 校验的 `daily-facts.json`；`daily-analysis.json` 为可选增强输入。

## 固定流程

1. 宿主读取 `manifest.json`，按 `runtime_profile=daily-python-3.12-v1` 启动隔离运行时。
2. 使用 `assets/daily-report-template.docx` 中定义的 Letter 页面、字体和标题样式，通过 `scripts/run_render_docx.py` 生成 `report.docx`；渲染器不得覆盖模板的全局版式。
3. 使用 `scripts/audit_daily_report.py` 校验标题、章节、实名名单、页面设置和模板锚点。
4. AI结果缺失或未通过证据校验时，只忽略AI补充；填报、出勤、人员效能、项目动态、超期提醒和管理建议仍必须完整输出。兜底正文只能呈现项目、事项数量、状态和规则生成的简要说明；日报原文仅作为后台证据，禁止直接写入 Word。

## 固定报告结构

1. 标题与报告日期；
2. 中文报告日期与五工作日覆盖周期；
3. 简洁驾驶舱；
4. 一、总体概况；
5. 二、填报与出勤情况（含应填、17:30、22:00和实名名单）；
6. 三、人员效能分析；
7. 四、项目连续性分析；
8. 五、项目关联性及协同分析；
9. 六、风险评估；
10. 七、管理建议。

驾驶舱可使用表格，后续分析统一采用公文式编号段落。版式细则见 [references/layout.md](references/layout.md)，稳定接口见 [references/template-contract.md](references/template-contract.md)。不得出现“领导版”、假数据、技术状态码、占位人名、“待人工补充”或模型错误占位文本。

人员效能优先采用证据校验通过的AI观察，必须具体到姓名、项目/专项、动作、产出及主导/协同或明确问题；正文统一隐藏系统占位项目、数据口径说明及内部人员/项目ID。
