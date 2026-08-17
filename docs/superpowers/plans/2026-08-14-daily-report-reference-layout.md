# Daily Report Reference Layout Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Upgrade the daily Word template Skill so its generated report follows the supplied project-analysis report's typography and narrative structure while retaining the daily cockpit.

**Architecture:** Keep the existing `daily-facts/1.1.0` and `daily-analysis/1.1.0` contracts. Move page and typography authority into the DOCX asset, then render deterministic narrative sections using named template styles; only the cockpit remains a table.

**Tech Stack:** Python 3.12, python-docx, OOXML, unittest, deterministic ZIP packaging.

## Global Constraints

- Preserve the daily rules Skill and evidence validation behavior.
- Use Letter portrait, 0.83-inch margins, 黑体 headings and 仿宋_GB2312 body typography from the reference.
- Keep the 2×4 cockpit and deterministic metrics.
- Do not invent people, projects, progress, risks, or recommendations.
- Bump the template Skill minor version to `1.3.0`.

---

### Task 1: Lock the reference layout contract

**Files:**
- Modify: `deliverables/skills/daily-report-docx-template/tests/test_template_asset.py`
- Modify: `deliverables/skills/daily-report-docx-template/tests/test_render_daily_report.py`

**Interfaces:**
- Consumes: existing `render_daily_report(template_path, facts, analysis, output_path)`.
- Produces: failing tests for page geometry, typography, section order, and narrative layout.

- [x] Add assertions for Letter page size, 0.83-inch margins, title 18 pt, body 11 pt, Heading 1 15 pt and Heading 2 13 pt.
- [x] Add assertions that only the cockpit remains a table and that all required management sections appear in order.
- [x] Run the two tests and verify they fail against v1.2.0.

### Task 2: Rebuild template asset and renderer

**Files:**
- Modify: `deliverables/skills/daily-report-docx-template/scripts/render_daily_report.py`
- Modify: `deliverables/skills/daily-report-docx-template/scripts/audit_daily_report.py`
- Modify: `deliverables/skills/daily-report-docx-template/assets/daily-report-template.docx`

**Interfaces:**
- Consumes: daily facts and optional validated analysis.
- Produces: a Letter-format narrative management report with the existing cockpit.

- [x] Configure the template asset with the approved page and style values.
- [x] Remove runtime page/style overrides and render headings/body through named styles.
- [x] Replace attendance, efficiency, project and stale-project tables with numbered narrative paragraphs.
- [x] Update the audit to enforce the new geometry and required structure.
- [x] Run template tests until green.

### Task 3: Version and document the template Skill

**Files:**
- Modify: `deliverables/skills/daily-report-docx-template/manifest.json`
- Modify: `deliverables/skills/daily-report-docx-template/SKILL.md`
- Modify: `deliverables/skills/daily-report-docx-template/references/template-contract.md`

**Interfaces:**
- Produces: uploadable Skill version `1.3.0` using unchanged facts and analysis contracts.

- [x] Record the new narrative layout contract and version.
- [x] Validate the Skill package through the host validator and run all template tests.

### Task 4: Rebuild golden report and package

**Files:**
- Modify: `deliverables/word-reports/tests/test_daily_leadership_pipeline.py`
- Create: `deliverables/word-reports/行一二部工作日报_2026-07-31.docx`
- Create: `deliverables/skill-packages/daily-report-docx-template-v1.3.0.zip`
- Modify: `daily-api/src/test/java/com/company/daily/skills/SkillPackageValidatorTest.java`

**Interfaces:**
- Consumes: the existing 2026-07-31 golden DataPackage and facts fixture.
- Produces: final DOCX, deterministic Skill ZIP and host package-validation coverage.

- [x] Run the end-to-end test and verify the new structure and existing metric values.
- [x] Rebuild the DOCX and deterministic ZIP twice; compare SHA-256 hashes.
- [x] Update the host validator test to accept v1.3.0.
- [x] Run Python Skill tests and focused Maven tests.
- [x] Commit only the intended files; preserve unrelated dirty host files.
