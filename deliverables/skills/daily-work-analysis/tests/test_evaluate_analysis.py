from __future__ import annotations

import json
import sys
import unittest
from copy import deepcopy
from pathlib import Path

from jsonschema import Draft202012Validator, FormatChecker


SKILL_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(SKILL_ROOT / "scripts"))

from evaluate_analysis import evaluate_case  # noqa: E402


GOLDEN = SKILL_ROOT / "tests" / "golden"


class EvaluateAnalysisTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.cases = json.loads((GOLDEN / "cases.json").read_text(encoding="utf-8"))
        cls.expected = json.loads((GOLDEN / "expected.json").read_text(encoding="utf-8"))
        schema = json.loads((SKILL_ROOT / "schemas" / "daily-facts.schema.json").read_text(encoding="utf-8"))
        cls.facts_validator = Draft202012Validator(schema, format_checker=FormatChecker())

    def test_golden_set_contains_all_required_scenarios_and_meets_quality_thresholds(self) -> None:
        self.assertEqual({case["id"] for case in self.cases}, {
            "normal_day", "full_day_leave", "half_day_leave", "unknown_leave_period",
            "attendance_conflict", "multi_person_collaboration", "same_named_projects",
            "zero_risk", "long_text",
        })
        for case in self.cases:
            schema_errors = sorted(self.facts_validator.iter_errors(case["facts"]), key=lambda error: list(error.absolute_path))
            self.assertEqual(schema_errors, [], f"{case['id']}: {[error.message for error in schema_errors]}")
            result = evaluate_case(case["facts"], case["candidate"], self.expected[case["id"]])
            self.assertTrue(result.hard_gate_passed, case["id"])
            self.assertGreaterEqual(result.project_recall, 0.80, case["id"])
            self.assertEqual(result.risk_evidence_precision, 1.00, case["id"])
            self.assertGreaterEqual(result.action_executability, 0.75, case["id"])
            self.assertLessEqual(result.duplication_rate, 0.10, case["id"])

    def test_long_text_has_a_declared_substantive_boundary_and_stable_evaluation(self) -> None:
        case = next(item for item in self.cases if item["id"] == "long_text")
        raw_text = case["facts"]["evidence"][0]["raw_text"]

        self.assertGreaterEqual(len(raw_text), self.expected["long_text"]["minimum_raw_text_length"])
        first = evaluate_case(case["facts"], case["candidate"], self.expected["long_text"])
        second = evaluate_case(case["facts"], case["candidate"], self.expected["long_text"])
        self.assertEqual(first, second)

    def test_unknown_person_project_evidence_and_numeric_claim_are_hard_failures(self) -> None:
        case = self.cases[0]
        candidate = deepcopy(case["candidate"])
        candidate["work_summary"]["summary"] = "完成99项工作。"
        candidate["work_summary"]["evidence_ids"] = ["unknown-evidence"]
        candidate["project_highlights"][0]["project_id"] = "unknown-project"
        candidate["project_highlights"][0]["person_ids"] = ["unknown-person"]

        result = evaluate_case(case["facts"], candidate, self.expected[case["id"]])

        self.assertFalse(result.hard_gate_passed)
        self.assertTrue({"UNKNOWN_EVIDENCE_ID", "UNKNOWN_PERSON_ID", "UNKNOWN_PROJECT_ID", "UNSUPPORTED_NUMERIC_CLAIM"} <= set(result.error_codes))

    def test_missing_required_project_only_reduces_recall(self) -> None:
        case = next(item for item in self.cases if item["id"] == "same_named_projects")
        candidate = deepcopy(case["candidate"])
        candidate["project_highlights"] = candidate["project_highlights"][:1]

        result = evaluate_case(case["facts"], candidate, self.expected[case["id"]])

        self.assertTrue(result.hard_gate_passed)
        self.assertEqual(result.project_recall, 0.50)

    def test_duplicate_actions_raise_duplication_rate(self) -> None:
        case = self.cases[0]
        candidate = deepcopy(case["candidate"])
        candidate["next_day_actions"].append(deepcopy(candidate["next_day_actions"][0]))

        result = evaluate_case(case["facts"], candidate, self.expected[case["id"]])

        self.assertTrue(result.hard_gate_passed)
        self.assertEqual(result.duplication_rate, 0.50)


if __name__ == "__main__":
    unittest.main()
