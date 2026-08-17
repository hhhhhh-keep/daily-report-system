# 脚本型 Skill 模型契约加载设计

## 背景与根因

脚本型日报规则 Skill 的根目录 `SKILL.md` 要求模型遵循 `references/rules.md` 和 `schemas/daily-analysis.schema.json`，但当前宿主调用模型时只传入数据库中保存的根目录 Markdown。模型没有收到引用规则和正式输出 Schema，因此生成了错误字段、错误层级和缺少证据 ID 的 JSON。现有自动修复请求同样没有提供 Schema 与首次校验错误，第二次输出仍无法通过校验，系统最终按安全策略生成基础报告。

## 目标

- 宿主从已上传的受控 ZIP 中自动装配完整模型指令。
- 首次调用和一次修复调用都获得同一正式分析契约。
- 保持 Schema、人员、项目和证据 ID 的严格校验，不允许未经验证的 AI 内容进入 Word。
- 兼容以后上传的其他 Skill Package 2.0 分析 Skill，不为当前日报 Skill 写死字段结构。
- 已上传版本直接生效，不要求重新上传 ZIP。

## 契约发现

`SkillManifest` 增加只读 `contracts` 映射。宿主读取 `contracts.analysis`，例如 `daily-analysis/1.0.0`，取斜杠前的契约名称 `daily-analysis`，并定位 ZIP 内的 `schemas/daily-analysis.schema.json`。

如果脚本型分析 Skill 声明了 `contracts.analysis`，但对应 Schema 不存在、不是 UTF-8 文本或不是合法 JSON，上传校验必须失败。这样问题在版本进入试运行前即可被发现。

## 模型指令装配

`SkillPackageValidator` 在现有安全解压和大小限制内构造 `analysisInstructions`，顺序固定为：

1. 根目录 `SKILL.md`；
2. 按路径排序的 `references/*.md`；
3. `contracts.analysis` 对应的 JSON Schema；
4. 宿主追加的强制输出说明：只返回一个符合 Schema 的 JSON 对象，不输出 Markdown、推理过程或额外字段，只能引用事实包中已有的人员、项目和证据 ID。

不把脚本源码、测试、Word 资产或其他二进制内容传给模型。

`ValidatedSkillPackage` 同时保留原始 `markdown` 和新装配的 `analysisInstructions`：前者用于展示与兼容，后者仅用于脚本型分析执行。

## 执行与修复流程

首次模型调用使用 `validatedRule.analysisInstructions()`，输入仍为确定性 `daily-facts.json`。

首次输出继续交给 Skill 自带的 Python 校验器。若失败，最多修复一次：

- 系统指令包含完整 `analysisInstructions`；
- 追加“修复候选结果”的明确说明；
- 输入包含确定性事实、首次候选 JSON 和首次校验错误；
- 校验错误限制长度，避免异常日志或模型输出造成无界提示词增长；
- 修复结果重新经过相同 Python Schema 与证据门禁。

第二次仍失败时保持当前降级策略，生成基础 Word，并明确显示“AI 语义分析未通过证据校验”。不得将首次或修复候选直接交给模板。

## 安全与兼容性

- 继续沿用 ZIP 路径穿越、文件类型、5MB 压缩包与解压大小限制。
- 引用文件仅允许现有白名单中的单层 `references/*.md`。
- Schema 仅使用清单声明的分析契约，不猜测文件名、不加载网络资源。
- 提示词型旧 Skill 没有 manifest，行为保持不变。
- 脚本型模板不调用模型，不受分析指令装配影响。

## 测试标准

- 验证器测试证明完整指令包含根 Markdown、引用规则和正式分析 Schema，且不包含脚本与资产内容。
- 验证器拒绝声明分析契约但缺少对应 Schema 的 ZIP。
- 执行器测试证明首次调用使用完整契约。
- 修复测试证明第二次调用包含完整契约、首次校验错误与候选内容，并且修复结果仍需通过原 Python 校验器。
- 原有脚本型 Skill、提示词型 Skill、前端试运行和 Word 降级测试全部保持通过。
- 部署后使用现有 v2 规则与模板重新试运行；通过时 Word 的重点项目、风险和次日建议不再出现统一占位语。
