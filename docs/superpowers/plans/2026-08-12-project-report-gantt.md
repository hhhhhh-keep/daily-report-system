# 项目日报甘特图 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 在项目维护页展示由日报任务派生的项目动态摘要和可筛选甘特图，不覆盖项目主数据。

**Architecture:** 新增只读项目动态查询，直接聚合 `daily_tasks`、`daily_reports` 和人员数据；项目主档保持原有手工字段。前端在既有项目页按需加载详情，以人员泳道展示阶段轨迹和阻碍状态。

**Tech Stack:** Spring Boot 4、JPA/JdbcTemplate、PostgreSQL、Vue 3、TypeScript、Vitest。

## Global Constraints

- 不修改日报写入逻辑与项目主数据状态。
- 已完成项目保留动态历史；本任务不改变日报下拉选项行为。
- 默认查询最近 30 天，支持 7 天、90 天、全周期。
- 不启动 Docker/Testcontainers；后端使用 JDK 21 编译。

---

### Task 1: 项目动态查询 API

**Files:**
- Create: `daily-api/src/main/java/com/company/daily/masterdata/api/dto/ProjectActivityResponse.java`
- Create: `daily-api/src/main/java/com/company/daily/masterdata/api/dto/ProjectActivityTaskResponse.java`
- Modify: `daily-api/src/main/java/com/company/daily/masterdata/service/AdminMasterDataService.java`
- Modify: `daily-api/src/main/java/com/company/daily/masterdata/api/AdminMasterDataController.java`
- Create: `daily-api/src/test/java/com/company/daily/masterdata/service/ProjectActivityQueryTest.java`

- [x] 写服务测试：同一项目两天、两个阶段的日报任务，查询返回参与人数、最近日期和按日期排序的任务轨迹。
- [x] 运行测试，确认因 API/服务不存在而失败。
- [x] 实现 `projectActivity(long projectId, int days)`：`days` 仅允许 7、30、90 或 0（全周期）；聚合任务、人员、阶段、状态、进展及阻碍字段；无任务时返回空轨迹。
- [x] 新增 `GET /api/admin/projects/{id}/activity?days=30`。
- [x] 重跑测试，确认通过。

### Task 2: 查询性能索引

**Files:**
- Create: `daily-api/src/main/resources/db/migration/V012__add_project_activity_indexes.sql`

- [x] 新增 `daily_tasks(project_id, report_id)` 和 `daily_reports(report_date, employee_id)` 索引，仅支持项目动态查询。
- [x] 用 Flyway validate/migrate 验证迁移可执行。

### Task 3: 项目页动态与甘特图

**Files:**
- Modify: `daily-web/src/api/admin.ts`
- Modify: `daily-web/src/views/admin/AdminProjectsView.vue`
- Create: `daily-web/tests/views/admin-projects.spec.ts`

- [x] 写前端测试：点击“日报动态”后请求项目活动 API，并渲染参与人数和两条阶段轨迹。
- [x] 运行测试，确认因页面没有动态区而失败。
- [x] 增加 7/30/90/全周期切换、摘要卡片、按人员/日期排列的阶段轨迹；阻碍/暂停状态添加文本标记；点击轨迹显示原始进展。
- [x] 重跑前端测试，确认通过。

### Task 4: 文档与验证

**Files:**
- Modify: `tasks/active.md`
- Modify: `.codex/state/progress.md`
- Modify: `.codex/state/critique.md`
- Modify: `.codex/state/handoff.md`

- [x] 运行后端 JDK 21 `./mvnw -B -DskipTests compile` 及项目动态测试。
- [x] 运行前端 `npm test`、`npm run lint`、`npm run build`。
- [x] 记录验证证据与未覆盖范围。
