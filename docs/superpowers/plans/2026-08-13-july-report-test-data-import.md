# July Report Test Data Import Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace local development test data with an auditable, source-backed July 2026 data set that exercises the report system end to end.

**Architecture:** Keep the workbook immutable, normalize its two weekly sheets into people, reports, and tasks, then use deterministic rules only for the missing structured fields. Load just the local development database through one transaction and validate from the running application.

**Tech Stack:** Python/pandas, PostgreSQL JDBC, Spring Boot API, Vue application.

## Global Constraints

- Source: `C:/Users/whn/Desktop/行一二工作日程管理-七月.xlsx`; never edit it.
- Target: `localhost:5432/daily_report_dev` only; abort if the database name differs.
- Preserve source Chinese content; reject replacement characters, question-mark mojibake, and common garbled fragments.
- Every destructive and insert operation belongs to one transaction.

---

### Task 1: Normalize the source data

**Files:**
- Read: `C:/Users/whn/Desktop/行一二工作日程管理-七月.xlsx`
- Update: `tasks/active.md`

**Interfaces:** Produces employees `{name, teamName, positionType}` and work entries `{date, name, workType, rawText}`.

- [ ] Read both sheets; identify the five dated column pairs in each and forward-fill merged group labels.
- [ ] Map group to team, personnel category to position type, and the two work columns to `project-support` and `special-work`.
- [ ] Retain every nonblank work cell, verify 95 unique employees, and reject blank required employee fields or mojibake.

### Task 2: Map source entries to valid report fields

**Files:**
- Read: `daily-api/src/main/resources/db/migration/V001__create_master_data.sql`
- Read: `daily-api/src/main/resources/db/migration/V005__add_task_stage_and_configurable_task_options.sql`

**Interfaces:** Produces records valid for `projects`, `daily_reports`, and `daily_tasks`.

- [ ] Split explicit `上午`/`下午` text into period-specific tasks; map `全天` to `full-day` and unmarked entries by their source column.
- [ ] Create stable source-derived project names/codes; map uncertain text to active fallback projects `部门日常工作`, `客户拓展阶段`, or `内部专项`.
- [ ] Derive stages from work keywords, default to `customer-support`; use `owner` role; derive explicit completion/blocking values and distribute remaining historical records between `completed` and `in-progress`.
- [ ] Create full- or half-day leave reports from explicit leave text and omit tasks in leave-only periods.

### Task 3: Transactionally refresh local development data

**Files:**
- Read: `daily-api/src/main/resources/application-local.yml`
- Update: `.codex/state/progress.md`

**Interfaces:** Consumes Task 1/2 mappings and produces a committed localhost data set.

- [ ] Query `current_database()` and stop unless it equals `daily_report_dev`.
- [ ] Within one transaction, delete analysis state, reports/tasks, active employees, and non-system projects; retain migrations and dictionary values.
- [ ] Insert normalized employees, projects, reports, and tasks with prepared statements. Commit only after foreign-key, enum, count, and text-integrity assertions pass.
- [ ] Record imported counts and coverage in the Builder state file.

### Task 4: Independently verify the complete flow

**Files:**
- Read: `daily-api/src/main/java/com/company/daily/metrics/MetricsService.java`
- Read: `daily-api/src/main/java/com/company/daily/analysis/AnalysisSourceSnapshotService.java`
- Update: `.codex/state/critique.md`
- Update: `.codex/state/handoff.md`

**Interfaces:** Consumes the committed test data and produces a Critic verdict and Finalizer closeout.

- [ ] Assert 95 active employees; no orphan reports/tasks; valid enums; valid time periods; and source text integrity.
- [ ] Confirm application health, authenticate locally, then verify people, reports, dashboard metrics, and analysis endpoints return refreshed data.
- [ ] Open the local Web application and verify Personnel Maintenance, Daily Reports, Dashboard, and Analysis render populated records.
- [ ] Mark acceptance criteria and write `LOOP_COMPLETE` only after Critic records PASS.
