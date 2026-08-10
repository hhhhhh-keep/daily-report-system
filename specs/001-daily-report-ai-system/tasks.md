# 任务清单：日报 AI 分析系统

**输入**：`spec.md`、`plan.md`、`research.md`、`data-model.md`、`contracts/http-api.md`、`quickstart.md`
**前提**：先完成阶段 1 和阶段 2；所有密钥均由环境变量提供，不写入源码或前端构建产物。

## 格式与范围

- `[P]` 表示在前置依赖完成后可与同阶段其他独立文件任务并行。
- `[US1]`、`[US2]`、`[US3]` 映射 `spec.md` 中的 P1、P2、P3 用户故事。
- 不创建审批、员工账号、RBAC、SSO、OAuth、CRM、绩效/工时、微服务、消息队列、Kubernetes 或外部工作流编排能力。

## Phase 1：Setup（共享初始化）

**目标**：建立 Vue 3、Spring Boot、PostgreSQL、Docker 和质量命令的最小项目骨架。

- [ ] T001 创建 Vue 3 `daily-web` 工程、`/report`、`/my-report`、`/admin/*` 路由骨架和入口文件：`daily-web/package.json`、`daily-web/src/main.ts`、`daily-web/src/router/index.ts`
- [ ] T002 [P] 创建 Spring Boot 模块化单体工程和模块包边界：`daily-api/pom.xml`、`daily-api/src/main/java/com/company/daily/DailyApiApplication.java`、`daily-api/src/main/java/com/company/daily/{report,masterdata,metrics,rules,analysis,scheduling,reporting,email,config}/`
- [ ] T003 [P] 定义 Docker 本地服务与 nginx 代理基线：`docker/docker-compose.yml`、`docker/nginx/default.conf`、`daily-web/Dockerfile`、`daily-api/Dockerfile`
- [ ] T004 [P] 建立前后端环境变量样例及配置校验入口：`daily-web/.env.example`、`daily-api/.env.example`、`daily-api/src/main/java/com/company/daily/config/EnvironmentProperties.java`
- [ ] T005 配置实际可运行的前端 test/lint/build 命令：`daily-web/package.json`、`daily-web/vite.config.ts`
- [ ] T006 [P] 配置实际可运行的后端 test/lint/build 命令：`daily-api/pom.xml`、`daily-api/mvnw`

---

## Phase 2：Foundational（阻塞性基础）

**目标**：建立所有用户故事共用的 PostgreSQL、migration、错误处理、基础数据和契约骨架；完成前不得开始用户故事实现。

- [ ] T007 配置 PostgreSQL 数据源、Flyway migration 框架和迁移执行配置：`daily-api/pom.xml`、`daily-api/src/main/resources/application.yml`、`daily-api/src/main/resources/db/migration/`
- [ ] T008 创建 Employee、Project、非正式项目选项与业务字典的初始 migration：`daily-api/src/main/resources/db/migration/V001__create_master_data.sql`
- [ ] T009 [P] 实现统一 API 错误响应、日期校验和请求关联日志：`daily-api/src/main/java/com/company/daily/common/api/ApiExceptionHandler.java`、`daily-api/src/main/java/com/company/daily/common/api/ApiError.java`
- [ ] T010 [P] 创建共享 JPA 审计时间基类及 PostgreSQL 测试容器配置：`daily-api/src/main/java/com/company/daily/common/persistence/AuditedEntity.java`、`daily-api/src/test/java/com/company/daily/support/PostgresIntegrationTest.java`
- [ ] T011 建立 Employee/Project/dictionary 基础数据 repository、service 和读取 DTO：`daily-api/src/main/java/com/company/daily/masterdata/`
- [ ] T012 [P] 建立 HTTP API 契约测试基线，覆盖 `/api/report/options` 与统一错误格式：`daily-api/src/test/java/com/company/daily/contracts/ReportOptionsContractTest.java`
- [ ] T013 [P] 建立前端 API client、路由守卫骨架和响应式布局基线：`daily-web/src/api/http.ts`、`daily-web/src/api/report.ts`、`daily-web/src/layouts/`
- [ ] T014 验证 migration、环境变量和 Docker 服务连通性：`daily-api/src/test/java/com/company/daily/config/EnvironmentPropertiesTest.java`、`docker/docker-compose.yml`

**检查点**：阶段 2 完成后，数据库、契约、基础数据和质量命令可支撑所有用户故事。

---

## Phase 3：User Story 1 - 提交并更新今日日报（Priority: P1）

**目标**：员工无需登录即可创建、重新打开并更新一份当日的多任务日报。

**独立验证**：选择 Employee 和当天日期，新增多条 DailyTask，保存后重新打开并修改；确认 `employee_id + report_date` 始终只有一份有效 DailyReport。

- [ ] T015 [P] [US1] 创建 DailyReport/DailyTask migration、唯一键和外键约束：`daily-api/src/main/resources/db/migration/V002__create_daily_reports_and_tasks.sql`
- [ ] T016 [P] [US1] 编写 DailyReport/DailyTask repository 与实体映射测试：`daily-api/src/test/java/com/company/daily/report/DailyReportRepositoryTest.java`、`daily-api/src/test/java/com/company/daily/report/DailyTaskRepositoryTest.java`
- [ ] T017 [P] [US1] 编写当前日报读取与全量任务更新的 HTTP 契约测试：`daily-api/src/test/java/com/company/daily/contracts/CurrentReportContractTest.java`
- [ ] T018 [P] [US1] 编写 `/report` 与 `/my-report` 当日多任务更新端到端测试：`daily-web/e2e/report-current-day.spec.ts`
- [ ] T019 [US1] 实现 DailyReport、DailyTask、`time_period`、`participation_role`、`current_status` 实体和 DTO：`daily-api/src/main/java/com/company/daily/report/domain/`、`daily-api/src/main/java/com/company/daily/report/api/dto/`
- [ ] T020 [US1] 实现当日保存/覆盖更新、动态任务全量替换、Employee/Project 引用和唯一性规则：`daily-api/src/main/java/com/company/daily/report/service/CurrentReportService.java`
- [ ] T021 [US1] 实现 `GET /api/reports?employeeId=&date=`、`PUT /api/reports/current` 及输入校验：`daily-api/src/main/java/com/company/daily/report/api/ReportController.java`
- [ ] T022 [P] [US1] 实现日报选项读取 API 与非正式项目选择数据：`daily-api/src/main/java/com/company/daily/report/api/ReportOptionsController.java`、`daily-api/src/main/java/com/company/daily/report/service/ReportOptionsService.java`
- [ ] T023 [US1] 实现员工填写页的日期/姓名/出勤、动态 DailyTask 卡片和异常条件字段：`daily-web/src/views/report/ReportEntryView.vue`、`daily-web/src/components/report/DailyTaskForm.vue`
- [ ] T024 [US1] 实现当日读取和修改页、全量提交与保存反馈：`daily-web/src/views/report/MyReportView.vue`、`daily-web/src/stores/report.ts`
- [ ] T025 [US1] 运行并修复日报每日唯一、多任务、当天修改及 API 契约回归测试：`daily-api/src/test/java/com/company/daily/report/CurrentReportServiceTest.java`、`daily-web/e2e/report-current-day.spec.ts`

**检查点**：US1 可独立演示并满足 FR-001 至 FR-004、SC-001 和 SC-002。

---

## Phase 4：User Story 2 - 管理日报和基础数据（Priority: P2）

**目标**：唯一管理员登录后管理 Employee/Project/字典、浏览日报任务，并查看管理驾驶舱。

**独立验证**：管理员维护 Employee 和 Project，在日报选项中选择它们，并确认单管理员边界与管理视图可用。

- [ ] T026 [P] [US2] 编写单管理员密码、Session/JWT、修改密码和退出登录测试：`daily-api/src/test/java/com/company/daily/admin/AdminSessionServiceTest.java`
- [ ] T027 [P] [US2] 编写 Employee/Project/dictionary CRUD 与管理报告读取契约测试：`daily-api/src/test/java/com/company/daily/contracts/AdminManagementContractTest.java`
- [ ] T028 [P] [US2] 编写管理后台登录、基础数据维护和日报任务查看端到端测试：`daily-web/e2e/admin-management.spec.ts`
- [ ] T029 [US2] 创建唯一管理员认证数据 migration 与密码散列持久化：`daily-api/src/main/resources/db/migration/V003__create_administrator.sql`
- [ ] T030 [US2] 实现管理员 Session/JWT、登录、修改密码、退出和管理 API 保护：`daily-api/src/main/java/com/company/daily/admin/`
- [ ] T031 [US2] 实现 Employee、Project、dictionary CRUD 及非正式项目选项维护 API：`daily-api/src/main/java/com/company/daily/masterdata/api/`、`daily-api/src/main/java/com/company/daily/masterdata/service/`
- [ ] T032 [US2] 实现日报列表、任务明细和管理读取服务/API：`daily-api/src/main/java/com/company/daily/report/api/AdminReportController.java`、`daily-api/src/main/java/com/company/daily/report/service/AdminReportQueryService.java`
- [ ] T033 [P] [US2] 实现基础指标汇总与管理驾驶舱读取 API：`daily-api/src/main/java/com/company/daily/metrics/MetricsService.java`、`daily-api/src/main/java/com/company/daily/metrics/MetricsController.java`
- [ ] T034 [US2] 实现 `/admin/*` 登录、基础数据、日报管理、任务明细与驾驶舱页面：`daily-web/src/views/admin/`、`daily-web/src/router/admin.ts`
- [ ] T035 [US2] 执行单管理员边界、基础数据选择、管理查询和驾驶舱回归测试：`daily-api/src/test/java/com/company/daily/admin/`、`daily-web/e2e/admin-management.spec.ts`

**检查点**：US2 可独立验证 FR-005、FR-006 和 FR-010 的管理入口，且不引入员工账号或多角色能力。

---

## Phase 5：User Story 3 - 分析并分发管理洞察（Priority: P3）

**目标**：按配置计算规则与 LLM 建议，定时生成报告并发送邮件；运行记录可查看错误与安全重试。

**独立验证**：对样例日报运行已配置的分析，确认所选维度、报告、邮件和运行结果；模拟模型/邮件失败后可手动重跑且不重复成功投递。

- [ ] T036 [P] [US3] 创建分析配置、运行记录、报告引用和邮件投递幂等 migration：`daily-api/src/main/resources/db/migration/V004__create_analysis_config_and_runs.sql`
- [ ] T037 [P] [US3] 编写指标计算和确定性规则测试，覆盖完整性、任务/项目/时段、异常、连续支撑、等待反馈及多人/多项目：`daily-api/src/test/java/com/company/daily/metrics/ReportMetricsServiceTest.java`、`daily-api/src/test/java/com/company/daily/rules/AnalysisRuleServiceTest.java`
- [ ] T038 [P] [US3] 编写 LLM 适配器隔离与顾问性输出测试：`daily-api/src/test/java/com/company/daily/analysis/LlmAnalysisAdapterTest.java`
- [ ] T039 [P] [US3] 编写 Quartz、报告、SMTP、失败记录和手动重试契约/集成测试：`daily-api/src/test/java/com/company/daily/contracts/AnalysisRunContractTest.java`、`daily-api/src/test/java/com/company/daily/scheduling/AnalysisJobIntegrationTest.java`
- [ ] T040 [US3] 实现数据库指标计算、业务阈值规则和人员/项目/风险/资源维度结果：`daily-api/src/main/java/com/company/daily/metrics/`、`daily-api/src/main/java/com/company/daily/rules/`
- [ ] T041 [US3] 实现与程序规则分离的 LLM adapter、Prompt 版本读取和顾问性综合分析：`daily-api/src/main/java/com/company/daily/analysis/`
- [ ] T042 [US3] 实现 AI 规则、Prompt、维度、Quartz 计划、收件人、模板和模型设置的配置服务/API：`daily-api/src/main/java/com/company/daily/configuration/`
- [ ] T043 [US3] 实现 Quartz 定时分析、运行状态持久化、错误查看和手动重试：`daily-api/src/main/java/com/company/daily/scheduling/`、`daily-api/src/main/java/com/company/daily/scheduling/api/RunController.java`
- [ ] T044 [US3] 实现 HTML/PDF 报告生成、EmailService、SMTP 环境变量配置和重复成功邮件保护：`daily-api/src/main/java/com/company/daily/reporting/`、`daily-api/src/main/java/com/company/daily/email/`
- [ ] T045 [US3] 实现 AI 分析、规则/Prompt/计划/邮件配置和任务运行记录管理页面：`daily-web/src/views/admin/analysis/`、`daily-web/src/views/admin/config/`、`daily-web/src/views/admin/runs/`
- [ ] T046 [US3] 执行分析维度、LLM 降级、报告、邮件失败、手动重试和重复发送防护回归测试：`daily-api/src/test/java/com/company/daily/analysis/`、`daily-api/src/test/java/com/company/daily/email/`

**检查点**：US3 可独立验证 FR-007 至 FR-011、SC-003 和 SC-004；LLM 不执行人员调配或项目决策。

---

## Phase 6：收尾与跨切面验证

**目标**：验证契约、迁移恢复、Docker、质量门禁及排除范围。

- [ ] T047 [P] 更新 HTTP 契约回归测试以匹配 `contracts/http-api.md`：`daily-api/src/test/java/com/company/daily/contracts/`
- [ ] T048 [P] 验证 migration 顺序、唯一键和回滚/恢复说明：`daily-api/src/test/java/com/company/daily/migration/MigrationVerificationTest.java`、`daily-api/docs/migration-recovery.md`
- [ ] T049 [P] 执行 `quickstart.md` 的端到端场景和容器冒烟验证：`daily-web/e2e/quickstart.spec.ts`、`docker/docker-compose.yml`
- [ ] T050 执行并记录前端/后端 test、lint、build、migration、契约和容器质量门禁：`daily-web/package.json`、`daily-api/pom.xml`、`specs/001-daily-report-ai-system/quickstart.md`
- [ ] T051 复核排除范围与密钥管理，确认未引入审批、员工账号、RBAC、SSO、OAuth、CRM、绩效/工时、微服务、消息队列、Kubernetes 或外部工作流编排：`daily-api/pom.xml`、`daily-web/package.json`、`docker/docker-compose.yml`

## 依赖关系与执行顺序

```text
Phase 1 Setup
    ↓
Phase 2 Foundational（阻塞所有用户故事）
    ├──→ US1 / P1：日报填写与当天修改（MVP）
    ├──→ US2 / P2：管理员与基础数据（依赖 US1 的日报数据以完成集成验证）
    └──→ US3 / P3：分析、报告与邮件（依赖 US1 日报数据、US2 管理配置）
                         ↓
                 Phase 6 收尾与跨切面验证
```

- US1 依赖阶段 2 的基础数据、migration 和 API 基线。
- US2 在阶段 2 后可搭建认证和 CRUD，但完整管理日报验证依赖 US1 的日报数据。
- US3 的指标依赖 US1 的日报/任务数据，配置页面与管理员边界依赖 US2。
- 收尾阶段依赖所有已交付用户故事。

## 并行机会

- 阶段 1：T002、T003、T004 可并行；T005 与 T006 可在各自工程骨架完成后并行。
- 阶段 2：T009、T010、T012、T013 可并行；T008 完成后开始 T011。
- US1：T015—T018 可并行；T022 可在 T011 完成后并行；前端 T023 依赖 T021 的契约稳定。
- US2：T026—T028 可并行；T033 可与 CRUD 服务并行；T034 在管理 API 稳定后进行。
- US3：T036—T039 可并行；T040、T041 可在 schema 与基础数据就绪后并行；T044 依赖 T043 的运行模型。
- 收尾：T047—T049 可并行；T050、T051 在所有实现完成后执行。

## 实施策略

### MVP：仅 US1

1. 完成阶段 1 与阶段 2。
2. 完成 US1 的 migration、契约、服务、`/report`、`/my-report` 及独立端到端测试。
3. 验证同一 `employee_id + report_date` 只有一份日报，并可更新任意数量的任务。

### 增量交付

1. US1 交付可用的日报填写与当天修改。
2. US2 增加单管理员、基础数据和驾驶舱，但不改变 US1 的无员工登录边界。
3. US3 增加规则、LLM 顾问分析、Quartz、报告、SMTP 和重试。
4. 以阶段 6 的契约、迁移、容器和质量门禁完成整体验证。
