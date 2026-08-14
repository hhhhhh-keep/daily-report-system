# 真实 Skills 中心设计

## 目标

将分析中心从散落的 JSON、Prompt 和报告模板配置，改为可上传、校验、试运行、版本化和发布的 Skill 包管理。系统只向 Skill 提供本系统的日报、项目、工作日历与快照数据，不授予数据库、网络或文件系统权限。

## 范围

固定维护六个槽位：日报/周报/月报各一对“规则 Skill”和“模板 Skill”。管理员上传 ZIP 包后，系统读取其中唯一的 `SKILL.md`，保存原始包和解析后的指令文本。每次运行只使用同一周期中已成对发布的两个版本。

不支持任意数量的 Skill 类型、外部工具调用、直连数据库、外部网址访问或用户自定义运行脚本。

## Skill 包约定

ZIP 根目录必须包含 `SKILL.md`；可包含 `assets/` 下的静态素材。系统拒绝路径穿越、软链接、可执行文件和超出大小限制的压缩包。`SKILL.md` 使用标准前置元数据：

```markdown
---
name: daily-workload-rule
description: 根据日报数据生成可追溯的日负荷分析。
---

分析时仅使用系统提供的数据包。输出每项结论的依据、置信说明和日报任务引用。
```

槽位由上传界面选择；系统不依赖用户在 Markdown 中重复填写周期或类型，避免一份包被误投到错误周期后静默运行。

## 数据与执行边界

系统按分析周期生成受控 JSON 数据包：日期窗口、日报与任务、项目生命周期/甘特活动、工作日历、17:30 与最终快照。规则 Skill 与数据包组成模型的第一轮请求，得到结构化分析草稿；模板 Skill、分析草稿和必要的来源摘要组成第二轮请求，得到 HTML 报告。

模型响应必须通过系统定义的最小结果校验：分析草稿必须含结论、判断依据和引用的日报任务；模板结果只能返回 HTML 片段，系统会过滤脚本、事件属性、外链和危险 URL。系统继续保存 source snapshot、两个 Skill 版本、模型名称、原始分析结果与渲染报告，保证历史可追溯。

## 生命周期

1. 上传包后创建 DRAFT 版本，显示包名、版本、描述、上传时间和校验结果。
2. 选择历史周期执行“试运行”。规则试运行成功后生成分析草稿；模板试运行在规则草稿基础上生成可预览报告。
3. 同周期的一对 DRAFT 都试运行成功时，管理员可“成对发布”。发布会将当前发布对归档，两个新版本同时生效。
4. 定时与手动分析只读取发布对。规则失败则本次分析失败且不发邮件；模板失败则保留分析草稿、标记渲染失败且不发邮件。
5. 每个版本和已发布对均可下载原 ZIP；历史运行始终关联当时发布的版本，不能被后续上传覆盖。

## 页面与导航

“Skills 中心”不再显示占位卡片，而是：

- 周期切换：日报、周报、月报；
- 两个明确的槽位：规则 Skill、模板 Skill；
- 每槽位展示当前发布版、草稿列表、上传、下载与试运行；
- 成对发布区：显示两侧试运行状态，仅在两者成功后可发布；
- 试运行历史：周期、数据窗口、模型状态、分析预览/报告预览和失败原因。

“运行计划”仍只负责 17:30/22:00 和日/周/月时间；“技术连接”仍只负责模型与邮件。

## 数据模型

新增 `analysis_skill_versions`：`id`、`period`、`kind(RULE/TEMPLATE)`、`version_number`、`status(DRAFT/PUBLISHED/HISTORICAL)`、`skill_name`、`description`、`package_name`、`package_bytes`、`skill_markdown`、`checksum`、`validation_message`、`trial_succeeded_at`、`published_at`、`created_at`。

新增 `analysis_skill_trials`：`id`、`period`、`rule_skill_version_id`、`template_skill_version_id`、`period_start`、`period_end`、`status`、`source_snapshot_json`、`analysis_draft`、`rendered_html`、`error_summary`、`started_at`、`finished_at`。

扩展 `analysis_runs`，记录 `rule_skill_version_id` 与 `template_skill_version_id`。既有规则版本表和旧 UI 停止用于新运行，但保留历史数据，避免破坏旧运行查询。

## 验收

- 管理员可以为六个固定槽位上传 ZIP、看到校验失败原因并下载已保存包。
- 管理员可以针对历史周期成对试运行，并看到规则草稿和模板报告预览。
- 只有规则与模板试运行均成功时才能成对发布；定时运行只使用发布对。
- Skill 无法读取系统范围之外的数据，也不能执行 SQL、脚本或外部网络调用。
- 每次运行保存输入快照和两个 Skill 版本；现有日报填报、运行计划、技术连接与历史分析查询不受影响。
