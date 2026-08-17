# Daily Report Skill v1.2 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Upgrade the daily analysis and DOCX template skills so the Skills Center can reproduce the approved 2026-07-31 leadership report, including attendance snapshots, personnel-efficiency analysis, project master-data state, named participants, and stale-project alerts.

**Architecture:** Keep skills sandboxed and database-free. The Spring host exports a backward-compatible DataPackage 1.1 containing optional statistics, project status, and workday files; the rule skill deterministically converts that package into validated facts; the model may only add evidence-backed prose; the template skill renders validated facts into a fixed two-page-oriented DOCX and audits its OOXML.

**Tech Stack:** Java 21, Spring Boot, JDBC, Jackson, JUnit 5, Python 3.12 standard library, `python-docx`, JSON Schema, OOXML/DOCX, deterministic ZIP packaging.

## Global Constraints

- Preserve DataPackage 1.0 support; DataPackage 1.1 adds optional files and hashes without changing the original eight files.
- Skill runtime remains `daily-python-3.12-v1`, network disabled, no database access from a Skill.
- Default stale-project threshold is strictly `inactive_workdays > 3`; allow a positive integer runtime override.
- Models may not calculate or overwrite counts, rates, names, dates, status, evidence IDs, or workday intervals.
- Historical project state reconstructed after the report date must be labeled `reconstructed` in facts and Word output.
- Facts-only rendering must remain useful and must not repeat “待人工补充” placeholders.
- The internal report title is `行一二部工作日报`; it must not contain “领导版”.
- Use 2026-07-31 as the golden end-to-end fixture with metrics `90/88/88/5/2/115/11/12` and stale-project values `5/4` workdays.

---

### Task 1: Export DataPackage 1.1 source data

**Files:**
- Modify: `daily-api/src/main/java/com/company/daily/analysis/AnalysisSourceSnapshotService.java`
- Modify: `daily-api/src/main/java/com/company/daily/skills/DailyDataPackageAssembler.java`
- Modify: `daily-api/src/test/java/com/company/daily/analysis/AnalysisSourceSnapshotServiceTest.java`
- Modify: `daily-api/src/test/java/com/company/daily/skills/DailyDataPackageAssemblerTest.java`

**Interfaces:**
- Consumes: `AnalysisPeriodWindow`, existing `statistics`, `projectStates`, `workday_calendar`, and task rows.
- Produces: a ZIP retaining the original eight files and adding `statistics.json`, `project-status.json`, and `workdays.json`; manifest `data_contract_version=1.1.0` and SHA-256 entries for all eleven files.

- [ ] **Step 1: Add failing source-snapshot assertions**

Add assertions that the source snapshot includes project `captured_at`, active/formal/status/priority fields, and all workday overrides through the period end:

```java
assertThat(snapshot).contains("\"captured_at\"")
    .contains("\"formal\"")
    .contains("\"priority\"")
    .contains("\"projectStates\"");
```

- [ ] **Step 2: Add failing assembler assertions**

Extend the assembler fixture with `statistics` and two `projectStates`, including one project with no period task. Assert:

```java
assertThat(files.keySet()).contains("statistics.json", "project-status.json", "workdays.json");
assertThat(manifest.path("data_contract_version").asText()).isEqualTo("1.1.0");
assertThat(objectMapper.readTree(files.get("project-status.json"))).hasSize(2);
assertThat(second.path("snapshot_origin").asText()).isEqualTo("reconstructed");
```

- [ ] **Step 3: Run focused tests and verify RED**

Run:

```powershell
./mvnw.cmd -q -Dtest=AnalysisSourceSnapshotServiceTest,DailyDataPackageAssemblerTest test
```

Expected: FAIL because the additional project fields/files and manifest 1.1 are absent.

- [ ] **Step 4: Expand the source query**

Select project master fields and `captured_at` with the state snapshot. Query all active workday overrides through the report end, allowing the Skill to derive weekday defaults for dates without overrides:

```java
snapshot.put("workdays", jdbcTemplate.queryForList(
    "select calendar_date,workday,source,note from workday_calendar "
        + "where calendar_date<=? and active=true order by calendar_date", window.endDate()));
snapshot.put("projectStates", jdbcTemplate.queryForList(
    "select s.snapshot_date,s.captured_at,s.project_id,s.project_name,s.state,s.lifecycle,"
        + "s.current_stage,s.state_started_date,s.owner_name,s.participant_count,"
        + "s.blocked_task_count,s.latest_report_date,p.formal,p.active,p.status,p.priority "
        + "from project_state_snapshots s join projects p on p.id=s.project_id "
        + "where s.snapshot_date=? order by s.project_id", window.endDate()));
```

- [ ] **Step 5: Emit the three optional files**

Add all eleven names to `PACKAGE_FILES`; map statistics without recalculation, map project state IDs to the same `project-*` namespace used by tasks, and derive snapshot origin:

```java
String origin = capturedAt.toLocalDate().isAfter(snapshotDate.plusDays(1))
    ? "reconstructed" : "captured";
```

Write `workdays.json` as `{date, workday, source, note}` rows. Hash each emitted file and set manifest contract version to `1.1.0`.

- [ ] **Step 6: Run focused and package-consumer tests**

Run:

```powershell
./mvnw.cmd -q -Dtest=AnalysisSourceSnapshotServiceTest,DailyDataPackageAssemblerTest,SkillAnalysisExecutorTest test
```

Expected: PASS, zero failures.

- [ ] **Step 7: Commit**

```powershell
git add daily-api/src/main/java/com/company/daily/analysis/AnalysisSourceSnapshotService.java daily-api/src/main/java/com/company/daily/skills/DailyDataPackageAssembler.java daily-api/src/test/java/com/company/daily/analysis/AnalysisSourceSnapshotServiceTest.java daily-api/src/test/java/com/company/daily/skills/DailyDataPackageAssemblerTest.java
git commit -m "feat: export daily skill data package v1.1"
```

### Task 2: Validate DataPackage 1.1 while retaining 1.0

**Files:**
- Create: `deliverables/skills/daily-work-analysis/schemas/statistics.schema.json`
- Create: `deliverables/skills/daily-work-analysis/schemas/project-status.schema.json`
- Create: `deliverables/skills/daily-work-analysis/schemas/workdays.schema.json`
- Modify: `deliverables/skills/daily-work-analysis/schemas/manifest.schema.json`
- Modify: `deliverables/skills/daily-work-analysis/scripts/package_contract.py`
- Modify: `deliverables/skills/daily-work-analysis/tests/test_validate_data_package.py`
- Modify: `deliverables/skills/daily-work-analysis/tests/fixtures/valid/daily-data-package.zip`

**Interfaces:**
- Consumes: DataPackage `1.0.0` or `1.1.0` ZIP.
- Produces: `DailyDataPackage` with tuples `statistics`, `project_statuses`, and `workdays`; empty tuples for 1.0.

- [ ] **Step 1: Add compatibility and validation tests**

Add tests proving 1.0 remains valid, 1.1 loads all three new documents, hashes are required for files present, unknown project/person references fail, and unknown major versions fail:

```python
self.assertEqual((), package.project_statuses)
self.assertEqual("captured", v11.project_statuses[0].snapshot_origin)
self.assertIn("FILE_HASH_MISMATCH", issue_codes)
```

- [ ] **Step 2: Run contract tests and verify RED**

Run:

```powershell
python -m unittest deliverables/skills/daily-work-analysis/tests/test_validate_data_package.py -v
```

Expected: FAIL because 1.1 schemas and dataclasses do not exist.

- [ ] **Step 3: Add strict schemas**

Define `additionalProperties:false` schemas. `project-status.json` requires identity, snapshot metadata, owner/state fields, `blocked_task_count>=0`, nullable `latest_report_date`, and `snapshot_origin` in `captured|reconstructed`. `statistics.json` requires counts, rate, and name/ID lists. `workdays.json` requires date and boolean workday.

- [ ] **Step 4: Extend package parsing**

Keep the original eight files required. For 1.1, require the three additional files. Parse to immutable dataclasses:

```python
@dataclass(frozen=True)
class ProjectStatusEntry:
    project_id: str
    project_name: str
    snapshot_date: str
    snapshot_origin: str
    latest_report_date: str | None
    blocked_task_count: int
```

Validate task-to-project and project-state-to-project IDs without rejecting a status-only project that has no task in the period.

- [ ] **Step 5: Rebuild valid fixture and run tests**

Run the test fixture builder already used by `test_validate_data_package.py`, then rerun the test module.

Expected: PASS, including both versions.

- [ ] **Step 6: Commit**

```powershell
git add deliverables/skills/daily-work-analysis/schemas deliverables/skills/daily-work-analysis/scripts/package_contract.py deliverables/skills/daily-work-analysis/tests
git commit -m "feat: validate daily data package v1.1"
```

### Task 3: Build leadership-grade deterministic facts

**Files:**
- Modify: `deliverables/skills/daily-work-analysis/schemas/daily-facts.schema.json`
- Modify: `deliverables/skills/daily-work-analysis/scripts/calculate_daily_metrics.py`
- Modify: `deliverables/skills/daily-work-analysis/scripts/build_fact_package.py`
- Modify: `deliverables/skills/daily-work-analysis/tests/test_calculate_daily_metrics.py`
- Modify: `deliverables/skills/daily-work-analysis/tests/test_build_fact_package.py`
- Modify: `deliverables/skills/daily-work-analysis/tests/golden/cases.json`
- Modify: `deliverables/skills/daily-work-analysis/tests/golden/expected.json`

**Interfaces:**
- Consumes: validated `DailyDataPackage`, `stale_threshold_workdays: int = 3`.
- Produces: `daily-facts/1.1.0` with `attendance_dashboard`, `efficiency_summary`, `formal_project_dynamics`, `unlinked_project_dynamics`, `stale_project_alerts`, `data_quality`, and existing evidence ledger.

- [ ] **Step 1: Add RED tests for the approved report**

Create a 2026-07-31 fixture asserting the exact dashboard and project behavior:

```python
self.assertEqual(90, facts["attendance_dashboard"]["expected_count"])
self.assertEqual(88, facts["attendance_dashboard"]["submitted_1730_count"])
self.assertEqual(["王达伟", "吴鹏"], facts["missing_people"])
self.assertEqual(12, facts["efficiency_summary"]["blocked_task_count"])
self.assertEqual([5, 4], [x["inactive_workdays"] for x in facts["stale_project_alerts"]])
```

Add boundary tests: 3 workdays does not alert, 4 does; weekends and holiday overrides do not count; half-day leave excludes only the leave period.

- [ ] **Step 2: Run facts tests and verify RED**

Run:

```powershell
python -m unittest deliverables/skills/daily-work-analysis/tests/test_calculate_daily_metrics.py deliverables/skills/daily-work-analysis/tests/test_build_fact_package.py -v
```

Expected: FAIL on missing leadership-grade fact fields.

- [ ] **Step 3: Implement deterministic attendance and efficiency facts**

Prefer stored statistics snapshots. If absent, derive from submission timestamps and set `calculation_source=recalculated`. Emit names by joining IDs to roster. Count task statuses from validated tasks; never infer performance scores.

- [ ] **Step 4: Implement project joins and stale calculation**

Group task relations into lead/collaborator names. Separate confirmed formal projects from pending/unlinked candidates. Compute workdays using override rows, defaulting missing calendar dates to Monday-Friday:

```python
def inactive_workdays(latest: date, end: date, overrides: dict[date, bool]) -> int:
    return sum(overrides.get(day, day.weekday() < 5)
               for day in dates_exclusive(latest, end))
```

Emit alerts only for active projects with `inactive_workdays > threshold`. Include owner, state, stage, blockers, latest activity, snapshot origin, and evidence IDs.

- [ ] **Step 5: Add data-quality limitations**

Set `project_status_coverage=unavailable` for DataPackage 1.0. For reconstructed snapshots include the capture date and a human-readable restriction. Preserve all source IDs.

- [ ] **Step 6: Run all rule-skill tests**

Run:

```powershell
python -m unittest discover -s deliverables/skills/daily-work-analysis/tests -p 'test_*.py' -v
```

Expected: PASS, zero failures.

- [ ] **Step 7: Commit**

```powershell
git add deliverables/skills/daily-work-analysis
git commit -m "feat: produce leadership daily report facts"
```

### Task 4: Align model analysis with the leadership report

**Files:**
- Modify: `deliverables/skills/daily-work-analysis/schemas/daily-analysis.schema.json`
- Modify: `deliverables/skills/daily-work-analysis/scripts/evaluate_analysis.py`
- Modify: `deliverables/skills/daily-work-analysis/scripts/validate_analysis_result.py`
- Modify: `deliverables/skills/daily-work-analysis/tests/test_evaluate_analysis.py`
- Modify: `deliverables/skills/daily-work-analysis/tests/test_validate_analysis_result.py`
- Modify: `deliverables/skills/daily-work-analysis/references/rules.md`
- Modify: `deliverables/skills/daily-work-analysis/SKILL.md`
- Modify: `deliverables/skills/daily-work-analysis/manifest.json`

**Interfaces:**
- Consumes: `daily-facts/1.1.0` only.
- Produces: validated `daily-analysis/1.1.0` fields `overall_judgment`, `efficiency_insights`, `project_highlights`, `risk_items`, `next_day_actions`, each item carrying known evidence IDs.

- [ ] **Step 1: Add RED schema/evidence tests**

Require the new blocks and reject unknown metrics, people, projects, evidence IDs, unsupported numeric claims, and conclusions based only on reconstructed data without a limitation note.

- [ ] **Step 2: Run analysis tests and verify RED**

Run:

```powershell
python -m unittest deliverables/skills/daily-work-analysis/tests/test_evaluate_analysis.py deliverables/skills/daily-work-analysis/tests/test_validate_analysis_result.py -v
```

Expected: FAIL on the old four-block analysis schema.

- [ ] **Step 3: Update schema and prompt contract**

Use a uniform evidence-backed item:

```json
{
  "summary": "管理判断",
  "person_ids": ["employee-1"],
  "project_id": "project-1",
  "evidence_ids": ["snapshot-report-1"]
}
```

Allow nullable project/person references where appropriate, but require a non-empty evidence list for every semantic item.

- [ ] **Step 4: Update validator and rules**

Validate against facts IDs and prohibit model-supplied dashboard values. State that stale alerts and attendance are deterministic facts; the model may explain impact and propose actions only.

- [ ] **Step 5: Bump analysis Skill version**

Set `skill_version=1.2.0`, facts and analysis contracts to `1.1.0`, retain runtime profile and no-network permission. Keep SKILL.md concise and route detailed business rules to `references/rules.md`.

- [ ] **Step 6: Run all rule-skill tests and commit**

Run the full rule-skill unittest discovery command; expect PASS.

```powershell
git add deliverables/skills/daily-work-analysis
git commit -m "feat: align daily analysis with leadership report"
```

### Task 5: Rebuild the DOCX template Skill

**Files:**
- Modify: `deliverables/skills/daily-report-docx-template/assets/daily-report-template.docx`
- Modify: `deliverables/skills/daily-report-docx-template/references/layout.md`
- Modify: `deliverables/skills/daily-report-docx-template/schemas/daily-analysis.schema.json`
- Create: `deliverables/skills/daily-report-docx-template/schemas/daily-facts.schema.json`
- Modify: `deliverables/skills/daily-report-docx-template/scripts/render_daily_report.py`
- Modify: `deliverables/skills/daily-report-docx-template/scripts/audit_daily_report.py`
- Modify: `deliverables/skills/daily-report-docx-template/tests/test_render_daily_report.py`
- Modify: `deliverables/skills/daily-report-docx-template/tests/test_template_asset.py`
- Modify: `deliverables/skills/daily-report-docx-template/SKILL.md`
- Modify: `deliverables/skills/daily-report-docx-template/manifest.json`

**Interfaces:**
- Consumes: validated `daily-facts/1.1.0`, optional validated `daily-analysis/1.1.0`.
- Produces: `report.docx` and machine-readable audit status.

- [ ] **Step 1: Add RED report-content tests**

Assert exact title, eight dashboard cells, five management sections, named attendance, three project subsections, stale alerts, next-workday actions, and reconstruction note. Assert forbidden placeholder text is absent.

- [ ] **Step 2: Add RED OOXML style tests**

Inspect `word/document.xml` and `word/styles.xml` for the agreed fonts, dashboard fill, white labels, larger values, page margins, repeat header rows, and title without “领导版”.

- [ ] **Step 3: Run template tests and verify RED**

Run:

```powershell
python -m unittest discover -s deliverables/skills/daily-report-docx-template/tests -p 'test_*.py' -v
```

Expected: FAIL because the old asset and renderer omit leadership sections.

- [ ] **Step 4: Rebuild template asset**

Use deterministic `python-docx` generation to create the approved anchor structure. Dashboard labels use a smaller black-style Chinese font over dark blue fill; values use coordinated larger Song font. Body uses simple official-document styling and compact tables.

- [ ] **Step 5: Render all leadership sections**

Map facts directly to tables and lists. Model text enhances overall judgment and management actions only after validation. With no model result, generate concise deterministic judgments from facts; do not display repeated failure placeholders.

- [ ] **Step 6: Strengthen audit**

Fail rendering when the DOCX is invalid, title/sections/dashboard are absent, unknown placeholder text remains, or required names/project alerts are dropped.

- [ ] **Step 7: Bump template Skill version and run tests**

Set `skill_version=1.2.0` and contracts to 1.1.0. Run all template tests; expect PASS.

- [ ] **Step 8: Commit**

```powershell
git add deliverables/skills/daily-report-docx-template
git commit -m "feat: render leadership-grade daily reports"
```

### Task 6: Golden end-to-end trial, packaging, and host regression

**Files:**
- Create: `deliverables/skills/daily-work-analysis/tests/fixtures/valid/2026-07-31-leadership-data-package.zip`
- Create: `deliverables/skills/daily-report-docx-template/tests/fixtures/2026-07-31-daily-facts.json`
- Modify: `tools/build_scripted_skill_packages.py`
- Modify: `daily-api/src/test/java/com/company/daily/skills/SkillPackageValidatorTest.java`
- Modify: `daily-api/src/test/java/com/company/daily/skills/SkillAnalysisExecutorTest.java`
- Create: `deliverables/word-reports/tests/test_daily_leadership_pipeline.py`
- Create: `deliverables/word-reports/行一二部工作日报_2026-07-31.docx`

**Interfaces:**
- Consumes: packaged Skill ZIPs and the 2026-07-31 DataPackage fixture.
- Produces: two v1.2.0 ZIPs and a golden DOCX matching approved content.

- [ ] **Step 1: Add failing pipeline test**

Execute prepare-facts, validate a valid model response, render DOCX, and audit the output. Assert the exact approved metrics, names, project rows, `5/4` stale alerts, title, and reconstruction disclaimer.

- [ ] **Step 2: Run pipeline test and verify RED**

Run:

```powershell
python -m unittest deliverables/word-reports/tests/test_daily_leadership_pipeline.py -v
```

Expected: FAIL until the fixture and v1.2 packages exist.

- [ ] **Step 3: Build deterministic v1.2 ZIPs**

Update the builder to read manifest versions and create:

```text
deliverables/skill-packages/daily-work-analysis-v1.2.0.zip
deliverables/skill-packages/daily-report-docx-template-v1.2.0.zip
```

Exclude `__pycache__`, test render outputs, and temporary files; keep fixed ZIP timestamps.

- [ ] **Step 4: Run complete verification**

Run:

```powershell
python -m unittest discover -s deliverables/skills/daily-work-analysis/tests -p 'test_*.py' -v
python -m unittest discover -s deliverables/skills/daily-report-docx-template/tests -p 'test_*.py' -v
python -m unittest deliverables/word-reports/tests/test_daily_leadership_pipeline.py -v
python tools/build_scripted_skill_packages.py
./mvnw.cmd -q test
```

Expected: every command exits 0 with zero failures; both ZIPs exist and validate.

- [ ] **Step 5: Inspect generated DOCX structurally**

Open it with `python-docx` and `zipfile`; confirm the package is healthy, all required sections and names exist, “领导版” is absent from the title, and no placeholder failure messages remain.

- [ ] **Step 6: Commit**

```powershell
git add deliverables/skill-packages deliverables/word-reports deliverables/skills tools daily-api
git commit -m "test: verify daily report skills v1.2 end to end"
```

## Self-Review Result

- Spec coverage: data-package compatibility, deterministic facts, model evidence gate, fixed Word layout, fallback behavior, stale-project threshold, reconstructed snapshots, packaging, and golden E2E each map to a task.
- Placeholder scan: no implementation placeholders remain; all test and implementation steps identify concrete files, interfaces, commands, and expected outcomes.
- Type consistency: DataPackage `1.1.0` feeds facts `1.1.0`; facts and analysis `1.1.0` are consumed by template Skill `1.2.0`; project/person/evidence IDs remain in existing namespaces.
