# Imported Blocker Placeholder Cleanup Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Prevent imported English blocker placeholders from being stored or displayed in leader-facing reports.

**Architecture:** The importer stops fabricating blocker text. A reversible data migration clears one exact legacy placeholder. The DOCX renderer treats placeholders and unmapped status codes as non-displayable and supplies a Chinese missing-reason sentence only when a task is actually blocked.

**Tech Stack:** Python 3, pytest, Flyway SQL, Spring Boot/Maven.

## Global Constraints

- Preserve genuine Chinese collaboration requirements and all task status values.
- Do not alter report layout or unrelated project-state rules.
- User-visible report text must be Chinese; no placeholder or unmapped English status code may appear.

---

### Task 1: Stop fabricating blocker details in the July importer

**Files:**
- Modify: `tools/prepare_july_import.py:96`

**Interfaces:**
- Produces SQL with `collaboration_requirement = null` for imported blocked tasks.

- [ ] **Step 1: Add a focused importer-output test or controlled script assertion.**
- [ ] **Step 2: Run it and observe that current blocked rows contain the placeholder.**
- [ ] **Step 3: Change the blocked-task tuple from fabricated dependency metadata to `null,null,null`.**
- [ ] **Step 4: Re-run the check and Python compilation.**

### Task 2: Clear exact legacy placeholder values

**Files:**
- Create: `daily-api/src/main/resources/db/migration/V025__clear_imported_blocker_placeholder.sql`

**Interfaces:**
- Consumes: `daily_tasks.collaboration_requirement`.
- Produces: null collaboration requirements only for the exact legacy placeholder.

- [ ] **Step 1: Write migration SQL that updates only the exact placeholder.**
- [ ] **Step 2: Verify SQL text and run the backend migration through the local application.**

### Task 3: Filter non-business text during DOCX rendering

**Files:**
- Modify: `deliverables/skills/daily-report-docx-template/scripts/render_daily_report.py`
- Modify: `deliverables/skills/daily-report-docx-template/tests/test_render_daily_report.py`

**Interfaces:**
- Produces Chinese narrative text from formal project dynamics and risk candidates.

- [ ] **Step 1: Add failing rendering tests for the legacy placeholder and an unknown English state.**
- [ ] **Step 2: Run the focused tests and observe the unsafe text in rendered document paragraphs.**
- [ ] **Step 3: Add minimal normalization/filtering and the Chinese missing-reason sentence.**
- [ ] **Step 4: Re-run targeted template tests.**

### Task 4: Verify end-to-end persistence and rendering boundary

**Files:**
- Modify: `.codex/state/progress.md`
- Modify: `.codex/state/critique.md`
- Modify: `.codex/state/handoff.md`

- [ ] **Step 1: Run template tests, importer syntax validation, migration verification, and Maven compile.**
- [ ] **Step 2: Query the development database for remaining exact placeholders.**
- [ ] **Step 3: Record evidence and obtain an independent Critic PASS before finalization.**
