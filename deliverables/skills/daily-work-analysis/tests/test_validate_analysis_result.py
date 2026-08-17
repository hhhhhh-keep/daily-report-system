from __future__ import annotations

import sys
import unittest
from copy import deepcopy
from pathlib import Path


SKILL_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(SKILL_ROOT / "scripts"))

from validate_analysis_result import validate_analysis_result  # noqa: E402


FACTS = {
    "data_contract_version": "1.1.0",
    "evidence": [{"evidence_id": "evidence-1", "raw_text": "source evidence"}],
    "missing_people": [{"person_id": "person-1", "name": "missing"}],
    "full_day_leave_people": [],
    "half_day_leave_people": [],
    "review_required_people": [],
    "work_composition": [{"task_id": "task-1", "person_id": "person-2", "project_candidate_id": "project-1"}],
    "project_candidates": [{"project_id": "project-1", "standard_name": "project"}],
    "collaborations": [{"task_id": "task-1", "person_id": "person-2", "role": "lead"}],
    "risk_candidates": [],
    "formal_project_dynamics": [{"project_id": "project-1", "snapshot_origin": "captured"}],
    "project_continuity": [{"project_id": "project-1", "evidence_ids": ["evidence-1"]}],
    "project_associations": [{"association_id": "association-1", "project_ids": ["project-1"],
                              "person_ids": ["person-2"], "evidence_ids": ["evidence-1"]}],
    "risk_assessment": [{"risk_id": "risk-1", "project_id": "project-1",
                         "person_ids": ["person-2"], "evidence_ids": ["evidence-1"]}],
}


def valid_candidate() -> dict[str, object]:
    return {
        "data_contract_version": "1.0.0",
        "work_summary": {"summary": "Completed documented work.", "evidence_ids": ["evidence-1"]},
        "project_highlights": [{"project_id": "project-1", "summary": "Project update.", "person_ids": ["person-2"], "evidence_ids": ["evidence-1"]}],
        "risk_items": [{"description": "Documented risk.", "person_ids": ["person-1"], "project_id": "project-1", "evidence_ids": ["evidence-1"]}],
        "next_day_actions": [{"action": "Follow up.", "person_ids": ["person-2"], "project_id": "project-1", "evidence_ids": ["evidence-1"]}],
    }


def valid_v11_candidate() -> dict[str, object]:
    return {
        "data_contract_version": "1.1.0",
        "overall_judgment": {"summary": "整体工作有序推进。", "person_ids": [], "project_id": None,
                             "evidence_ids": ["evidence-1"], "limitation_note": None},
        "efficiency_insights": [{"summary": "人员完成有证据的工作事项。", "person_ids": ["person-2"],
                                 "project_id": "project-1", "evidence_ids": ["evidence-1"],
                                 "limitation_note": None}],
        "project_highlights": [{"summary": "项目持续推进。", "person_ids": ["person-2"],
                                "project_id": "project-1", "evidence_ids": ["evidence-1"],
                                "limitation_note": None}],
        "risk_items": [],
        "next_day_actions": [{"summary": "次日继续跟进。", "person_ids": ["person-2"],
                              "project_id": "project-1", "evidence_ids": ["evidence-1"],
                              "limitation_note": None}],
    }


def valid_v12_candidate() -> dict[str, object]:
    item = {"summary": "有原始记录支持的管理结论。", "person_ids": ["person-2"],
            "project_id": "project-1", "evidence_ids": ["evidence-1"], "limitation_note": None}
    return {
        "data_contract_version": "1.2.0",
        "overall_judgment": {**item, "person_ids": [], "project_id": None},
        "efficiency_insights": [dict(item)],
        "continuity_analysis": [dict(item)],
        "association_analysis": [dict(item)],
        "risk_items": [dict(item)],
        "next_day_actions": [dict(item)],
    }


class ValidateAnalysisResultTests(unittest.TestCase):
    def test_accepts_substantive_v12_analysis(self) -> None:
        result = validate_analysis_result(FACTS, valid_v12_candidate())
        self.assertTrue(result.ok, result.errors)

    def test_rejects_chinese_and_english_error_placeholders(self) -> None:
        phrases = (
            "事实包不完整或未提供，无法生成整体判断。",
            "无法生成整体判断。",
            "Invalid input: data package or evidence is empty or unreadable.",
        )
        for phrase in phrases:
            with self.subTest(phrase=phrase):
                candidate = valid_v12_candidate()
                candidate["overall_judgment"]["summary"] = phrase
                result = validate_analysis_result(FACTS, candidate)
                self.assertIn("ERROR_PLACEHOLDER", result.error_codes)

    def test_v12_requires_semantic_sections_when_corresponding_facts_exist(self) -> None:
        candidate = valid_v12_candidate()
        candidate["continuity_analysis"] = []
        candidate["association_analysis"] = []
        candidate["risk_items"] = []

        result = validate_analysis_result(FACTS, candidate)

        self.assertIn("MISSING_REQUIRED_ANALYSIS", result.error_codes)

    def test_v12_requires_person_specific_efficiency_when_efficiency_facts_exist(self) -> None:
        facts = deepcopy(FACTS)
        facts["efficiency_summary"] = [{"person_id": "person-2", "name": "钱程"}]
        candidate = valid_v12_candidate()
        candidate["efficiency_insights"] = []

        result = validate_analysis_result(facts, candidate)

        self.assertIn("MISSING_REQUIRED_ANALYSIS", result.error_codes)

        candidate = valid_v12_candidate()
        candidate["efficiency_insights"][0]["person_ids"] = []
        result = validate_analysis_result(facts, candidate)
        self.assertIn("EFFICIENCY_WITHOUT_PERSON", result.error_codes)

        candidate = valid_v12_candidate()
        result = validate_analysis_result(facts, candidate)
        self.assertIn("EFFICIENCY_MISSING_PERSON_NAME", result.error_codes)

        candidate["efficiency_insights"][0]["summary"] = "钱程参与知识库项目模型选型并形成对比结论。"
        result = validate_analysis_result(facts, candidate)
        self.assertNotIn("EFFICIENCY_MISSING_PERSON_NAME", result.error_codes)

    def test_accepts_v11_leadership_analysis(self) -> None:
        result = validate_analysis_result(FACTS, valid_v11_candidate())
        self.assertTrue(result.ok, result.errors)

    def test_reconstructed_project_requires_limitation_note(self) -> None:
        facts = deepcopy(FACTS)
        facts["formal_project_dynamics"][0]["snapshot_origin"] = "reconstructed"
        candidate = valid_v11_candidate()

        result = validate_analysis_result(facts, candidate)

        self.assertIn("RECONSTRUCTED_WITHOUT_LIMITATION", result.error_codes)
    def test_accepts_evidence_bound_analysis(self) -> None:
        candidate = valid_candidate()

        result = validate_analysis_result(FACTS, candidate)

        self.assertTrue(result.ok)
        self.assertEqual(result.analysis, candidate)
        self.assertEqual(result.error_codes, ())

    def test_rejects_unknown_evidence_person_project_and_changed_metrics(self) -> None:
        candidate = valid_candidate()
        candidate["work_summary"]["evidence_ids"] = ["unknown-evidence"]
        candidate["project_highlights"][0]["project_id"] = "unknown-project"
        candidate["project_highlights"][0]["person_ids"] = ["unknown-person"]
        candidate["metrics"] = {"submitted_people": 999}

        result = validate_analysis_result(FACTS, candidate)

        self.assertFalse(result.ok)
        self.assertIsNone(result.analysis)
        self.assertTrue({"UNKNOWN_EVIDENCE_ID", "UNKNOWN_PERSON_ID", "UNKNOWN_PROJECT_ID", "METRICS_MUTATED"} <= set(result.error_codes))

    def test_risks_and_actions_without_evidence_are_rejected(self) -> None:
        candidate = valid_candidate()
        del candidate["risk_items"][0]["evidence_ids"]
        del candidate["next_day_actions"][0]["evidence_ids"]

        result = validate_analysis_result(FACTS, candidate)

        self.assertFalse(result.ok)
        self.assertIn("MISSING_EVIDENCE", result.error_codes)
        self.assertIn("SCHEMA_INVALID", result.error_codes)

    def test_rejects_schema_invalid_analysis(self) -> None:
        candidate = valid_candidate()
        candidate["work_summary"]["unexpected"] = True

        result = validate_analysis_result(FACTS, candidate)

        self.assertFalse(result.ok)
        self.assertIn("SCHEMA_INVALID", result.error_codes)

    def test_allows_risk_and_action_without_person_or_project_when_evidence_exists(self) -> None:
        candidate = valid_candidate()
        for section in ("risk_items", "next_day_actions"):
            del candidate[section][0]["person_ids"]
            del candidate[section][0]["project_id"]

        result = validate_analysis_result(FACTS, candidate)

        self.assertTrue(result.ok)


if __name__ == "__main__":
    unittest.main()
