# 工作日历与多周期分析 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 在既有日报、Quartz 和分析架构上提供工作日历、17:30/22:00 双快照及日报、周报、月报分析。

**Architecture:** 新增唯一 `WorkdayService` 和可维护日历覆盖表；快照与分析运行均使用日期范围和周期字段。Quartz 按后台保存的 cron 注册快照、日报、周报、月报任务；周/月应填量通过 `WorkdayService` 逐日计算。

**Tech Stack:** Spring Boot 4、JPA/Flyway、Quartz、PostgreSQL、Vue 3、Vitest。

## Global Constraints

- 只复用现有日报、调度和 AI 分析模块；不建立独立周报/月报填报系统。
- 所有日报相关作业必须调用 `WorkdayService.isWorkday(date)`；不得在其他模块计算星期或硬编码节假日。
- Migration 保存全部 schema 变化；运行期验证沿用本地代理约定：前端 test/lint/build、后端 `mvnw -DskipTests compile`。

### Task 1: 工作日历与统一服务

**Files:** Create `workday/WorkdayCalendar.java`, `workday/WorkdayService.java`, repository/controller/DTO/tests; Modify `V007__create_workday_calendar.sql`, admin router/navigation/API.

- [ ] 写失败测试：人工工作日覆盖周末、人工非工作日覆盖工作日、无覆盖时周一至周五为工作日。
- [ ] 迁移创建 `workday_calendar(date unique, workday boolean, source, note, created_at, updated_at)`；实现服务优先级：管理员覆盖、导入的法定/调休记录、默认周规则。
- [ ] 管理端提供按日新增、修改、停用和年度导入/更新接口及“工作日历”页面。
- [ ] 运行后端单测与前端对应测试。

### Task 2: 双时点统计快照

**Files:** Create `statistics/ReportStatisticsSnapshot.java`, service/repository/controller/tests; Modify Flyway and scheduler.

- [ ] 写失败测试：17:30 保存提交名单、时间和小组统计；22:00 保存最终口径并识别补填/漏填，且不覆盖 17:30。
- [ ] 迁移创建快照表，含 `snapshot_type`, `snapshot_date`, 应填/已填/未填、填报率、人员和小组 JSON；唯一键为类型+日期。
- [ ] 实现 `capture(date, type)`，所有入口先调用 WorkdayService；按当日有效员工和日报构建统计。
- [ ] 为 17:30 与 22:00 添加独立可配置 Quartz 作业；22:00 完成后触发 DAILY 分析。

### Task 3: 多周期分析模型与调度

**Files:** Modify analysis configuration/run/domain/store/orchestrator/controller/tests and Flyway.

- [ ] 写失败测试：DAILY 只分析工作日；WEEKLY/MONTHLY 的应填日报数按 WorkdayService 日期范围计算；早填仅作为辅助指标传入。
- [ ] 为分析运行增加 `analysis_period`, `period_start`, `period_end`, `analysis_time`, `rule_version`, `prompt_version`, `source_snapshot`, `analysis_result`。
- [ ] 将现有 orchestrator 改为 `run(period, start, end, trigger)`；规则和 Prompt 按周期从配置读取，周/月分析按趋势、连续性和协同聚合，不平均日评分。
- [ ] 将一个 cron 拆为日报、周报、月报配置；所有日报相关执行先经 WorkdayService。

### Task 4: 管理界面、契约与文档

**Files:** Modify `AdminAnalysisView.vue`, `AdminConfigurationView.vue`, admin API/router; update `spec.md`, `plan.md`, `data-model.md`, `tasks.md`.

- [ ] 失败测试覆盖分析周期请求与历史结果筛选。
- [ ] 分析中心提供 DAILY/WEEKLY/MONTHLY 选择、手动运行和历史范围结果；配置页维护启停、cron、规则、Prompt 和报告类型。
- [ ] 文档记录双快照、工作日优先级、字段、周期口径与验证命令。
- [ ] 执行前端 test/lint/build、后端 compile，并执行本地热更新冒烟验证。
