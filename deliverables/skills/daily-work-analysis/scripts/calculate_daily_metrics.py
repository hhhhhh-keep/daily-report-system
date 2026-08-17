"""Deterministic daily reporting metrics derived from a trusted data package."""

from __future__ import annotations

from dataclasses import dataclass
from datetime import date, datetime, time
from typing import Literal

from package_contract import AttendanceEntry, DataPackage, RosterEntry, TaskEntry


PersonState = Literal["normal", "missing", "full_day_leave", "half_day_leave", "review_required"]


@dataclass(frozen=True, slots=True)
class DailyMetrics:
    roster_people: int
    expected_people: int | None
    submitted_people: int
    submission_rate: float | None
    missing_people: int
    full_day_leave_people: int
    half_day_leave_people: int
    review_required_people: int
    effective_task_count: int
    risk_or_blocked_count: int


@dataclass(frozen=True, slots=True)
class SubmissionDashboard:
    expected_people: int | None
    submitted_by_1730_people: int
    submitted_by_1730_rate: float | None
    submitted_by_2200_people: int
    submitted_by_2200_rate: float | None
    calculation_source: str


@dataclass(frozen=True, slots=True)
class PersonClassification:
    person: RosterEntry
    state: PersonState
    work_period_status: str | None
    review_reason: str | None
    source_record_id: str | None


def active_roster(package: DataPackage, report_date: date) -> tuple[RosterEntry, ...]:
    day = report_date.isoformat()
    return tuple(sorted(
        (person for person in package.roster if person.include_in_statistics
         and person.effective_start_date <= day
         and (person.effective_end_date is None or day <= person.effective_end_date)),
        key=lambda person: person.person_id,
    ))


def deduplicated_tasks(package: DataPackage, report_date: date) -> tuple[TaskEntry, ...]:
    """Return a canonical task per ID, independent of package array order."""
    day = report_date.isoformat()
    tasks: dict[str, TaskEntry] = {}
    for item in package.tasks:
        if item.date != day:
            continue
        previous = tasks.get(item.task_id)
        if previous is None or _task_key(item) < _task_key(previous):
            tasks[item.task_id] = item
    return tuple(tasks[task_id] for task_id in sorted(tasks))


def _task_key(item: TaskEntry) -> tuple[object, ...]:
    return (
        item.report_id, item.time_period, item.raw_text, item.task_type,
        item.project_candidate_id or "", item.status, item.output or "", item.risk or "",
        item.blocker or "", item.next_step or "",
    )


def classify_people(package: DataPackage, report_date: date) -> tuple[PersonClassification, ...]:
    """Classify people using the documented, mutually-exclusive priority order."""
    day = report_date.isoformat()
    roster = active_roster(package, report_date)
    people = {person.person_id: person for person in roster}
    attendance_by_person: dict[str, list[AttendanceEntry]] = {person_id: [] for person_id in people}
    for item in package.attendance:
        if item.date == day and item.person_id in people:
            attendance_by_person[item.person_id].append(item)
    submitted_reports = {
        item.report_id: item for item in package.reports
        if item.date == day and item.person_id in people and item.submission_status == "submitted"
    }
    submitted_people = {item.person_id for item in submitted_reports.values()}
    report_people = {report_id: report.person_id for report_id, report in submitted_reports.items()}
    tasks_by_person: dict[str, list[TaskEntry]] = {person_id: [] for person_id in people}
    for item in deduplicated_tasks(package, report_date):
        person_id = report_people.get(item.report_id)
        if person_id is not None:
            tasks_by_person[person_id].append(item)

    classifications: list[PersonClassification] = []
    for person in roster:
        attendance_entries = attendance_by_person[person.person_id]
        attendance = attendance_entries[0] if len(attendance_entries) == 1 else None
        leave_period = attendance.leave_period if attendance is not None else "none"
        person_tasks = tasks_by_person[person.person_id]
        task_periods = {item.time_period for item in person_tasks}
        source_record_id = attendance.source_record_id if attendance is not None else (min(item.source_record_id for item in attendance_entries) if attendance_entries else None)

        if len(attendance_entries) > 1:
            classifications.append(PersonClassification(person, "review_required", None, "duplicate_attendance_record", source_record_id))
        elif _attendance_conflicts(attendance, task_periods):
            classifications.append(PersonClassification(person, "review_required", None, "attendance_conflict", source_record_id))
        elif leave_period == "full_day":
            classifications.append(PersonClassification(person, "full_day_leave", "not_applicable", None, source_record_id))
        elif leave_period in {"morning", "afternoon"}:
            work_period = "afternoon" if leave_period == "morning" else "morning"
            status = "submitted" if work_period in task_periods else "missing"
            classifications.append(PersonClassification(person, "half_day_leave", status, None, source_record_id))
        elif leave_period == "unknown":
            classifications.append(PersonClassification(person, "review_required", None, "leave_period_unknown", source_record_id))
        elif person.person_id not in submitted_people or not person_tasks:
            classifications.append(PersonClassification(person, "missing", "missing", None, source_record_id))
        else:
            classifications.append(PersonClassification(person, "normal", "submitted", None, source_record_id))
    return tuple(classifications)


def _attendance_conflicts(attendance: object, task_periods: set[str]) -> bool:
    if attendance is None:
        return False
    leave_period = attendance.leave_period  # type: ignore[attr-defined]
    if leave_period == "full_day":
        return bool(task_periods)
    return leave_period in task_periods


def calculate_daily_metrics(package: DataPackage, report_date: date) -> DailyMetrics:
    classifications = classify_people(package, report_date)
    state_counts = {state: sum(item.state == state for item in classifications) for state in ("missing", "full_day_leave", "half_day_leave", "review_required")}
    submitted_people = sum(
        item.state == "normal" or (item.state == "half_day_leave" and item.work_period_status == "submitted")
        for item in classifications
    )
    missing_people = state_counts["missing"] + sum(
        item.state == "half_day_leave" and item.work_period_status == "missing" for item in classifications
    )
    ambiguous = state_counts["review_required"] > 0
    expected_people = None if ambiguous else len(classifications) - state_counts["full_day_leave"]
    submission_rate = None if expected_people is None or expected_people == 0 else submitted_people / expected_people
    tasks = deduplicated_tasks(package, report_date)
    return DailyMetrics(
        roster_people=len(classifications), expected_people=expected_people,
        submitted_people=submitted_people, submission_rate=submission_rate,
        missing_people=missing_people, full_day_leave_people=state_counts["full_day_leave"],
        half_day_leave_people=state_counts["half_day_leave"], review_required_people=state_counts["review_required"],
        effective_task_count=len(tasks),
        risk_or_blocked_count=sum(item.status == "blocked" or item.risk is not None or item.blocker is not None for item in tasks),
    )


def calculate_submission_dashboard(package: DataPackage, report_date: date) -> SubmissionDashboard:
    """Prefer stored cutoff snapshots; derive counts only when snapshots are absent."""
    day = report_date.isoformat()
    snapshots = [item for item in package.statistics if item.snapshot_date == day]
    progress = next((item for item in snapshots if "1730" in item.snapshot_type.upper()
                     or "PROGRESS" in item.snapshot_type.upper()), None)
    final = next((item for item in snapshots if "2200" in item.snapshot_type.upper()
                  or "FINAL" in item.snapshot_type.upper()), None)
    metrics = calculate_daily_metrics(package, report_date)
    snapshots_are_consistent = (
        progress is not None
        and final is not None
        and metrics.expected_people is not None
        and progress.expected_count == metrics.expected_people
        and final.expected_count == metrics.expected_people
        and _snapshot_counts_are_valid(progress.expected_count, progress.submitted_count, progress.submission_rate)
        and _snapshot_counts_are_valid(final.expected_count, final.submitted_count, final.submission_rate)
    )
    if snapshots_are_consistent:
        assert progress is not None and final is not None
        return SubmissionDashboard(
            final.expected_count, progress.submitted_count, progress.submission_rate,
            final.submitted_count, final.submission_rate, "stored_statistics",
        )

    classifications = classify_people(package, report_date)
    eligible_person_ids = {
        item.person.person_id for item in classifications
        if item.state not in {"full_day_leave", "review_required"}
    }
    first_by_person: dict[str, datetime] = {}
    for report in package.reports:
        if report.date != day or report.person_id not in eligible_person_ids or report.submission_status != "submitted":
            continue
        timestamp = report.first_submitted_at or report.final_submitted_at
        if timestamp is None:
            continue
        submitted_at = datetime.fromisoformat(timestamp.replace("Z", "+00:00"))
        previous = first_by_person.get(report.person_id)
        if previous is None or submitted_at < previous:
            first_by_person[report.person_id] = submitted_at
    timezone = next(iter(first_by_person.values())).tzinfo if first_by_person else None
    cutoff_1730 = datetime.combine(report_date, time(17, 30), tzinfo=timezone)
    cutoff_2200 = datetime.combine(report_date, time(22, 0), tzinfo=timezone)
    by_1730 = sum(value <= cutoff_1730 for value in first_by_person.values())
    by_2200 = sum(value <= cutoff_2200 for value in first_by_person.values())
    expected = metrics.expected_people
    calculation_source = (
        "recalculated_inconsistent_snapshot"
        if progress is not None or final is not None
        else "recalculated"
    )
    return SubmissionDashboard(
        expected, by_1730, None if not expected else by_1730 / expected,
        by_2200, None if not expected else by_2200 / expected, calculation_source,
    )


def _snapshot_counts_are_valid(expected: int, submitted: int, rate: float) -> bool:
    if expected < 0 or submitted < 0 or submitted > expected:
        return False
    calculated_rate = 0.0 if expected == 0 else submitted / expected
    return 0.0 <= rate <= 1.0 and abs(rate - calculated_rate) < 0.000001
