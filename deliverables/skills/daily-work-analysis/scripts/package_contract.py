"""Trusted contract loader for daily-work-analysis data packages."""

from __future__ import annotations

import hashlib
import json
import zipfile
from dataclasses import dataclass
from datetime import date
from pathlib import Path, PurePosixPath
from typing import Any

from jsonschema import Draft202012Validator, FormatChecker


SUPPORTED_CONTRACT_MAJOR = 1
BASE_REQUIRED_FILES = (
    "manifest.json", "roster.json", "attendance.json", "reports.json",
    "tasks.json", "task-relations.json", "projects.json", "source-snapshot.json",
)
V11_REQUIRED_FILES = ("statistics.json", "project-status.json", "workdays.json")
KNOWN_FILES = BASE_REQUIRED_FILES + V11_REQUIRED_FILES

_SCHEMA_FILES = {
    "manifest.json": "manifest.schema.json",
    "roster.json": "roster.schema.json",
    "attendance.json": "attendance.schema.json",
    "reports.json": "reports.schema.json",
    "tasks.json": "tasks.schema.json",
    "task-relations.json": "task-relations.schema.json",
    "projects.json": "projects.schema.json",
    "source-snapshot.json": "source-snapshot.schema.json",
    "statistics.json": "statistics.schema.json",
    "project-status.json": "project-status.schema.json",
    "workdays.json": "workdays.schema.json",
}
_SCHEMAS_DIR = Path(__file__).resolve().parents[1] / "schemas"


@dataclass(frozen=True, slots=True)
class ValidationIssue:
    code: str
    path: str
    message: str


@dataclass(frozen=True, slots=True)
class ValidationResult:
    package: DataPackage | None
    errors: tuple[ValidationIssue, ...]
    warnings: tuple[ValidationIssue, ...]

    @property
    def ok(self) -> bool:
        return not self.errors

    @property
    def error_codes(self) -> tuple[str, ...]:
        return tuple(issue.code for issue in self.errors)


@dataclass(frozen=True, slots=True)
class PackageManifest:
    data_contract_version: str
    package_id: str
    department_id: str
    department_name: str
    period_type: str
    start_date: str
    end_date: str
    working_dates: tuple[str, ...]
    timezone: str
    generated_at: str
    file_sha256: tuple[tuple[str, str], ...]
    stale_project_threshold_workdays: int = 3
    report_date: str | None = None


@dataclass(frozen=True, slots=True)
class RosterEntry:
    person_id: str
    name: str
    group: str
    personnel_type: str
    effective_start_date: str
    effective_end_date: str | None
    include_in_statistics: bool


@dataclass(frozen=True, slots=True)
class AttendanceEntry:
    person_id: str
    date: str
    morning_status: str
    afternoon_status: str
    leave_type: str | None
    leave_period: str
    source_record_id: str


@dataclass(frozen=True, slots=True)
class ReportEntry:
    report_id: str
    person_id: str
    date: str
    submission_status: str
    first_submitted_at: str | None
    final_submitted_at: str | None
    raw_text: str
    snapshot_id: str


@dataclass(frozen=True, slots=True)
class TaskEntry:
    task_id: str
    report_id: str
    date: str
    time_period: str
    raw_text: str
    task_type: str
    project_candidate_id: str | None
    status: str
    output: str | None
    risk: str | None
    blocker: str | None
    next_step: str | None


@dataclass(frozen=True, slots=True)
class TaskRelation:
    relation_id: str
    task_id: str
    parent_task_id: str | None
    related_task_id: str | None
    relation_type: str
    person_id: str
    role: str
    evidence_id: str


@dataclass(frozen=True, slots=True)
class ProjectEntry:
    project_id: str
    standard_name: str | None
    candidate_names: tuple[str, ...]
    merge_status: str
    manual_confirmation_status: str
    formal: bool = False
    active: bool = True
    source_status: str | None = None
    priority: str | None = None
    state: str | None = None
    lifecycle: str | None = None
    current_stage: str | None = None
    state_started_date: str | None = None
    owner_name: str | None = None
    participant_count: int = 0
    blocked_task_count: int = 0
    latest_report_date: str | None = None


@dataclass(frozen=True, slots=True)
class StatisticsEntry:
    snapshot_type: str
    snapshot_date: str
    captured_at: str | None
    expected_count: int
    submitted_count: int
    missing_count: int
    submission_rate: float
    submitted_people: tuple[dict[str, Any], ...]
    missing_people: tuple[dict[str, Any], ...]
    late_submitted_people: tuple[dict[str, Any], ...]
    team_statistics: tuple[dict[str, Any], ...]


@dataclass(frozen=True, slots=True)
class ProjectStatusEntry:
    project_id: str
    project_name: str
    snapshot_date: str
    snapshot_captured_at: str | None
    snapshot_origin: str
    state: str | None
    lifecycle: str | None
    current_stage: str | None
    state_started_date: str | None
    owner_name: str | None
    participant_count: int
    blocked_task_count: int
    latest_report_date: str | None
    formal: bool
    active: bool
    source_status: str | None
    priority: str | None


@dataclass(frozen=True, slots=True)
class WorkdayEntry:
    date: str
    workday: bool
    source: str | None
    note: str | None


@dataclass(frozen=True, slots=True)
class DataPackage:
    manifest: PackageManifest
    roster: tuple[RosterEntry, ...]
    attendance: tuple[AttendanceEntry, ...]
    reports: tuple[ReportEntry, ...]
    tasks: tuple[TaskEntry, ...]
    task_relations: tuple[TaskRelation, ...]
    projects: tuple[ProjectEntry, ...]
    source_snapshots: tuple[dict[str, Any], ...]
    statistics: tuple[StatisticsEntry, ...] = ()
    project_statuses: tuple[ProjectStatusEntry, ...] = ()
    workdays: tuple[WorkdayEntry, ...] = ()


def _issue(code: str, path: str, message: str) -> ValidationIssue:
    return ValidationIssue(code=code, path=path, message=message)


def _is_unsafe_member(name: str) -> bool:
    path = PurePosixPath(name.replace("\\", "/"))
    return not name or name.startswith(("/", "\\")) or path.is_absolute() or ".." in path.parts or (len(name) > 1 and name[1] == ":")


def _load_trusted_schemas() -> dict[str, Draft202012Validator]:
    validators: dict[str, Draft202012Validator] = {}
    for schema_path in sorted(_SCHEMAS_DIR.glob("*.schema.json")):
        Draft202012Validator.check_schema(json.loads(schema_path.read_text(encoding="utf-8")))
    for package_file, schema_file in _SCHEMA_FILES.items():
        schema = json.loads((_SCHEMAS_DIR / schema_file).read_text(encoding="utf-8"))
        validators[package_file] = Draft202012Validator(schema, format_checker=FormatChecker())
    return validators


def _read_zip(path: Path) -> tuple[dict[str, bytes], list[ValidationIssue]]:
    errors: list[ValidationIssue] = []
    try:
        with zipfile.ZipFile(path) as archive:
            names = archive.namelist()
            seen: set[str] = set()
            for name in names:
                if _is_unsafe_member(name):
                    errors.append(_issue("UNSAFE_ZIP_PATH", name, "ZIP member path is not safe"))
                if name in seen:
                    errors.append(_issue("DUPLICATE_ZIP_MEMBER", name, "ZIP contains a duplicate member"))
                seen.add(name)
            if errors:
                return {}, errors
            for name in BASE_REQUIRED_FILES:
                if name not in seen:
                    errors.append(_issue("MISSING_REQUIRED_FILE", name, "Required package file is missing"))
            for name in seen:
                if name not in KNOWN_FILES:
                    errors.append(_issue("UNEXPECTED_PACKAGE_FILE", name, "Package may not provide extra files"))
            if errors:
                return {}, errors
            return {name: archive.read(name) for name in seen}, errors
    except (FileNotFoundError, zipfile.BadZipFile, OSError) as exc:
        return {}, [_issue("INVALID_ZIP", str(path), str(exc))]


def _decode_documents(raw_documents: dict[str, bytes]) -> tuple[dict[str, Any], list[ValidationIssue]]:
    documents: dict[str, Any] = {}
    errors: list[ValidationIssue] = []
    for name in raw_documents:
        try:
            documents[name] = json.loads(raw_documents[name].decode("utf-8"))
        except (UnicodeDecodeError, json.JSONDecodeError) as exc:
            errors.append(_issue("JSON_DECODE_ERROR", name, str(exc)))
    return documents, errors


def _validate_schema(documents: dict[str, Any]) -> list[ValidationIssue]:
    errors: list[ValidationIssue] = []
    for name, validator in _load_trusted_schemas().items():
        if name not in documents:
            continue
        for error in sorted(validator.iter_errors(documents[name]), key=lambda item: list(item.absolute_path)):
            location = "/".join(str(part) for part in error.absolute_path)
            errors.append(_issue("SCHEMA_INVALID", f"{name}/{location}".rstrip("/"), error.message))
    return errors


def _validate_hashes(documents: dict[str, Any], raw_documents: dict[str, bytes]) -> list[ValidationIssue]:
    errors: list[ValidationIssue] = []
    expected = documents["manifest.json"]["file_sha256"]
    for name in raw_documents:
        if name == "manifest.json":
            continue  # A manifest cannot hash its own final bytes without recursion.
        actual = hashlib.sha256(raw_documents[name]).hexdigest()
        if expected.get(name) != actual:
            errors.append(_issue("HASH_MISMATCH", name, "SHA-256 does not match manifest"))
    return errors


def _unique_ids(documents: dict[str, Any]) -> list[ValidationIssue]:
    errors: list[ValidationIssue] = []
    for filename, key in (("roster.json", "person_id"), ("reports.json", "report_id"), ("tasks.json", "task_id"), ("task-relations.json", "relation_id"), ("projects.json", "project_id"), ("source-snapshot.json", "snapshot_id")):
        seen: set[str] = set()
        for index, entry in enumerate(documents[filename]):
            identifier = entry.get(key)
            if identifier in seen:
                errors.append(_issue("DUPLICATE_ID", f"{filename}/{index}/{key}", f"Duplicate {key}: {identifier}"))
            seen.add(identifier)
    attendance_keys: set[tuple[str, str]] = set()
    for index, entry in enumerate(documents["attendance.json"]):
        key = (entry["person_id"], entry["date"])
        if key in attendance_keys:
            errors.append(_issue("DUPLICATE_ATTENDANCE_RECORD", f"attendance.json/{index}", "Duplicate attendance record for person and date"))
        attendance_keys.add(key)
    relation_keys: set[tuple[str, str, str]] = set()
    for index, entry in enumerate(documents["task-relations.json"]):
        key = (entry["task_id"], entry["person_id"], entry["role"])
        if key in relation_keys:
            errors.append(_issue("CONFLICTING_RELATION_PARTICIPATION", f"task-relations.json/{index}", "Duplicate task participation for task, person, and role"))
        relation_keys.add(key)
    for filename, fields, code in (
        ("statistics.json", ("snapshot_type", "snapshot_date"), "DUPLICATE_STATISTICS_SNAPSHOT"),
        ("project-status.json", ("project_id", "snapshot_date"), "DUPLICATE_PROJECT_STATUS"),
        ("workdays.json", ("date",), "DUPLICATE_WORKDAY"),
    ):
        seen_optional: set[tuple[Any, ...]] = set()
        for index, entry in enumerate(documents.get(filename, [])):
            key = tuple(entry[field] for field in fields)
            if key in seen_optional:
                errors.append(_issue(code, f"{filename}/{index}", f"Duplicate record key: {key}"))
            seen_optional.add(key)
    return errors


def _foreign_keys(documents: dict[str, Any]) -> list[ValidationIssue]:
    errors: list[ValidationIssue] = []
    ids = {
        "person": {item["person_id"] for item in documents["roster.json"]},
        "report": {item["report_id"] for item in documents["reports.json"]},
        "task": {item["task_id"] for item in documents["tasks.json"]},
        "project": {item["project_id"] for item in documents["projects.json"]},
        "snapshot": {item["snapshot_id"] for item in documents["source-snapshot.json"]},
    }
    references = (("attendance.json", "person_id", "person"), ("reports.json", "person_id", "person"), ("reports.json", "snapshot_id", "snapshot"), ("tasks.json", "report_id", "report"), ("tasks.json", "project_candidate_id", "project"), ("task-relations.json", "task_id", "task"), ("task-relations.json", "parent_task_id", "task"), ("task-relations.json", "related_task_id", "task"), ("task-relations.json", "person_id", "person"), ("task-relations.json", "evidence_id", "snapshot"))
    for filename, field, target in references:
        for index, entry in enumerate(documents[filename]):
            value = entry[field]
            if value is not None and value not in ids[target]:
                errors.append(_issue("BROKEN_REFERENCE", f"{filename}/{index}/{field}", f"Unknown {target} ID: {value}"))
    return errors


def _validate_dates_periods_and_status(documents: dict[str, Any]) -> list[ValidationIssue]:
    errors: list[ValidationIssue] = []
    manifest = documents["manifest.json"]
    start, end = date.fromisoformat(manifest["start_date"]), date.fromisoformat(manifest["end_date"])
    supplied_working_dates = manifest["working_dates"]
    working_dates = set(supplied_working_dates)
    if start > end:
        errors.append(_issue("INVALID_DATE_RANGE", "manifest.json/start_date", "Start date must not be after end date"))
    if (
        len(working_dates) != len(supplied_working_dates)
        or supplied_working_dates != sorted(supplied_working_dates)
        or any(not start <= date.fromisoformat(value) <= end for value in supplied_working_dates)
    ):
        errors.append(_issue("INVALID_WORKING_DATES", "manifest.json/working_dates", "Working dates must be unique, sorted, and inside the period"))
    for filename in ("attendance.json", "reports.json", "tasks.json"):
        for index, entry in enumerate(documents[filename]):
            value = date.fromisoformat(entry["date"])
            if not start <= value <= end or entry["date"] not in working_dates:
                errors.append(_issue("DATE_OUT_OF_RANGE", f"{filename}/{index}/date", "Date is outside the package working period"))
    for index, entry in enumerate(documents.get("statistics.json", [])):
        value = date.fromisoformat(entry["snapshot_date"])
        if not start <= value <= end:
            errors.append(_issue("DATE_OUT_OF_RANGE", f"statistics.json/{index}/snapshot_date", "Statistics date is outside the package period"))
    for index, entry in enumerate(documents.get("project-status.json", [])):
        if entry["snapshot_date"] != manifest["end_date"]:
            errors.append(_issue("DATE_OUT_OF_RANGE", f"project-status.json/{index}/snapshot_date", "Project status must describe the period end date"))
    previous_workday: str | None = None
    for index, entry in enumerate(documents.get("workdays.json", [])):
        if entry["date"] > manifest["end_date"] or (previous_workday is not None and entry["date"] <= previous_workday):
            errors.append(_issue("INVALID_WORKDAYS", f"workdays.json/{index}/date", "Workdays must be unique, sorted, and not after the period end"))
        previous_workday = entry["date"]
    tasks_by_report: dict[str, list[dict[str, Any]]] = {}
    for task in documents["tasks.json"]:
        tasks_by_report.setdefault(task["report_id"], []).append(task)
    for index, report in enumerate(documents["reports.json"]):
        for task in tasks_by_report.get(report["report_id"], []):
            if task["date"] != report["date"]:
                errors.append(_issue("DATE_OUT_OF_RANGE", f"reports.json/{index}", "Task date differs from its report date"))
    for index, entry in enumerate(documents["attendance.json"]):
        expected = {
            "none": ("working", "working"), "full_day": ("leave", "leave"),
            "morning": ("leave", None), "afternoon": (None, "leave"), "unknown": (None, None),
        }[entry["leave_period"]]
        morning, afternoon = expected
        if (morning is not None and entry["morning_status"] != morning) or (afternoon is not None and entry["afternoon_status"] != afternoon):
            errors.append(_issue("PERSON_STATUS_CONFLICT", f"attendance.json/{index}", "Leave period conflicts with morning or afternoon status"))
        if entry["leave_period"] == "full_day":
            report_ids = {report["report_id"] for report in documents["reports.json"] if report["person_id"] == entry["person_id"] and report["date"] == entry["date"]}
            if any(task["report_id"] in report_ids for task in documents["tasks.json"]):
                errors.append(_issue("PERSON_STATUS_CONFLICT", f"attendance.json/{index}", "Full-day leave conflicts with reported work"))
        if entry["leave_period"] in {"morning", "afternoon"}:
            report_ids = {report["report_id"] for report in documents["reports.json"] if report["person_id"] == entry["person_id"] and report["date"] == entry["date"]}
            if any(task["report_id"] in report_ids and task["time_period"] == entry["leave_period"] for task in documents["tasks.json"]):
                errors.append(_issue("PERSON_STATUS_CONFLICT", f"attendance.json/{index}", "Leave period conflicts with a task in the same period"))
    return errors


def _to_package(documents: dict[str, Any]) -> DataPackage:
    manifest = documents["manifest.json"]
    manifest_values = {**manifest, "working_dates": tuple(manifest["working_dates"]), "file_sha256": tuple(sorted(manifest["file_sha256"].items()))}
    manifest_values.setdefault("stale_project_threshold_workdays", 3)
    return DataPackage(
        manifest=PackageManifest(**manifest_values),
        roster=tuple(RosterEntry(**item) for item in documents["roster.json"]),
        attendance=tuple(AttendanceEntry(**item) for item in documents["attendance.json"]),
        reports=tuple(ReportEntry(**item) for item in documents["reports.json"]),
        tasks=tuple(TaskEntry(**item) for item in documents["tasks.json"]),
        task_relations=tuple(TaskRelation(**item) for item in documents["task-relations.json"]),
        projects=tuple(ProjectEntry(**{**item, "candidate_names": tuple(item["candidate_names"])}) for item in documents["projects.json"]),
        source_snapshots=tuple(dict(item) for item in documents["source-snapshot.json"]),
        statistics=tuple(StatisticsEntry(**{
            **item,
            "submitted_people": tuple(dict(person) for person in item["submitted_people"]),
            "missing_people": tuple(dict(person) for person in item["missing_people"]),
            "late_submitted_people": tuple(dict(person) for person in item["late_submitted_people"]),
            "team_statistics": tuple(dict(team) for team in item["team_statistics"]),
        }) for item in documents.get("statistics.json", [])),
        project_statuses=tuple(ProjectStatusEntry(**item) for item in documents.get("project-status.json", [])),
        workdays=tuple(WorkdayEntry(**item) for item in documents.get("workdays.json", [])),
    )


def validate_package(path: Path) -> ValidationResult:
    """Do not extract to disk; validate safe ZIP, schema, integrity, then business constraints."""
    raw_documents, errors = _read_zip(path)
    if errors:
        return ValidationResult(None, tuple(errors), ())
    documents, errors = _decode_documents(raw_documents)
    if errors:
        return ValidationResult(None, tuple(errors), ())
    version = documents["manifest.json"].get("data_contract_version") if isinstance(documents["manifest.json"], dict) else None
    try:
        major = int(str(version).split(".", 1)[0])
    except ValueError:
        major = -1
    if major != SUPPORTED_CONTRACT_MAJOR:
        errors.append(_issue("UNSUPPORTED_CONTRACT_MAJOR", "manifest.json/data_contract_version", f"Unsupported contract version: {version}"))
        return ValidationResult(None, tuple(errors), ())
    try:
        minor = int(str(version).split(".")[1])
    except (ValueError, IndexError):
        minor = -1
    required_files = BASE_REQUIRED_FILES + (V11_REQUIRED_FILES if minor >= 1 else ())
    for name in required_files:
        if name not in documents:
            errors.append(_issue("MISSING_REQUIRED_FILE", name, "Required package file is missing for this contract version"))
    if minor < 1:
        for name in V11_REQUIRED_FILES:
            if name in documents:
                errors.append(_issue("VERSION_FILE_MISMATCH", name, "Contract 1.0 may not provide version 1.1 files"))
    if errors:
        return ValidationResult(None, tuple(errors), ())
    errors.extend(_validate_schema(documents))
    if errors:
        return ValidationResult(None, tuple(errors), ())
    errors.extend(_validate_hashes(documents, raw_documents))
    errors.extend(_unique_ids(documents))
    errors.extend(_foreign_keys(documents))
    errors.extend(_validate_dates_periods_and_status(documents))
    return ValidationResult(_to_package(documents) if not errors else None, tuple(errors), ())


def load_package(path: Path) -> DataPackage:
    """Load a verified package or raise ValueError containing its stable error codes."""
    result = validate_package(path)
    if not result.ok:
        raise ValueError(",".join(result.error_codes))
    assert result.package is not None
    return result.package
