# Task: fix-scripted-skill-trial

## Goal

日报试运行在工作日历不完整时仍只采集最近五个工作日的数据，并且脚本的大量错误输出不得被误报为超时。

## Acceptance criteria

- [ ] 工作日历少于五条记录时，日报快照回退到报告日向前的五个工作日。
- [ ] Python 子进程可持续排空合并输出；大于管道缓冲区的失败信息会作为脚本错误返回，而不是超时。
- [ ] 相关单元测试、JDK 21 编译和本机试运行通过。

## Scope exclusions

- 不调整 LLM 配置、数据库业务数据或已上传的 Skill 包内容。

## Verification

```text
mvnw.cmd -Dtest=AnalysisSourceSnapshotServiceTest,ProcessPythonSkillRuntimeTest test
mvnw.cmd -DskipTests compile
本机 API 健康检查及 2026-07-31 技能试运行
```
