from __future__ import annotations

import hashlib
import json
import sys
import tempfile
import unittest
import warnings
import zipfile
from copy import deepcopy
from pathlib import Path


SKILL_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(SKILL_ROOT / "scripts"))

from package_contract import validate_package


REQUIRED_FILES = (
    "manifest.json", "roster.json", "attendance.json", "reports.json",
    "tasks.json", "task-relations.json", "projects.json", "source-snapshot.json",
)
V11_FILES = ("statistics.json", "project-status.json", "workdays.json")


def canonical_json(value: object) -> bytes:
    return json.dumps(value, ensure_ascii=False, separators=(",", ":"), sort_keys=True).encode("utf-8")


def refresh_hashes(documents: dict[str, object]) -> None:
    documents["manifest.json"]["file_sha256"] = {
        name: hashlib.sha256(canonical_json(documents[name])).hexdigest()
        for name in documents
        if name != "manifest.json"
    }


def valid_documents() -> dict[str, object]:
    documents: dict[str, object] = {
        "roster.json": [{"person_id": "person-001", "name": "王达伟", "group": "行一部", "personnel_type": "employee", "effective_start_date": "2026-07-31", "effective_end_date": None, "include_in_statistics": True}],
        "attendance.json": [{"person_id": "person-001", "date": "2026-07-31", "morning_status": "working", "afternoon_status": "working", "leave_type": None, "leave_period": "none", "source_record_id": "source-001"}],
        "reports.json": [{"report_id": "report-001", "person_id": "person-001", "date": "2026-07-31", "submission_status": "submitted", "first_submitted_at": "2026-07-31T09:00:00+08:00", "final_submitted_at": "2026-07-31T18:00:00+08:00", "raw_text": "完成客户方案梳理。", "snapshot_id": "snapshot-001"}],
        "tasks.json": [{"task_id": "task-001", "report_id": "report-001", "date": "2026-07-31", "time_period": "morning", "raw_text": "完成客户方案梳理。", "task_type": "project", "project_candidate_id": "project-001", "status": "completed", "output": "方案提纲", "risk": None, "blocker": None, "next_step": "客户确认"}],
        "task-relations.json": [{"relation_id": "relation-001", "task_id": "task-001", "parent_task_id": None, "related_task_id": None, "relation_type": "lead", "person_id": "person-001", "role": "lead", "evidence_id": "snapshot-001"}],
        "projects.json": [{"project_id": "project-001", "standard_name": "客户方案项目", "candidate_names": ["客户方案"], "merge_status": "unmerged", "manual_confirmation_status": "pending"}],
        "source-snapshot.json": [{"snapshot_id": "snapshot-001", "source_system": "test-system", "source_record_id": "source-001", "raw_record": "测试原始记录", "evidence_quality": "source-record-id"}],
    }
    documents["manifest.json"] = {
        "data_contract_version": "1.0.0", "package_id": "package-001", "department_id": "dept-001", "department_name": "行一部", "period_type": "daily", "start_date": "2026-07-31", "end_date": "2026-07-31", "working_dates": ["2026-07-31"], "timezone": "Asia/Shanghai", "generated_at": "2026-07-31T20:00:00+08:00", "file_sha256": {},
    }
    refresh_hashes(documents)
    return documents


def valid_v11_documents() -> dict[str, object]:
    documents = valid_documents()
    documents["statistics.json"] = [{
        "snapshot_type": "PROGRESS_1730", "snapshot_date": "2026-07-31",
        "captured_at": "2026-07-31T17:30:00+08:00", "expected_count": 1,
        "submitted_count": 1, "missing_count": 0, "submission_rate": 1.0,
        "submitted_people": [{"employeeId": 1, "name": "王达伟", "teamName": "行一部",
                              "submittedAt": "2026-07-31T09:00:00+08:00"}],
        "missing_people": [], "late_submitted_people": [], "team_statistics": [],
    }]
    documents["project-status.json"] = [{
        "project_id": "project-001", "project_name": "客户方案项目",
        "snapshot_date": "2026-07-31", "snapshot_captured_at": "2026-08-14T10:00:00+08:00",
        "snapshot_origin": "reconstructed", "state": "PRESALES_IN_PROGRESS",
        "lifecycle": "presales", "current_stage": "solution-design",
        "state_started_date": "2026-07-24", "owner_name": "王经理",
        "participant_count": 1, "blocked_task_count": 0, "latest_report_date": "2026-07-24",
        "formal": True, "active": True, "source_status": "active", "priority": "high",
    }]
    documents["workdays.json"] = [
        {"date": "2026-07-24", "workday": True, "source": "DEFAULT", "note": None},
        {"date": "2026-07-31", "workday": True, "source": "DEFAULT", "note": None},
    ]
    documents["manifest.json"].update({
        "data_contract_version": "1.1.0", "stale_project_threshold_workdays": 3,
    })
    refresh_hashes(documents)
    return documents


def write_zip(path: Path, documents: dict[str, object], extra_members: list[tuple[str, bytes]] = ()) -> None:
    with zipfile.ZipFile(path, "w", compression=zipfile.ZIP_DEFLATED) as archive:
        for name in documents:
            info = zipfile.ZipInfo(name, date_time=(1980, 1, 1, 0, 0, 0))
            info.compress_type = zipfile.ZIP_DEFLATED
            archive.writestr(info, canonical_json(documents[name]))
        for name, content in extra_members:
            info = zipfile.ZipInfo(name, date_time=(1980, 1, 1, 0, 0, 0))
            info.compress_type = zipfile.ZIP_DEFLATED
            archive.writestr(info, content)


class ValidateDataPackageTests(unittest.TestCase):
    def setUp(self) -> None:
        self.tempdir = tempfile.TemporaryDirectory()
        self.fixtures = Path(self.tempdir.name)

    def tearDown(self) -> None:
        self.tempdir.cleanup()

    def package_path(self, name: str) -> Path:
        return self.fixtures / name

    def write(self, name: str, documents: dict[str, object], extra_members: list[tuple[str, bytes]] = ()) -> Path:
        path = self.package_path(name)
        write_zip(path, documents, extra_members)
        return path

    def test_valid_package_passes(self):
        result = validate_package(self.write("daily-data-package.zip", valid_documents()))
        self.assertTrue(result.ok)
        self.assertEqual(result.package.manifest.data_contract_version, "1.0.0")
        self.assertEqual((), result.package.statistics)
        self.assertEqual((), result.package.project_statuses)
        self.assertEqual((), result.package.workdays)

    def test_version_1_1_loads_statistics_project_status_and_workdays(self):
        result = validate_package(self.write("daily-data-package-v1.1.zip", valid_v11_documents()))

        self.assertTrue(result.ok, result.errors)
        self.assertEqual("1.1.0", result.package.manifest.data_contract_version)
        self.assertEqual(3, result.package.manifest.stale_project_threshold_workdays)
        self.assertEqual("PROGRESS_1730", result.package.statistics[0].snapshot_type)
        self.assertEqual("reconstructed", result.package.project_statuses[0].snapshot_origin)
        self.assertEqual("2026-07-24", result.package.project_statuses[0].latest_report_date)
        self.assertTrue(result.package.workdays[0].workday)

    def test_version_1_1_requires_new_files_and_hashes(self):
        documents = valid_v11_documents()
        documents.pop("workdays.json")
        documents["manifest.json"]["file_sha256"].pop("workdays.json")
        result = validate_package(self.write("missing-v1.1-file.zip", documents))
        self.assertIn("MISSING_REQUIRED_FILE", result.error_codes)

        documents = valid_v11_documents()
        documents["manifest.json"]["file_sha256"]["project-status.json"] = "0" * 64
        result = validate_package(self.write("bad-v1.1-hash.zip", documents))
        self.assertIn("HASH_MISMATCH", result.error_codes)

    def test_unknown_major_version_is_blocking(self):
        documents = valid_documents()
        documents["manifest.json"]["data_contract_version"] = "2.0.0"
        result = validate_package(self.write("unknown-major.zip", documents))
        self.assertIn("UNSUPPORTED_CONTRACT_MAJOR", result.error_codes)

    def test_path_traversal_is_blocking(self):
        result = validate_package(self.write("path-traversal.zip", valid_documents(), [("../outside.json", b"{}")] ))
        self.assertIn("UNSAFE_ZIP_PATH", result.error_codes)

    def test_duplicate_id_broken_foreign_key_and_hash_are_blocking(self):
        documents = valid_documents()
        documents["roster.json"].append(deepcopy(documents["roster.json"][0]))
        documents["tasks.json"][0]["report_id"] = "missing-report"
        documents["manifest.json"]["file_sha256"]["reports.json"] = "0" * 64
        result = validate_package(self.write("integrity-errors.zip", documents))
        self.assertTrue({"DUPLICATE_ID", "BROKEN_REFERENCE", "HASH_MISMATCH"} <= set(result.error_codes))

    def test_absolute_zip_path_is_blocking(self):
        result = validate_package(self.write("absolute-path.zip", valid_documents(), [("C:/outside.json", b"{}")] ))
        self.assertIn("UNSAFE_ZIP_PATH", result.error_codes)

    def test_duplicate_zip_member_is_blocking(self):
        with warnings.catch_warnings():
            warnings.simplefilter("ignore", UserWarning)
            result = validate_package(self.write("duplicate-member.zip", valid_documents(), [("roster.json", b"[]")] ))
        self.assertIn("DUPLICATE_ZIP_MEMBER", result.error_codes)

    def test_source_snapshot_schema_is_enforced(self):
        documents = valid_documents()
        documents["source-snapshot.json"][0]["untrusted_field"] = True
        refresh_hashes(documents)
        result = validate_package(self.write("bad-snapshot-schema.zip", documents))
        self.assertIn("SCHEMA_INVALID", result.error_codes)

    def test_manifest_date_range_and_working_dates_are_blocking_even_when_business_arrays_are_empty(self):
        documents = valid_documents()
        documents["manifest.json"]["start_date"] = "2026-08-01"
        documents["manifest.json"]["end_date"] = "2026-07-31"
        documents["manifest.json"]["working_dates"] = ["2026-07-30"]
        for name in REQUIRED_FILES:
            if name not in {"manifest.json", "source-snapshot.json"}:
                documents[name] = []
        documents["source-snapshot.json"] = []
        refresh_hashes(documents)
        result = validate_package(self.write("invalid-period.zip", documents))
        self.assertTrue({"INVALID_DATE_RANGE", "INVALID_WORKING_DATES"} <= set(result.error_codes))

    def test_working_dates_must_be_unique_and_sorted(self):
        documents = valid_documents()
        documents["manifest.json"]["start_date"] = "2026-07-30"
        documents["manifest.json"]["working_dates"] = ["2026-07-31", "2026-07-30", "2026-07-30"]
        refresh_hashes(documents)
        result = validate_package(self.write("unsorted-working-days.zip", documents))
        self.assertIn("INVALID_WORKING_DATES", result.error_codes)

    def test_morning_leave_with_morning_task_is_blocking(self):
        documents = valid_documents()
        documents["attendance.json"][0].update({"morning_status": "leave", "leave_type": "annual", "leave_period": "morning"})
        refresh_hashes(documents)
        result = validate_package(self.write("morning-conflict.zip", documents))
        self.assertIn("PERSON_STATUS_CONFLICT", result.error_codes)

    def test_afternoon_leave_with_afternoon_task_is_blocking(self):
        documents = valid_documents()
        documents["attendance.json"][0].update({"afternoon_status": "leave", "leave_type": "annual", "leave_period": "afternoon"})
        documents["tasks.json"][0]["time_period"] = "afternoon"
        refresh_hashes(documents)
        result = validate_package(self.write("afternoon-conflict.zip", documents))
        self.assertIn("PERSON_STATUS_CONFLICT", result.error_codes)

    def test_task_date_outside_working_dates_is_blocking(self):
        documents = valid_documents()
        documents["tasks.json"][0]["date"] = "2026-08-01"
        refresh_hashes(documents)
        result = validate_package(self.write("task-date.zip", documents))
        self.assertIn("DATE_OUT_OF_RANGE", result.error_codes)

    def test_duplicate_attendance_for_person_and_date_is_blocking(self):
        documents = valid_documents()
        duplicate = deepcopy(documents["attendance.json"][0])
        duplicate["source_record_id"] = "source-002"
        documents["attendance.json"].append(duplicate)
        refresh_hashes(documents)

        result = validate_package(self.write("duplicate-attendance.zip", documents))
        reversed_documents = deepcopy(documents)
        reversed_documents["attendance.json"].reverse()
        refresh_hashes(reversed_documents)
        reversed_result = validate_package(self.write("duplicate-attendance-reversed.zip", reversed_documents))

        self.assertIn("DUPLICATE_ATTENDANCE_RECORD", result.error_codes)
        self.assertEqual(result.error_codes, reversed_result.error_codes)

    def test_conflicting_relation_participation_is_blocking(self):
        documents = valid_documents()
        documents["source-snapshot.json"].append({
            "snapshot_id": "snapshot-002", "source_system": "test-system", "source_record_id": "source-002",
            "raw_record": "second relation evidence", "evidence_quality": "source-record-id",
        })
        duplicate = deepcopy(documents["task-relations.json"][0])
        duplicate.update({"relation_id": "relation-002", "evidence_id": "snapshot-002"})
        documents["task-relations.json"].append(duplicate)
        refresh_hashes(documents)

        result = validate_package(self.write("conflicting-relation.zip", documents))
        reversed_documents = deepcopy(documents)
        reversed_documents["task-relations.json"].reverse()
        refresh_hashes(reversed_documents)
        reversed_result = validate_package(self.write("conflicting-relation-reversed.zip", reversed_documents))

        self.assertIn("CONFLICTING_RELATION_PARTICIPATION", result.error_codes)
        self.assertEqual(result.error_codes, reversed_result.error_codes)


if __name__ == "__main__":
    unittest.main()
