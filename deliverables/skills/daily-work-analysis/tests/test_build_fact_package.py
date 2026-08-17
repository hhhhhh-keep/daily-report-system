from __future__ import annotations

import json
import sys
import unittest
from copy import deepcopy
from dataclasses import replace
from datetime import date
from pathlib import Path


SKILL_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(SKILL_ROOT / "scripts"))

from build_fact_package import _validate_facts, build_daily_facts, canonical_json  # noqa: E402
from calculate_daily_metrics import calculate_daily_metrics  # noqa: E402
from test_calculate_daily_metrics import REPORT_DATE, attendance_entry, package_for, report, task  # noqa: E402
from package_contract import (  # noqa: E402
    ProjectEntry,
    ProjectStatusEntry,
    StatisticsEntry,
    TaskRelation,
    WorkdayEntry,
)


class BuildFactPackageTests(unittest.TestCase):
    def test_builds_five_workday_continuity_association_and_risk_facts(self) -> None:
        current_reports = [report("p1", "a-current"), report("p2", "a-collaborator")]
        historical_reports = [
            replace(report("p1", "a-day1"), date="2026-07-27"),
            replace(report("p1", "a-day3"), date="2026-07-29"),
            replace(report("p1", "c-day1"), date="2026-07-27"),
        ]
        current_tasks = [
            replace(task("report-a-current", "a-current"), project_candidate_id="project-a", output="完成联调"),
            replace(task("report-a-collaborator", "a-collaborator", status="in_progress"),
                    project_candidate_id="project-a", output="准备验收材料"),
            replace(task("report-a-current", "b-current", status="in_progress"),
                    project_candidate_id="project-b", output="完成需求确认"),
        ]
        historical_tasks = [
            replace(task("report-a-day1", "a-day1", status="in_progress"), date="2026-07-27",
                    project_candidate_id="project-a", output="完成需求梳理"),
            replace(task("report-a-day3", "a-day3", status="in_progress"), date="2026-07-29",
                    project_candidate_id="project-a", output="提交技术方案"),
            replace(task("report-c-day1", "c-day1", status="in_progress"), date="2026-07-27",
                    project_candidate_id="project-c", output="等待客户反馈"),
        ]
        relations = [
            TaskRelation("rel-a-current", "task-a-current", None, None, "lead", "p1", "lead", "snapshot-a-current"),
            TaskRelation("rel-a-collaborator", "task-a-collaborator", None, None, "collaborate", "p2", "collaborator", "snapshot-a-collaborator"),
            TaskRelation("rel-b-current", "task-b-current", None, None, "lead", "p1", "lead", "snapshot-a-current"),
            TaskRelation("rel-a-day1", "task-a-day1", None, None, "lead", "p1", "lead", "snapshot-a-day1"),
            TaskRelation("rel-a-day3", "task-a-day3", None, None, "lead", "p1", "lead", "snapshot-a-day3"),
            TaskRelation("rel-c-day1", "task-c-day1", None, None, "lead", "p1", "lead", "snapshot-c-day1"),
        ]
        base = package_for(
            people=[("p1", "负责人"), ("p2", "协同人")], reports=current_reports,
            tasks=current_tasks, relations=relations,
        )
        all_reports = tuple(current_reports + historical_reports)
        package = replace(
            base,
            manifest=replace(base.manifest, start_date="2026-07-27", end_date="2026-07-31",
                             working_dates=("2026-07-27", "2026-07-28", "2026-07-29", "2026-07-30", "2026-07-31")),
            reports=all_reports,
            tasks=tuple(current_tasks + historical_tasks),
            task_relations=tuple(relations),
            projects=(
                ProjectEntry("project-a", "项目A", ("项目A",), "confirmed", "confirmed"),
                ProjectEntry("project-b", "项目B", ("项目B",), "confirmed", "confirmed"),
                ProjectEntry("project-c", "项目C", ("项目C",), "confirmed", "confirmed"),
            ),
            source_snapshots=tuple({
                "snapshot_id": item.snapshot_id, "source_system": "test-system",
                "source_record_id": item.report_id, "raw_record": item.raw_text,
                "evidence_quality": "source-record-id",
            } for item in all_reports),
        )

        facts = build_daily_facts(package, REPORT_DATE)

        self.assertEqual(facts["period"]["report_date"], "2026-07-31")
        self.assertEqual(facts["period"]["start_date"], "2026-07-27")
        project_a = next(item for item in facts["project_continuity"] if item["project_id"] == "project-a")
        self.assertEqual(project_a["active_dates"], ["2026-07-27", "2026-07-29", "2026-07-31"])
        self.assertEqual(project_a["classification"], "continuing")
        self.assertIn("same_project_multi_person", {item["association_type"] for item in facts["project_associations"]})
        self.assertIn("one_person_multi_project", {item["association_type"] for item in facts["project_associations"]})
        self.assertIn("information_discontinuity", {item["risk_type"] for item in facts["risk_assessment"]})

    def test_facts_are_stable_sorted_and_schema_valid(self) -> None:
        package = package_for(
            people=[("p2", "王达伟"), ("p1", "吴鹏"), ("p3", "周菁"), ("p4", "陈苏"), ("p5", "刘茜"), ("p6", "王海娜")],
            attendance=[
                attendance_entry("p3", "full_day"), attendance_entry("p4", "morning"),
                attendance_entry("p5", "afternoon"), attendance_entry("p6", "unknown"),
            ],
            reports=[report("p4", "4")],
            tasks=[task("report-4", "2", "afternoon", risk="late"), task("report-4", "1", "afternoon")],
            relations=[
                TaskRelation("relation-b", "task-2", None, None, "collaborate", "p4", "collaborator", "snapshot-4"),
                TaskRelation("relation-a", "task-2", None, None, "collaborate", "p4", "collaborator", "snapshot-4"),
            ],
        )

        facts_a = build_daily_facts(package, REPORT_DATE)
        facts_b = build_daily_facts(package, REPORT_DATE)

        self.assertEqual(facts_a, facts_b)
        self.assertEqual(canonical_json(facts_a), canonical_json(facts_b))
        self.assertNotIn("generated_at", canonical_json(facts_a).decode("utf-8"))
        self.assertEqual([item["person_id"] for item in facts_a["missing_people"]], ["p1", "p2"])
        self.assertEqual({item["name"] for item in facts_a["missing_people"]}, {"王达伟", "吴鹏"})
        self.assertEqual({item["name"] for item in facts_a["full_day_leave_people"]}, {"周菁"})
        self.assertEqual({item["name"] for item in facts_a["half_day_leave_people"]}, {"陈苏", "刘茜"})
        self.assertEqual({item["name"] for item in facts_a["review_required_people"]}, {"王海娜"})
        classified = [item["person_id"] for key in ("missing_people", "full_day_leave_people", "half_day_leave_people", "review_required_people") for item in facts_a[key]]
        self.assertEqual(len(classified), len(set(classified)))
        self.assertEqual(len({x["person_id"] for x in facts_a["missing_people"]}), len(facts_a["missing_people"]))
        self.assertEqual([item["task_id"] for item in facts_a["work_composition"]], ["task-1", "task-2"])
        self.assertEqual(len(facts_a["collaborations"]), 1)
        self.assertEqual(facts_a["metrics"]["expected_people"], None)
        json.loads(canonical_json(facts_a))

    def test_half_day_missing_is_kept_out_of_full_day_missing_list(self) -> None:
        package = package_for(
            people=[("p1", "half-missing")], attendance=[attendance_entry("p1", "morning")],
        )

        facts = build_daily_facts(package, REPORT_DATE)

        self.assertEqual(facts["missing_people"], [])
        self.assertEqual(facts["half_day_leave_people"][0]["work_period_status"], "missing")
        self.assertEqual(calculate_daily_metrics(package, REPORT_DATE).missing_people, 1)

    def test_schema_rejects_invalid_nested_objects(self) -> None:
        package = package_for(people=[("p1", "worker")], reports=[report("p1", "1")], tasks=[task("report-1", "1")])
        valid = build_daily_facts(package, REPORT_DATE)
        invalid_cases = {
            "metrics missing field": lambda value: value["metrics"].pop("roster_people"),
            "person missing field": lambda value: value["missing_people"].append({"name": "missing-id"}),
            "work composition extra field": lambda value: value["work_composition"][0].update({"unexpected": True}),
            "status distribution wrong type": lambda value: value["status_distribution"].update({"completed": "one"}),
            "project candidate missing field": lambda value: value["project_candidates"].append({}),
            "collaboration missing field": lambda value: value["collaborations"].append({}),
            "risk candidate missing field": lambda value: value["risk_candidates"].append({}),
            "evidence extra field": lambda value: value["evidence"][0].update({"unexpected": True}),
        }

        for label, mutate in invalid_cases.items():
            with self.subTest(label=label):
                invalid = deepcopy(valid)
                mutate(invalid)
                with self.assertRaises(ValueError):
                    _validate_facts(invalid)

    def test_unrelated_cross_day_evidence_does_not_change_facts(self) -> None:
        package = package_for(people=[("p1", "worker")], reports=[report("p1", "1")], tasks=[task("report-1", "1")])
        later_report = replace(report("p1", "later"), date="2026-08-01", snapshot_id="snapshot-next-day")
        with_unrelated_snapshot = replace(package, source_snapshots=package.source_snapshots + ({
            "snapshot_id": "snapshot-next-day", "source_system": "test-system",
            "source_record_id": "next-day", "raw_record": "later evidence",
            "evidence_quality": "source-record-id",
        },), reports=package.reports + (later_report,))

        baseline = build_daily_facts(package, REPORT_DATE)
        facts = build_daily_facts(with_unrelated_snapshot, REPORT_DATE)

        self.assertEqual(canonical_json(facts), canonical_json(baseline))
        self.assertEqual([item["evidence_id"] for item in facts["evidence"]], ["snapshot-1"])

    def test_builds_leader_attendance_efficiency_and_project_sections(self) -> None:
        base = package_for(
            people=[("p1", "负责人"), ("p2", "协同人"), ("p3", "未填人员")],
            reports=[replace(report("p1", "1"), first_submitted_at="2026-07-31T17:20:00+08:00"),
                     replace(report("p2", "2"), first_submitted_at="2026-07-31T18:10:00+08:00")],
            tasks=[replace(task("report-1", "1"), project_candidate_id="project-31", output="完成方案"),
                   replace(task("report-2", "2", status="in_progress"), project_candidate_id="project-31")],
            relations=[TaskRelation("rel-1", "task-1", None, None, "lead", "p1", "lead", "snapshot-1"),
                       TaskRelation("rel-2", "task-2", None, None, "collaborate", "p2", "collaborator", "snapshot-2")],
        )
        package = replace(
            base,
            projects=(ProjectEntry("project-31", "正式项目A", ("正式项目A",), "confirmed", "confirmed"),),
            statistics=(
                StatisticsEntry("PROGRESS_1730", "2026-07-31", "2026-07-31T17:30:00+08:00", 3, 1, 2,
                                1 / 3, (), (), (), ()),
                StatisticsEntry("FINAL", "2026-07-31", "2026-07-31T22:00:00+08:00", 3, 2, 1,
                                2 / 3, (), (), (), ()),
            ),
            project_statuses=(ProjectStatusEntry(
                "project-31", "正式项目A", "2026-07-31", "2026-07-31T22:00:00+08:00", "captured",
                "DELIVERY_IN_PROGRESS", "delivery", "implementation", "2026-07-20", "负责人", 2, 0,
                "2026-07-31", True, True, "active", "high"),),
            workdays=tuple(WorkdayEntry(day, True, "DEFAULT", None) for day in
                           ("2026-07-24", "2026-07-28", "2026-07-29", "2026-07-30", "2026-07-31")),
        )

        facts = build_daily_facts(package, REPORT_DATE)

        self.assertEqual(facts["attendance_summary"]["expected_people"], 3)
        self.assertEqual(facts["attendance_summary"]["submitted_by_1730_people"], 1)
        self.assertEqual(facts["attendance_summary"]["submitted_by_2200_people"], 2)
        self.assertEqual([item["name"] for item in facts["attendance_summary"]["missing_people"]], ["未填人员"])
        self.assertEqual(facts["efficiency_summary"][0]["name"], "负责人")
        self.assertEqual(facts["efficiency_summary"][0]["task_count"], 1)
        self.assertEqual(facts["formal_project_dynamics"][0]["project_name"], "正式项目A")
        self.assertEqual(facts["formal_project_dynamics"][0]["lead_people"], ["负责人"])
        self.assertEqual(facts["formal_project_dynamics"][0]["collaborator_people"], ["协同人"])

    def test_stale_project_alert_requires_more_than_threshold_workdays(self) -> None:
        base = package_for(people=[])
        statuses = (
            ProjectStatusEntry("p-stale", "超期项目", "2026-07-31", None, "captured", "DELIVERY_IN_PROGRESS",
                               "delivery", "implementation", None, "甲", 1, 0, "2026-07-24", True, True,
                               "active", "high"),
            ProjectStatusEntry("p-ok", "未超期项目", "2026-07-31", None, "captured", "PRESALES_IN_PROGRESS",
                               "presales", "proposal", None, "乙", 1, 0, "2026-07-28", True, True,
                               "active", "medium"),
        )
        package = replace(base, project_statuses=statuses,
                          workdays=tuple(WorkdayEntry(day, True, "DEFAULT", None) for day in
                                         ("2026-07-24", "2026-07-28", "2026-07-29", "2026-07-30", "2026-07-31")))

        facts = build_daily_facts(package, REPORT_DATE)

        self.assertEqual([(item["project_name"], item["inactive_workdays"]) for item in facts["stale_project_alerts"]],
                         [("超期项目", 5)])

    def test_stale_project_uses_weekdays_and_calendar_overrides(self) -> None:
        base = package_for(people=[])
        status = ProjectStatusEntry(
            "p-calendar", "日历项目", "2026-07-31", None, "captured", "DELIVERY_IN_PROGRESS",
            "delivery", "implementation", None, "甲", 1, 0, "2026-07-27", True, True,
            "active", "high",
        )
        package = replace(base, project_statuses=(status,), workdays=(
            WorkdayEntry("2026-07-28", False, "HOLIDAY", "调休"),
            WorkdayEntry("2026-07-31", True, "DEFAULT", None),
        ))

        facts = build_daily_facts(package, REPORT_DATE)

        self.assertEqual(facts["stale_project_alerts"], [])


if __name__ == "__main__":
    unittest.main()
