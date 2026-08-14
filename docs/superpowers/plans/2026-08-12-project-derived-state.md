# 项目派生状态机 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 基于日报任务为项目和专项生成可回溯的派生状态与状态变更事件，供项目页和 AI 分析使用，不覆盖手工主数据。

**Architecture:** 新增 `project_derived_states` 保存每个项目当前派生状态，`project_state_events` 仅在状态或当前环节变化时追加。状态服务读取项目日报任务事实，保存时和 22:00 最终统计后触发计算。

**Tech Stack:** Spring Boot 4、JPA、PostgreSQL、Vue 3。

## Global Constraints

- 不更新 `projects.status` 或 `projects.project_stage`。
- 状态事件必须关联触发日报任务 ID，专项工作不使用生命周期阶段。
- 仅基于日报任务与工作日历，不启动 Docker/Testcontainers。

---

### Task 1: 状态规则与持久化

- [ ] 先测试：最新售前任务映射 `PRESALES_IN_PROGRESS`，阻碍优先映射 `BLOCKED`，专项任务映射 `IN_PROGRESS`。
- [ ] 实现纯状态解析器与派生状态、事件模型、迁移。

### Task 2: 触发、查询与项目页

- [ ] 保存日报后重算所涉及项目；最终统计后批量重算当天项目。
- [ ] 在项目动态 API 返回当前派生状态、环节、开始日期与事件。
- [ ] 页面显示“系统派生状态”和最近变更依据，不替代手工状态。

### Task 3: 验证与文档

- [ ] JDK 21 编译与状态解析器单测。
- [ ] 前端测试/lint/build，Flyway 迁移验证。
- [ ] 更新 Harness 状态与规格任务。
