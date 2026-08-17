from __future__ import annotations

import json
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path


SKILL_ROOT = Path(__file__).resolve().parents[1]


class CliEntrypointTests(unittest.TestCase):
    def test_render_entrypoint_creates_docx_and_machine_readable_status(self) -> None:
        facts = {
            "period": {"report_date": "2026-07-31", "start_date": "2026-07-27", "end_date": "2026-07-31", "timezone": "Asia/Shanghai"},
            "metrics": {"expected_people": 1, "submitted_people": 1, "submission_rate": 1.0,
                        "missing_people": 0, "full_day_leave_people": 0, "half_day_leave_people": 0,
                        "review_required_people": 0, "effective_task_count": 1, "risk_or_blocked_count": 0},
            "missing_people": [], "full_day_leave_people": [], "half_day_leave_people": [],
            "review_required_people": [], "work_composition": [], "project_candidates": [],
            "collaborations": [], "risk_candidates": [],
            "project_continuity": [], "project_associations": [], "risk_assessment": [],
        }
        with tempfile.TemporaryDirectory() as directory:
            temp = Path(directory)
            facts_path = temp / "facts.json"
            output = temp / "report.docx"
            facts_path.write_text(json.dumps(facts, ensure_ascii=False), encoding="utf-8")
            result = subprocess.run(
                [sys.executable, str(SKILL_ROOT / "scripts" / "run_render_docx.py"),
                 "--facts", str(facts_path), "--template",
                 str(SKILL_ROOT / "assets" / "daily-report-template.docx"), "--output", str(output)],
                check=False, capture_output=True, text=True,
            )

            self.assertEqual(0, result.returncode, result.stderr)
            self.assertEqual("rendered", json.loads(result.stdout)["status"])
            self.assertTrue(output.is_file())


if __name__ == "__main__":
    unittest.main()
