# Task: 安装 Python 并接入日报技能

## Goal

在宿主机准备 Python 3.12 运行环境与日报 Skill 所需依赖，核验两个已上传 Skill 的真实输入输出契约，为后续接入执行链路建立依据。

## Acceptance criteria

- [x] Python 3.12 与 pip 可用。
- [x] jsonschema、python-docx 可被 Python 3.12 导入。
- [x] 已核验两个 Skill 包的脚本入口、输入输出要求与模板执行缺口。

## Scope exclusions

- 本任务不修改日报业务数据、不执行上传包内脚本、不改变系统既有分析结果。

## Verification

```text
python3.12 -c "import jsonschema, docx"
读取两个 ZIP 的 manifest、SKILL.md 和 scripts 入口
```

