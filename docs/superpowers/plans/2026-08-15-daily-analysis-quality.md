# Daily Analysis Quality Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Correct daily attendance metrics and produce evidence-backed five-workday project continuity, association, risk, and management analysis in the generated Word report.

**Architecture:** Keep the daily report date as the sole attendance and efficiency date, while the host snapshot adds a five-workday project-analysis window. The rule Skill deterministically computes facts and constrains the LLM to evidence-backed semantic sections; the template Skill renders validated facts and optional AI analysis without accessing data or recalculating metrics.

**Tech Stack:** Java 21, Spring Boot, PostgreSQL, Jackson, Python 3.12, jsonschema, python-docx, JUnit 5, unittest/pytest-compatible test runners, Docker Compose.

## Global Constraints

- Do not modify weekly or monthly Skills.
- Do not add external services or infrastructure.
- Do not infer project completion, acceptance, payment, or commercial value from missing reports.
- Keep `report_date` as the only date used for attendance and current-day efficiency metrics.
- Use the previous five workdays, inclusive of `report_date`, only for project continuity, association, and risk analysis.
- Preserve all unrelated and pre-existing uncommitted work; stage only files named in each task.
- Use test-first RED-GREEN-REFACTOR for every behavior change.

---

### Task 1: Correct attendance eligibility and cutoff metrics

**Files:**
- Modify: `deliverables/skills/daily-work-analysis/tests/test_calculate_daily_metrics.py`
- Modify: `deliverables/skills/daily-work-analysis/scripts/calculate_daily_metrics.py`
- Modify: `deliverables/skills/daily-work-analysis/references/rules.md`

**Interfaces:**
- Consumes: `DataPackage`, `report_date`, roster, attendance, report submission timestamps, optional statistics snapshots.
- Produces: `calculate_submission_dashboard(package, report_date) -> SubmissionDashboard` with counts constrained to the eligible population.

- [ ] **Step 1: Write the failing tests**

Add tests that construct 95 active people, five full-day leave records, and 93 submitted report records, then assert:

```python
dashboard = calculate_submission_dashboard(package, REPORT_DATE)
self.assertEqual(dashboard.expected_people, 90)
self.assertEqual(dashboard.submitted_by_1730_people, 88)
self.assertEqual(dashboard.submitted_by_2200_people, 88)
self.assertLessEqual(dashboard.submitted_by_1730_rate, 1.0)
self.assertLessEqual(dashboard.submitted_by_2200_rate, 1.0)
```

Add a stored-statistics test where `expected_count=90` and `submitted_count=93`; assert `calculation_source == "recalculated_inconsistent_snapshot"` and all counts/rates satisfy the same invariants. Add a half-day leave test proving the employee remains eligible when the working half-day is filled.

- [ ] **Step 2: Run the focused tests and verify RED**

Run:

```powershell
& 'deliverables/.venv/Scripts/python.exe' -m unittest 'deliverables/skills/daily-work-analysis/tests/test_calculate_daily_metrics.py' -v
```

Expected: FAIL because full-day leave reports are counted in cutoff submissions and inconsistent stored snapshots are accepted.

- [ ] **Step 3: Implement eligibility-aware cutoff calculation**

Add a helper with this contract:

```python
def eligible_person_ids(package: DataPackage, report_date: date) -> set[str]:
    return {
        item.person.person_id
        for item in classify_people(package, report_date)
        if item.state not in {"full_day_leave", "review_required"}
    }
```

Count 17:30 and 22:00 submissions only for eligible IDs. Validate stored snapshots before use:

```python
def _snapshot_is_consistent(expected: int, submitted: int, rate: float) -> bool:
    return 0 <= submitted <= expected and 0.0 <= rate <= 1.0
```

If either cutoff snapshot violates the invariant or disagrees on `expected_count`, recalculate both cutoffs from source reports and return `calculation_source="recalculated_inconsistent_snapshot"`. Extend the facts Schema enum accordingly in Task 3.

- [ ] **Step 4: Run the focused test module and full rule-Skill tests**

Run:

```powershell
& 'deliverables/.venv/Scripts/python.exe' -m unittest discover -s 'deliverables/skills/daily-work-analysis/tests' -p 'test_*.py' -v
```

Expected: all tests PASS; no submission rate exceeds `1.0`.

- [ ] **Step 5: Commit the attendance fix**

```powershell
git add -- 'deliverables/skills/daily-work-analysis/tests/test_calculate_daily_metrics.py' 'deliverables/skills/daily-work-analysis/scripts/calculate_daily_metrics.py' 'deliverables/skills/daily-work-analysis/references/rules.md'
git commit -m 'fix: align daily submission metrics with attendance eligibility'
```

### Task 2: Add a five-workday project-analysis window to the host snapshot

**Files:**
- Modify: `daily-api/src/test/java/com/company/daily/analysis/AnalysisSourceSnapshotServiceTest.java`
- Modify: `daily-api/src/main/java/com/company/daily/analysis/AnalysisSourceSnapshotService.java`
- Modify: `daily-api/src/test/java/com/company/daily/skills/DailyDataPackageAssemblerTest.java`
- Modify: `daily-api/src/main/java/com/company/daily/skills/DailyDataPackageAssembler.java`

**Interfaces:**
- Consumes: `AnalysisPeriodWindow` where a DAILY window still has `startDate == endDate == reportDate`.
- Produces: snapshot keys `reportDate`, `coverageStart`, and `coverageEnd`; data-package manifest keys `report_date`, `start_date`, and `end_date`.

- [ ] **Step 1: Write failing host snapshot tests**

Create a workday calendar with `2026-07-27` through `2026-07-31` as workdays and reports/tasks on all five dates. Assert:

```java
JsonNode snapshot = objectMapper.readTree(service.build(dailyWindow));
assertThat(snapshot.path("reportDate").asText()).isEqualTo("2026-07-31");
assertThat(snapshot.path("coverageStart").asText()).isEqualTo("2026-07-27");
assertThat(snapshot.path("coverageEnd").asText()).isEqualTo("2026-07-31");
assertThat(snapshot.path("reports")).hasSize(5);
assertThat(snapshot.path("tasks")).hasSize(5);
```

Assert DAILY trial persistence remains one day and only the snapshot analysis window expands.

- [ ] **Step 2: Run the Java tests and verify RED**

Run:

```powershell
Set-Location daily-api
./mvnw.cmd -Dtest=AnalysisSourceSnapshotServiceTest,DailyDataPackageAssemblerTest test
```

Expected: FAIL because the snapshot queries only `window.startDate()` through `window.endDate()` and the manifest has no `report_date`.

- [ ] **Step 3: Implement the lookback boundary**

Add a focused method:

```java
private LocalDate coverageStart(AnalysisPeriodWindow window) {
  if (window.period() != AnalysisPeriod.DAILY) {
    return window.startDate();
  }
  List<LocalDate> dates = jdbcTemplate.queryForList(
      "select calendar_date from workday_calendar where active=true and workday=true "
          + "and calendar_date<=? order by calendar_date desc limit 5",
      LocalDate.class, window.endDate());
  return dates.isEmpty() ? window.endDate() : dates.get(dates.size() - 1);
}
```

Use `coverageStart` for reports and task queries, retain `window.endDate()` for `reportDate`, statistics, and project-state snapshot date, and serialize all three date keys.

- [ ] **Step 4: Map the snapshot dates into the DataPackage manifest**

Update `DailyDataPackageAssembler` so the manifest contains:

```java
"report_date", root.path("reportDate").asText(end),
"start_date", root.path("coverageStart").asText(start),
"end_date", root.path("coverageEnd").asText(end)
```

Keep all five days of reports/tasks in package files; downstream current-day functions continue filtering by `report_date`.

- [ ] **Step 5: Run tests and commit**

Run the two focused Java tests and then:

```powershell
git add -- 'daily-api/src/test/java/com/company/daily/analysis/AnalysisSourceSnapshotServiceTest.java' 'daily-api/src/main/java/com/company/daily/analysis/AnalysisSourceSnapshotService.java' 'daily-api/src/test/java/com/company/daily/skills/DailyDataPackageAssemblerTest.java' 'daily-api/src/main/java/com/company/daily/skills/DailyDataPackageAssembler.java'
git commit -m 'feat: include five-workday context in daily analysis snapshots'
```

### Task 3: Produce deterministic continuity, association, and risk facts

**Files:**
- Modify: `deliverables/skills/daily-work-analysis/tests/test_build_fact_package.py`
- Modify: `deliverables/skills/daily-work-analysis/scripts/build_fact_package.py`
- Modify: `deliverables/skills/daily-work-analysis/schemas/manifest.schema.json`
- Modify: `deliverables/skills/daily-work-analysis/schemas/daily-facts.schema.json`
- Modify: `deliverables/skills/daily-work-analysis/tests/fixtures/valid/2026-07-31-leadership-data-package.zip`

**Interfaces:**
- Consumes: DataPackage v1.1 plus `manifest.report_date` and the five-workday reports/tasks.
- Produces: `daily-facts/1.2.0` with `period.report_date`, `project_continuity`, `project_associations`, and `risk_assessment`.

- [ ] **Step 1: Write failing fact-builder tests**

Build a five-day fixture with one project progressing on three dates, one new project appearing only on the report date, one project disappearing without completion evidence, two people collaborating on one project, and one person carrying multiple projects. Assert output shapes such as:

```python
self.assertEqual(facts["period"]["report_date"], "2026-07-31")
self.assertEqual(facts["period"]["start_date"], "2026-07-27")
self.assertEqual(facts["project_continuity"][0]["active_dates"], ["2026-07-27", "2026-07-29", "2026-07-31"])
self.assertEqual(facts["project_associations"][0]["association_type"], "same_project_multi_person")
self.assertIn("information_discontinuity", {item["risk_type"] for item in facts["risk_assessment"]})
```

- [ ] **Step 2: Run fact tests and verify RED**

Run:

```powershell
& 'deliverables/.venv/Scripts/python.exe' -m unittest 'deliverables/skills/daily-work-analysis/tests/test_build_fact_package.py' -v
```

Expected: FAIL because the fields do not exist and historical tasks are filtered out.

- [ ] **Step 3: Implement window task selection and fact builders**

Add functions with stable contracts:

```python
def tasks_in_window(package: DataPackage, start: date, end: date) -> tuple[TaskEntry, ...]: ...
def build_project_continuity(package: DataPackage, report_date: date) -> list[dict[str, object]]: ...
def build_project_associations(package: DataPackage, report_date: date) -> list[dict[str, object]]: ...
def build_risk_assessment(package: DataPackage, report_date: date) -> list[dict[str, object]]: ...
```

Continuity facts must expose project ID/name, active dates, people, actions/outputs, first/last date, status evidence, classification candidate, limitation note, and evidence IDs. Association facts must use only task project IDs and explicit lead/collaborator relations. Risk facts must distinguish `deadline_concentration`, `project_progress`, `staffing_concentration`, `information_discontinuity`, and `stale_project`.

- [ ] **Step 4: Upgrade and validate the facts Schema**

Set `data_contract_version` to `1.2.0`, add the new required fields, and constrain every project/person/evidence reference to non-empty strings with unique arrays. Extend `attendance_summary.calculation_source` with `recalculated_inconsistent_snapshot`.

- [ ] **Step 5: Rebuild the leadership fixture and run all rule-Skill tests**

Use the existing fixture-building helpers to replace the ZIP deterministically, then run full test discovery. Expected: all rule-Skill tests PASS and repeated builds produce byte-identical facts JSON.

- [ ] **Step 6: Commit**

```powershell
git add -- 'deliverables/skills/daily-work-analysis/tests/test_build_fact_package.py' 'deliverables/skills/daily-work-analysis/scripts/build_fact_package.py' 'deliverables/skills/daily-work-analysis/schemas/manifest.schema.json' 'deliverables/skills/daily-work-analysis/schemas/daily-facts.schema.json' 'deliverables/skills/daily-work-analysis/tests/fixtures/valid/2026-07-31-leadership-data-package.zip'
git commit -m 'feat: derive daily project continuity and association facts'
```

### Task 4: Strengthen AI analysis contract and placeholder rejection

**Files:**
- Modify: `deliverables/skills/daily-work-analysis/tests/test_validate_analysis_result.py`
- Modify: `deliverables/skills/daily-work-analysis/schemas/daily-analysis.schema.json`
- Modify: `deliverables/skills/daily-work-analysis/scripts/validate_analysis_result.py`
- Modify: `deliverables/skills/daily-work-analysis/SKILL.md`
- Modify: `deliverables/skills/daily-work-analysis/references/rules.md`
- Modify: `daily-api/src/test/java/com/company/daily/skills/SkillAnalysisExecutorTest.java`
- Modify: `daily-api/src/main/java/com/company/daily/skills/SkillAnalysisExecutor.java`

**Interfaces:**
- Consumes: `daily-facts/1.2.0`.
- Produces: `daily-analysis/1.2.0` with `overall_judgment`, `efficiency_insights`, `continuity_analysis`, `association_analysis`, `risk_items`, and `next_day_actions`.

- [ ] **Step 1: Write failing Schema and executor tests**

Assert that a valid v1.2 document with continuity and association items passes. Assert that the following summaries fail before template rendering:

```text
事实包不完整或未提供，无法生成整体判断。
无法生成整体判断。
Invalid input: data package or evidence is empty or unreadable.
```

Also assert duplicated references are deduplicated and unknown references are removed or cause the affected item to be rejected.

- [ ] **Step 2: Run Python and Java tests and verify RED**

Run the focused validation test and `SkillAnalysisExecutorTest`. Expected: placeholder Chinese summaries currently pass.

- [ ] **Step 3: Implement the v1.2 analysis Schema and validation**

Define every semantic item with:

```json
{
  "summary": "有证据的管理结论",
  "person_ids": [],
  "project_id": null,
  "evidence_ids": ["snapshot-report-1"],
  "limitation_note": null
}
```

Require non-empty continuity, association, risk, and action arrays only when corresponding deterministic fact arrays are non-empty. Reject placeholder phrases through a normalized substring check shared by the Python validator and Java executor.

- [ ] **Step 4: Rewrite model instructions as a positive output recipe**

Make `SKILL.md` require a JSON-only v1.2 response in the exact section order. Tell the model to synthesize the provided continuity/association/risk facts rather than complain about missing raw data; when one item lacks evidence, omit only that item and put the limitation in an evidence-backed parent item.

- [ ] **Step 5: Run tests and commit**

Run all rule-Skill tests and `SkillAnalysisExecutorTest`, then stage only the files above and commit:

```powershell
git commit -m 'fix: require substantive evidence-backed daily AI analysis'
```

### Task 5: Render the approved leadership report structure

**Files:**
- Modify: `deliverables/skills/daily-report-docx-template/tests/test_render_daily_report.py`
- Modify: `deliverables/skills/daily-report-docx-template/tests/test_cli_entrypoint.py`
- Modify: `deliverables/skills/daily-report-docx-template/scripts/render_daily_report.py`
- Modify: `deliverables/skills/daily-report-docx-template/scripts/audit_daily_report.py`
- Modify: `deliverables/skills/daily-report-docx-template/schemas/daily-facts.schema.json`
- Modify: `deliverables/skills/daily-report-docx-template/schemas/daily-analysis.schema.json`
- Modify: `deliverables/skills/daily-report-docx-template/SKILL.md`
- Modify: `deliverables/skills/daily-report-docx-template/references/template-contract.md`
- Modify: `deliverables/skills/daily-report-docx-template/references/layout.md`
- Modify: `deliverables/skills/daily-report-docx-template/tests/fixtures/2026-07-31-daily-facts.json`

**Interfaces:**
- Consumes: validated facts v1.2 and optional analysis v1.2.
- Produces: `report.docx` with fixed metadata and seven numbered analysis chapters after the dashboard.

- [ ] **Step 1: Write failing render tests**

Assert extracted Word text contains:

```text
2026年7月31日　覆盖周期：2026年7月27日至7月31日
一、总体概况
二、填报与出勤情况
三、人员效能分析
四、项目连续性分析
五、项目关联性及协同分析
六、风险评估
七、管理建议
```

Assert it does not contain `数据时区`, `PRESALES_IN_PROGRESS`, `snapshot_captured_at`, `事实包不完整或未提供`, or an empty chapter.

- [ ] **Step 2: Run template tests and verify RED**

Run all template-Skill tests. Expected: FAIL on metadata and missing chapters.

- [ ] **Step 3: Implement metadata and deterministic overall summary**

Format dates through a Chinese date helper. Render a deterministic overall summary whenever AI is absent or its summary matches a placeholder. The fallback must mention eligible/submitted/missing counts, current-day task composition, active project count, and the most material deterministic risk candidates.

- [ ] **Step 4: Implement continuity, association, risk, and recommendation narratives**

Prefer validated AI summaries; otherwise render deterministic facts in the same subsection taxonomy as the approved reference report. Map internal states and stages to Chinese display names, and omit captured timestamps from management prose.

- [ ] **Step 5: Strengthen the Word audit**

Require all seven chapter headings, the Chinese metadata line, a non-placeholder overall paragraph, and absence of forbidden technical tokens. Keep the dashboard as the only table.

- [ ] **Step 6: Run all template tests and commit**

```powershell
& 'deliverables/.venv/Scripts/python.exe' -m unittest discover -s 'deliverables/skills/daily-report-docx-template/tests' -p 'test_*.py' -v
git add -- 'deliverables/skills/daily-report-docx-template'
git commit -m 'feat: render leadership-grade daily project analysis reports'
```

### Task 6: Package, deploy, and verify the full 2026-07-31 flow

**Files:**
- Modify: `deliverables/packages/daily-work-analysis-v3.zip`
- Modify: `deliverables/packages/daily-report-docx-template-v3.zip`
- Create: `deliverables/word-reports/行一二部工作日报_2026-07-31_v3.docx`

**Interfaces:**
- Consumes: completed source changes and both validated Skill directories.
- Produces: uploadable Skill ZIPs and a verified end-to-end Word artifact.

- [ ] **Step 1: Run complete automated verification**

Run rule-Skill tests, template-Skill tests, `python -m compileall` on both scripts directories, targeted Java tests, and the full Maven test suite. Expected: all PASS with no Schema or CLI failures.

- [ ] **Step 2: Build deterministic Skill ZIPs**

Package each Skill with `SKILL.md` and `manifest.json` at ZIP root, excluding caches, temporary files, and test outputs. Run `SkillPackageValidatorTest` against both ZIPs.

- [ ] **Step 3: Rebuild and restart the local API**

Run:

```powershell
docker compose build daily-api
docker compose up -d daily-api daily-web nginx
```

Wait for `/actuator/health` to report `UP` before continuing.

- [ ] **Step 4: Upload and trial the two new Skill versions**

Upload the rule and template ZIPs as new draft versions, select `2026-07-31`, and run the pair. Do not overwrite published historical versions until the trial passes.

- [ ] **Step 5: Verify the generated facts, AI status, and Word document**

Confirm:

```text
应填人数 = 90
17:30已填人数 <= 90
22:00已填人数 <= 90
填写率 <= 100%
覆盖周期 = 2026-07-27 至 2026-07-31
AI状态 = succeeded（或明确 failed 且完整确定性降级）
```

Download the Word file, run the packaged DOCX renderer when available, inspect every page image, and run the structural audit. Save the accepted artifact as `deliverables/word-reports/行一二部工作日报_2026-07-31_v3.docx`.

- [ ] **Step 6: Commit final packages and verified artifact**

Stage only the two ZIPs and accepted Word file, then commit:

```powershell
git commit -m 'test: verify five-workday daily analysis end to end'
```

## Final Verification Gate

- [ ] All Python rule-Skill tests pass.
- [ ] All Python template-Skill tests pass.
- [ ] Targeted and full Java test suites pass.
- [ ] Docker API health is `UP`.
- [ ] Trial output metrics satisfy attendance invariants.
- [ ] AI status is truthful and placeholder summaries are rejected.
- [ ] Word report contains all required chapters and the approved date line.
- [ ] No weekly/monthly Skill or unrelated user file changed.
