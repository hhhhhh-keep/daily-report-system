# Daily Report Statistics and Leader Skills Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add auditable weekly/monthly report statistics and upgrade the daily analysis/template Skill pair to reproduce the approved leader-facing Word report.

**Architecture:** Calculate period statistics from workdays, frozen snapshots, roster and daily reports at query time. Extend the existing DataPackage and deterministic fact pipeline with project-state and management-report structures; keep model output evidence-bound and keep Word rendering deterministic.

**Tech Stack:** Java 21, Spring Boot 4.1, PostgreSQL/Flyway, Vue 3/TypeScript/Vitest, Python 3.12-compatible scripts, JSON Schema, python-docx.

## Global Constraints

- Business timezone is `Asia/Shanghai`; early submission cutoff is 17:30.
- `submitted_at` is immutable first submission time; `updated_at` is last modification time.
- Full-day leave = 1 occurrence/1.0 day; half-day leave = 1 occurrence/0.5 day.
- No new infrastructure, network permission, statistics accumulator table, or model-calculated metrics.
- All production behavior begins with a failing automated test.

---

### Task 1: Backend period statistics

**Files:**
- Create: `daily-api/src/main/java/com/company/daily/report/api/dto/PersonReportPeriodStatistics.java`
- Create: `daily-api/src/main/java/com/company/daily/report/api/dto/ReportPeriodStatisticsResponse.java`
- Create: `daily-api/src/main/java/com/company/daily/report/service/ReportPeriodStatisticsService.java`
- Modify: `daily-api/src/main/java/com/company/daily/report/api/AdminReportController.java`
- Test: `daily-api/src/test/java/com/company/daily/report/ReportPeriodStatisticsServiceTest.java`
- Test: `daily-api/src/test/java/com/company/daily/contracts/AdminManagementContractTest.java`

**Interfaces:**
- Consumes: `period=WEEKLY|MONTHLY`, `anchor: LocalDate`.
- Produces: period metadata, coverage mode, department totals and per-person expected/early/missing/leave/training counts.

- [ ] Write a failing integration test with two workdays, an early report, a late-modified early report, one missing report, full/half leave and training.
- [ ] Run `mvn -Dtest=ReportPeriodStatisticsServiceTest test` and verify the endpoint/service is missing.
- [ ] Implement period boundary calculation, frozen-snapshot-first expected roster resolution, 17:30 cutoff and per-person aggregation using `JdbcTemplate`.
- [ ] Add the protected GET endpoint and contract assertions.
- [ ] Run the two backend tests and verify they pass.

### Task 2: Daily management UI

**Files:**
- Modify: `daily-web/src/api/admin.ts`
- Modify: `daily-web/src/views/admin/AdminReportsView.vue`
- Test: `daily-web/tests/views/admin-reports.spec.ts`

**Interfaces:**
- Consumes: existing `ReportSummary.submittedAt/updatedAt` and the Task 1 endpoint.
- Produces: time columns plus weekly/monthly per-person statistics table.

- [ ] Add failing component tests for time display, weekly/monthly switching, leave occurrence/equivalent days and empty states.
- [ ] Run the focused Vitest file and confirm the new labels/data are absent.
- [ ] Add typed API models/method and render the period selector and summary table.
- [ ] Format timestamps in `Asia/Shanghai`; display “未修改” only when first and updated timestamps are equal.
- [ ] Run focused tests, typecheck and build.

### Task 3: Host DataPackage enrichment

**Files:**
- Modify: `daily-api/src/main/java/com/company/daily/analysis/AnalysisSourceSnapshotService.java`
- Modify: `daily-api/src/main/java/com/company/daily/skills/DailyDataPackageAssembler.java`
- Test: `daily-api/src/test/java/com/company/daily/skills/DailyDataPackageAssemblerTest.java`

**Interfaces:**
- Consumes: source snapshot reports, tasks, workdays, statistics and `projectStates`.
- Produces: true `final_submitted_at` and project master/state fields in the existing package files.

- [ ] Add failing package assertions for `updated_at`, formal project state/owner/latest activity and snapshot date.
- [ ] Run the focused test and verify those fields are absent.
- [ ] Include `r.updated_at` in source snapshots and map it to `final_submitted_at`.
- [ ] Merge `projectStates` into `projects.json` without creating unknown project IDs.
- [ ] Run package assembler and existing skill runtime tests.

### Task 4: Rule Skill 1.2.0

**Files:**
- Modify: `deliverables/skills/daily-work-analysis/manifest.json`
- Modify: `deliverables/skills/daily-work-analysis/SKILL.md`
- Modify: `deliverables/skills/daily-work-analysis/references/rules.md`
- Modify: `deliverables/skills/daily-work-analysis/schemas/projects.schema.json`
- Modify: `deliverables/skills/daily-work-analysis/schemas/daily-facts.schema.json`
- Modify: `deliverables/skills/daily-work-analysis/scripts/package_contract.py`
- Modify: `deliverables/skills/daily-work-analysis/scripts/calculate_daily_metrics.py`
- Modify: `deliverables/skills/daily-work-analysis/scripts/build_fact_package.py`
- Test: `deliverables/skills/daily-work-analysis/tests/test_calculate_daily_metrics.py`
- Test: `deliverables/skills/daily-work-analysis/tests/test_build_fact_package.py`
- Test: `deliverables/skills/daily-work-analysis/tests/golden/cases.json`
- Test: `deliverables/skills/daily-work-analysis/tests/golden/expected.json`

**Interfaces:**
- Produces deterministic `attendance_summary`, `efficiency_summary`, `formal_project_dynamics`, `unlinked_project_dynamics`, `stale_project_alerts` and evidence.

- [ ] Add failing golden/unit cases for the approved 7/31 metrics and for project inactivity of 3 versus 4 workdays.
- [ ] Run the rule Skill suite and verify failures are caused by missing fact sections.
- [ ] Extend schemas/dataclasses and calculate all new facts without model participation.
- [ ] Rewrite SKILL.md as a concise execution contract and move detailed management rules to `references/rules.md`.
- [ ] Run all rule Skill tests, CLI entrypoint and schema validation; package version `1.2.0` only after green.

### Task 5: Template Skill 1.2.0

**Files:**
- Modify: `deliverables/skills/daily-report-docx-template/manifest.json`
- Modify: `deliverables/skills/daily-report-docx-template/SKILL.md`
- Modify: `deliverables/skills/daily-report-docx-template/references/layout.md`
- Modify: `deliverables/skills/daily-report-docx-template/schemas/daily-analysis.schema.json`
- Modify: `deliverables/skills/daily-report-docx-template/scripts/render_daily_report.py`
- Modify: `deliverables/skills/daily-report-docx-template/scripts/audit_daily_report.py`
- Replace: `deliverables/skills/daily-report-docx-template/assets/daily-report-template.docx`
- Test: `deliverables/skills/daily-report-docx-template/tests/test_render_daily_report.py`
- Test: `deliverables/skills/daily-report-docx-template/tests/test_template_asset.py`

**Interfaces:**
- Consumes: Task 4 facts plus optional evidence-validated analysis.
- Produces: `report.docx` matching the approved leader-report structure.

- [ ] Add failing tests for title, coordinated dashboard typography, real-name attendance, efficiency, three project subsections, stale alerts and management actions.
- [ ] Run the template suite and verify current renderer fails the structural assertions.
- [ ] Update the Word asset anchors, deterministic renderer and audit rules.
- [ ] Ensure facts-only rendering retains every deterministic section and never emits empty AI placeholder pages.
- [ ] Run all template tests and inspect generated DOCX structure; package version `1.2.0` only after green.

### Task 6: Paired runtime and release artifacts

**Files:**
- Modify: `daily-api/src/test/java/com/company/daily/skills/SkillAnalysisExecutorTest.java`
- Create/update: `deliverables/skill-packages/daily-work-analysis-v1.2.0.zip`
- Create/update: `deliverables/skill-packages/daily-report-docx-template-v1.2.0.zip`
- Create: `deliverables/word-reports/行一二部工作日报_2026-07-31.skill-v1.2.0.docx`

**Interfaces:**
- Consumes: paired version 1.2.0 packages and historical 2026-07-31 DataPackage.
- Produces: validated trial document and publishable ZIPs.

- [ ] Add a failing executor test proving project states and updated timestamps survive host-to-Skill orchestration.
- [ ] Run the focused executor test and verify failure before host wiring changes.
- [ ] Complete package wiring, build deterministic ZIPs and run package validators.
- [ ] Run the 2026-07-31 paired trial and assert the approved report checklist.
- [ ] Run focused backend/frontend tests, both full Skill suites, lint/build and document audit; record any unrelated pre-existing full-suite failures separately.

## Plan self-review

- Coverage: timestamps, weekly/monthly counts, leave units, UI, DataPackage, rule facts, Word layout, fallback and paired trial are each assigned.
- No migration is planned because both timestamps already exist.
- Type names and field names are shared consistently between backend, frontend and Skill facts.
- No placeholder implementation steps or new infrastructure are included.
