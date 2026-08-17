from __future__ import annotations

import sys
import unittest
from dataclasses import replace
from datetime import date
from pathlib import Path


SKILL_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(SKILL_ROOT / "scripts"))

from package_contract import (  # noqa: E402
    AttendanceEntry,
    DataPackage,
    PackageManifest,
    ReportEntry,
    RosterEntry,
    StatisticsEntry,
    TaskEntry,
    TaskRelation,
)
from calculate_daily_metrics import calculate_daily_metrics, calculate_submission_dashboard  # noqa: E402


REPORT_DATE = date(2026, 7, 31)


def package_for(*, people: list[tuple[str, str]], attendance: list[AttendanceEntry] | None = None, reports: list[ReportEntry] | None = None, tasks: list[TaskEntry] | None = None, relations: list[TaskRelation] | None = None, statistics: list[StatisticsEntry] | None = None) -> DataPackage:
    attendance = attendance or []
    reports = reports or []
    tasks = tasks or []
    relations = relations or []
    statistics = statistics or []
    snapshot_ids = sorted({item.snapshot_id for item in reports} | {item.evidence_id for item in relations})
    return DataPackage(
        manifest=PackageManifest(
            data_contract_version="1.0.0", package_id="fixture", department_id="dept",
            department_name="test", period_type="daily", start_date=REPORT_DATE.isoformat(), end_date=REPORT_DATE.isoformat(),
            working_dates=(REPORT_DATE.isoformat(),), timezone="Asia/Shanghai", generated_at="not-for-facts",
            file_sha256=(),
        ),
        roster=tuple(RosterEntry(person_id=person_id, name=name, group="test", personnel_type="employee", effective_start_date="2026-01-01", effective_end_date=None, include_in_statistics=True) for person_id, name in people),
        attendance=tuple(attendance), reports=tuple(reports), tasks=tuple(tasks),
        task_relations=tuple(relations), projects=(), statistics=tuple(statistics),
        source_snapshots=tuple(
            {"snapshot_id": snapshot_id, "source_system": "test-system", "source_record_id": snapshot_id,
             "raw_record": f"raw-{snapshot_id}", "evidence_quality": "source-record-id"}
            for snapshot_id in snapshot_ids
        ),
    )


def attendance_entry(person_id: str, leave_period: str) -> AttendanceEntry:
    periods = {
        "none": ("working", "working"), "full_day": ("leave", "leave"),
        "morning": ("leave", "working"), "afternoon": ("working", "leave"),
        "unknown": ("unknown", "unknown"),
    }
    morning, afternoon = periods[leave_period]
    return AttendanceEntry(person_id, REPORT_DATE.isoformat(), morning, afternoon, "annual" if leave_period != "none" else None, leave_period, f"attendance-{person_id}")


def report(person_id: str, suffix: str, status: str = "submitted", submitted_at: str | None = None) -> ReportEntry:
    return ReportEntry(f"report-{suffix}", person_id, REPORT_DATE.isoformat(), status, submitted_at, submitted_at, "report", f"snapshot-{suffix}")


def statistics(snapshot_type: str, expected: int, submitted: int) -> StatisticsEntry:
    return StatisticsEntry(
        snapshot_type, REPORT_DATE.isoformat(), None, expected, submitted,
        expected - submitted, submitted / expected if expected else 0.0,
        (), (), (), (),
    )


def task(report_id: str, suffix: str, period: str = "morning", *, status: str = "completed", risk: str | None = None, blocker: str | None = None) -> TaskEntry:
    return TaskEntry(f"task-{suffix}", report_id, REPORT_DATE.isoformat(), period, "work", "project", None, status, None, risk, blocker, None)


class CalculateDailyMetricsTests(unittest.TestCase):
    def test_cutoff_dashboard_excludes_full_day_leave_reports_from_the_eligible_population(self) -> None:
        people = [(f"p{index:02d}", f"person-{index:02d}") for index in range(1, 96)]
        leave_ids = {f"p{index:02d}" for index in range(91, 96)}
        attendance = [attendance_entry(person_id, "full_day") for person_id in sorted(leave_ids)]
        reports = [
            report(person_id, person_id, submitted_at="2026-07-31T17:00:00+08:00")
            for person_id, _ in people
            if person_id not in {"p89", "p90"}
        ]
        tasks = [
            task(f"report-{person_id}", person_id)
            for person_id, _ in people
            if person_id not in leave_ids and person_id not in {"p89", "p90"}
        ]
        package = package_for(people=people, attendance=attendance, reports=reports, tasks=tasks)

        dashboard = calculate_submission_dashboard(package, REPORT_DATE)

        self.assertEqual(dashboard.expected_people, 90)
        self.assertEqual(dashboard.submitted_by_1730_people, 88)
        self.assertEqual(dashboard.submitted_by_2200_people, 88)
        self.assertAlmostEqual(dashboard.submitted_by_1730_rate or 0, 88 / 90)
        self.assertLessEqual(dashboard.submitted_by_2200_rate or 0, 1.0)

    def test_inconsistent_stored_cutoff_snapshot_is_recalculated(self) -> None:
        package = package_for(
            people=[("p1", "worker"), ("p2", "leave")],
            attendance=[attendance_entry("p2", "full_day")],
            reports=[
                report("p1", "1", submitted_at="2026-07-31T17:00:00+08:00"),
                report("p2", "2", submitted_at="2026-07-31T17:00:00+08:00"),
            ],
            tasks=[task("report-1", "1")],
            statistics=[statistics("PROGRESS_1730", 1, 2), statistics("FINAL_2200", 1, 2)],
        )

        dashboard = calculate_submission_dashboard(package, REPORT_DATE)

        self.assertEqual(dashboard.expected_people, 1)
        self.assertEqual(dashboard.submitted_by_1730_people, 1)
        self.assertEqual(dashboard.submitted_by_2200_people, 1)
        self.assertEqual(dashboard.calculation_source, "recalculated_inconsistent_snapshot")

    def test_counts_normal_blank_and_half_day_states(self) -> None:
        package = package_for(
            people=[("p1", "normal"), ("p2", "blank"), ("p3", "full"), ("p4", "half-work"), ("p5", "half-missing")],
            attendance=[attendance_entry("p3", "full_day"), attendance_entry("p4", "morning"), attendance_entry("p5", "afternoon")],
            reports=[report("p1", "1"), report("p4", "4")],
            tasks=[task("report-1", "1"), task("report-4", "4", "afternoon")],
        )

        metrics = calculate_daily_metrics(package, REPORT_DATE)

        self.assertEqual(metrics.roster_people, 5)
        self.assertEqual(metrics.expected_people, 4)
        self.assertEqual(metrics.submitted_people, 2)
        self.assertEqual(metrics.missing_people, 2)
        self.assertEqual(metrics.full_day_leave_people, 1)
        self.assertEqual(metrics.half_day_leave_people, 2)
        self.assertEqual(metrics.submission_rate, 0.5)

    def test_unknown_leave_and_full_day_work_conflict_make_expected_metrics_ambiguous(self) -> None:
        unknown = package_for(people=[("p1", "unknown")], attendance=[attendance_entry("p1", "unknown")])
        conflict = package_for(
            people=[("p1", "conflict")], attendance=[attendance_entry("p1", "full_day")],
            reports=[report("p1", "1")], tasks=[task("report-1", "1")],
        )

        ambiguous_metrics = calculate_daily_metrics(unknown, REPORT_DATE)
        conflict_metrics = calculate_daily_metrics(conflict, REPORT_DATE)

        self.assertIsNone(ambiguous_metrics.expected_people)
        self.assertIsNone(ambiguous_metrics.submission_rate)
        self.assertEqual(ambiguous_metrics.review_required_people, 1)
        self.assertIsNone(conflict_metrics.expected_people)
        self.assertEqual(conflict_metrics.review_required_people, 1)

    def test_tasks_are_deduplicated_by_task_id_and_risks_are_counted_once(self) -> None:
        first = task("report-1", "same", status="blocked", risk="risk", blocker="blocker")
        duplicate = replace(first, raw_text="duplicate")
        package = package_for(people=[("p1", "worker")], reports=[report("p1", "1")], tasks=[first, duplicate])

        metrics = calculate_daily_metrics(package, REPORT_DATE)

        self.assertEqual(metrics.effective_task_count, 1)
        self.assertEqual(metrics.risk_or_blocked_count, 1)

    def test_multiple_submitted_reports_for_one_person_do_not_depend_on_input_order(self) -> None:
        package = package_for(
            people=[("p1", "worker")], reports=[report("p1", "first"), report("p1", "second")],
            tasks=[task("report-first", "first")],
        )

        metrics = calculate_daily_metrics(package, REPORT_DATE)

        self.assertEqual(metrics.submitted_people, 1)
        self.assertEqual(metrics.missing_people, 0)

    def test_duplicate_attendance_is_order_independent_and_requires_review(self) -> None:
        first = attendance_entry("p1", "morning")
        second = attendance_entry("p1", "afternoon")
        first_package = package_for(people=[("p1", "worker")], attendance=[first, second])
        reversed_package = package_for(people=[("p1", "worker")], attendance=[second, first])

        first_metrics = calculate_daily_metrics(first_package, REPORT_DATE)
        reversed_metrics = calculate_daily_metrics(reversed_package, REPORT_DATE)

        self.assertEqual(first_metrics, reversed_metrics)
        self.assertEqual(first_metrics.review_required_people, 1)
        self.assertIsNone(first_metrics.expected_people)


if __name__ == "__main__":
    unittest.main()
