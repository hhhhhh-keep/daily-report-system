# 真实 Skills 中心 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 将日报、周报、月报的规则与报告模板从散落配置改为受控 Skill ZIP 的上传、试运行、成对发布和运行追溯。

**Architecture:** 后端以固定的周期和槽位保存 Skill ZIP、解析后的 `SKILL.md` 与生命周期状态；数据包由系统生成并作为模型输入，Skill 永不直接接触数据库或网络。分析编排改为规则 Skill 生成草稿、模板 Skill 渲染 HTML 两阶段；前端以周期页签管理每一对 Skill 和试运行记录。

**Tech Stack:** Spring Boot 4 / Java 21 / PostgreSQL / Flyway / Vue 3 / TypeScript / Vitest。

## Global Constraints

- 不启动 Docker 或 Testcontainers；后端验证使用 JDK 21 的 `mvnw -B -DskipTests compile`。
- Skill 只分析本系统日报、项目、工作日历与快照数据；不运行用户脚本、不执行 SQL、不访问外部网络。
- 固定六槽位：DAILY、WEEKLY、MONTHLY 各有 RULE 与 TEMPLATE；不增加自定义周期或类型。
- 17:30 快照与 22:00 最终统计继续独立保存于 `report_statistics_snapshots`。
- 历史运行、旧 `analysis_rule_versions` 数据与现有日报填报不得被删除或破坏。

---

## File structure

- Create `daily-api/src/main/resources/db/migration/V014__create_analysis_skill_center.sql`：Skill 版本、试运行与运行关联字段。
- Create `daily-api/src/main/java/com/company/daily/skills/*`：Skill 枚举、ZIP 校验、存储、试运行服务与管理员 API。
- Modify `daily-api/src/main/java/com/company/daily/analysis/AnalysisSourceSnapshotService.java`：补充项目生命周期和工作日历受控数据包。
- Modify `daily-api/src/main/java/com/company/daily/analysis/LlmAnalysisAdapter.java`：新增规则/模板 Skill 的两阶段模型调用。
- Modify `daily-api/src/main/java/com/company/daily/scheduling/AnalysisOrchestrator.java` 与 `AnalysisRunStore.java`：只使用已发布 Skill 对并保存版本快照。
- Modify `daily-web/src/api/admin.ts`：Skills 中心 API 与 DTO。
- Modify `daily-web/src/views/admin/skills/AdminSkillsView.vue`：真实管理页面，替换占位卡片。
- Create `daily-web/tests/views/admin-skills.spec.ts`：上传、试运行、发布状态的页面测试。
- Create `daily-api/src/test/java/com/company/daily/skills/*Test.java`：包校验、发布门槛、执行边界测试。

### Task 1: 持久化与 ZIP 校验

**Files:**
- Create: `daily-api/src/main/resources/db/migration/V014__create_analysis_skill_center.sql`
- Create: `daily-api/src/main/java/com/company/daily/skills/AnalysisSkillKind.java`
- Create: `daily-api/src/main/java/com/company/daily/skills/AnalysisSkillStatus.java`
- Create: `daily-api/src/main/java/com/company/daily/skills/SkillPackageValidator.java`
- Create: `daily-api/src/test/java/com/company/daily/skills/SkillPackageValidatorTest.java`

**Produces:** `SkillPackageValidator.validate(byte[] zip)` 返回包名、SHA-256、Skill 名称、描述与 Markdown；异常信息可直接返回管理员页面。

- [ ] 写失败测试：无 `SKILL.md`、多份 `SKILL.md`、`../` 路径、可执行扩展名、超过 5MB 解压内容均被拒绝；合法单文件 ZIP 被接受。
- [ ] 实现迁移：`analysis_skill_versions` 含周期、槽位、版本、状态、包 BLOB、Markdown、校验信息与时间；`analysis_skill_trials` 含成对版本、窗口、输入快照、草稿、HTML、状态与错误；给 `analysis_runs` 加规则/模板 Skill 版本外键。
- [ ] 实现 ZIP 流式校验：只允许根目录 `SKILL.md` 与 `assets/` 下的图片/CSS；读取 UTF-8 Markdown 前置元数据 `name` 和 `description`；拒绝压缩炸弹、路径穿越及不允许文件。
- [ ] 运行 `SkillPackageValidatorTest`，确认合法包与每种非法包均符合预期。

### Task 2: Skill 版本、试运行和成对发布 API

**Files:**
- Create: `daily-api/src/main/java/com/company/daily/skills/AnalysisSkillVersion.java`
- Create: `daily-api/src/main/java/com/company/daily/skills/AnalysisSkillTrial.java`
- Create: `daily-api/src/main/java/com/company/daily/skills/AnalysisSkillService.java`
- Create: `daily-api/src/main/java/com/company/daily/skills/api/AnalysisSkillController.java`
- Create: `daily-api/src/test/java/com/company/daily/skills/AnalysisSkillServiceTest.java`

**Consumes:** Task 1 的 `SkillPackageValidator`、`AnalysisPeriod`。

**Produces:**

```java
AnalysisSkillVersion upload(AnalysisPeriod period, AnalysisSkillKind kind, MultipartFile file);
AnalysisSkillTrial trial(AnalysisPeriod period, LocalDate endDate);
void publishPair(AnalysisPeriod period, long ruleVersionId, long templateVersionId);
byte[] download(long versionId);
```

- [ ] 写失败测试：上传只创建 DRAFT；试运行失败的一侧不能发布；周期、槽位不匹配的两个版本不能发布；发布后旧 PUBLISHED 变为 HISTORICAL。
- [ ] 实现管理员接口：列出周期/槽位版本、上传 ZIP、下载 ZIP、按指定周期末日试运行、获取试运行历史、成对发布。
- [ ] 试运行使用 `AnalysisPeriodWindowService.resolve(period, endDate)` 和受控数据快照；Rule 与 Template 版本必须均为该周期对应槽位的 DRAFT。
- [ ] 发布采用同一事务：校验同一次成功试运行覆盖这对版本，归档旧发布对，再同时设置两个版本为 PUBLISHED。
- [ ] 运行 `AnalysisSkillServiceTest`，确认版本不可覆盖、历史包仍可下载、发布是成对原子操作。

### Task 3: 受控数据包与两阶段 LLM 执行

**Files:**
- Modify: `daily-api/src/main/java/com/company/daily/analysis/AnalysisSourceSnapshotService.java`
- Modify: `daily-api/src/main/java/com/company/daily/analysis/LlmAnalysisAdapter.java`
- Create: `daily-api/src/main/java/com/company/daily/skills/SkillAnalysisExecutor.java`
- Create: `daily-api/src/test/java/com/company/daily/skills/SkillAnalysisExecutorTest.java`

**Consumes:** Task 2 发布的 Rule/TEMPLATE Skill 版本与 `AnalysisSourceSnapshotService.build(window)`。

**Produces:** `SkillAnalysisExecutor.execute(ruleVersion, templateVersion, window)`，返回输入快照、分析草稿和安全 HTML。

- [ ] 写失败测试：数据包只含日报、任务、项目活动、工作日历和快照；规则调用失败不调用模板；模板失败保留草稿；HTML 中的 `script`、`onload`、`javascript:`、外链 URL 被清除。
- [ ] 扩展来源快照：加入项目派生状态/活动和日期窗内工作日信息；不加入连接密钥、员工密码、系统配置或任意 SQL 字符串。
- [ ] 规则调用的 system message 是 `SKILL.md`，user message 是 JSON 数据包；模板调用的 system message 是模板 `SKILL.md`，user message 仅包含草稿与允许的来源摘要。
- [ ] 对规则响应校验为 JSON 对象，至少有 `conclusions`；每项要求 `statement`、`evidence`、`confidence`。模板响应只接受 HTML 片段并净化。
- [ ] 运行 `SkillAnalysisExecutorTest`，确认边界、失败分支与净化行为通过。

### Task 4: 定时与手动分析切换至发布 Skill 对

**Files:**
- Modify: `daily-api/src/main/java/com/company/daily/scheduling/AnalysisOrchestrator.java`
- Modify: `daily-api/src/main/java/com/company/daily/scheduling/AnalysisRunStore.java`
- Modify: `daily-api/src/main/java/com/company/daily/scheduling/AnalysisRunResponse.java`
- Create: `daily-api/src/test/java/com/company/daily/scheduling/AnalysisOrchestratorSkillTest.java`

**Consumes:** Task 2 的 `AnalysisSkillService.publishedPair(period)` 与 Task 3 的 `SkillAnalysisExecutor`。

- [ ] 写失败测试：无发布对的周期不调用 LLM 并明确记录失败原因；规则失败时不产生报告/邮件；模板失败时保留草稿、不给邮件并标记 partial-failure；成功运行保存两个 Skill ID。
- [ ] 替换多周期分支的旧 `AnalysisRuleVersionService.published` 读取：读取 `publishedPair(period)` 并调用 Skill 执行器。
- [ ] 在 `analysis_runs` 保存 rule/template Skill ID、输入快照、草稿和渲染报告；历史旧运行仍用既有字段显示。
- [ ] 保留旧 `AnalysisRuleVersion` API 与历史记录，但从新调度路径移除其依赖。
- [ ] 运行 `AnalysisOrchestratorSkillTest`，确认失败不触发邮件和版本追溯正确。

### Task 5: 前端真实 Skills 中心

**Files:**
- Modify: `daily-web/src/api/admin.ts`
- Modify: `daily-web/src/views/admin/skills/AdminSkillsView.vue`
- Modify: `daily-web/tests/views/admin-skills.spec.ts`

**Consumes:** Task 2 API；固定周期 `DAILY | WEEKLY | MONTHLY` 与槽位 `RULE | TEMPLATE`。

- [ ] 写失败测试：页面渲染日报/周报/月报页签，每页恰有规则与模板两槽；上传请求使用 multipart；只有服务端确认同对试运行成功时“成对发布”按钮可用；试运行失败显示错误。
- [ ] 增加 API 类型和请求：版本列表、`FormData` 上传、下载、试运行、试运行列表、成对发布。
- [ ] 重写页面：周期页签、当前发布版、草稿和历史版本、上传控件、下载、选择窗口试运行、草稿/报告预览、成对发布区；移除“待重新设计”“等待 Skill 包”等占位文案。
- [ ] 页面只展示上传包的名称/描述/校验与运行结果，不再暴露 JSON、Prompt、Schema、维度或报告模板编辑框。
- [ ] 运行 `npm test -- tests/views/admin-skills.spec.ts`，确认交互与状态通过。

### Task 6: 文档、全量验证与历史兼容性

**Files:**
- Modify: `specs/002-multi-period-ai-analysis/data-model.md`
- Modify: `specs/002-multi-period-ai-analysis/plan.md`
- Modify: `specs/002-multi-period-ai-analysis/tasks.md`
- Modify: `tasks/active.md`

- [ ] 更新数据模型、计划和任务：注明 V014、六槽位、受控数据包、试运行/成对发布和运行版本追溯。
- [ ] 使用 JDK 21 运行 `./mvnw -B -DskipTests compile`，验证数据库迁移和后端源代码可编译。
- [ ] 运行 `npm test`、`npm run lint`、`npm run build`。
- [ ] 扫描本次新增/修改的中文文本，不得出现 `???`、`涓`、`鏃`、`鍚`、`缂`、`鐢` 等乱码；读取 UTF-8 文件确认中文正常。
- [ ] 记录所有验证命令与结果至 Harness builder/critic/finalizer 状态文件；仅全数通过后写 `LOOP_COMPLETE`。

## Self-review

- 覆盖性：Task 1-2 覆盖上传、校验、存储、下载、试运行和发布；Task 3-4 覆盖受控取数、两阶段执行、失败处理和运行追溯；Task 5 覆盖真实页面；Task 6 覆盖文档和验证。
- 一致性：所有接口均以 `AnalysisPeriod` + `AnalysisSkillKind` 定位六槽位；只有 `publishPair` 能改变发布版本。
- 安全性：用户 ZIP 只作为受限 Markdown/CSS/素材，不执行 ZIP 内任何脚本；模型只接收系统构造的数据包。
