# Task: 补齐技能运行时迁移

## Goal

为已被错误标记为完成的 V022 脚本型 Skill 运行时 schema 创建可重复执行的补偿迁移。

## Acceptance criteria

- [x] `analysis_skill_versions` 存在 `runtime_profile` 与 `manifest_json` 列。
- [x] `analysis_skill_artifacts` 表及其 trial 索引存在。
- [x] JDK 21 后端编译成功，运行中后端健康检查为 UP。

## Scope exclusions

- 不回滚或篡改既有 Flyway 历史记录。
- 不删除或修改已有 Skill、试运行或业务数据。

## Verification

```text
JDK 21: .\mvnw.cmd -B -DskipTests compile
information_schema 查询补偿列与表；http://localhost:8080/actuator/health
```

