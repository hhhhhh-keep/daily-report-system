from __future__ import annotations

import json
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path


SKILL_ROOT = Path(__file__).resolve().parents[1]
FIXTURE = SKILL_ROOT / "tests" / "fixtures" / "valid" / "daily-data-package.zip"


class CliEntrypointTests(unittest.TestCase):
    def test_prepare_facts_writes_canonical_json_and_status(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            output = Path(directory) / "daily-facts.json"
            result = subprocess.run(
                [sys.executable, str(SKILL_ROOT / "scripts" / "run_prepare_facts.py"),
                 "--input", str(FIXTURE), "--date", "2026-07-31", "--output", str(output)],
                check=False, capture_output=True, text=True,
            )

            self.assertEqual(0, result.returncode, result.stderr)
            self.assertEqual("prepared", json.loads(result.stdout)["status"])
            facts = json.loads(output.read_text(encoding="utf-8"))
            self.assertEqual("2026-07-31", facts["period"]["start_date"])


if __name__ == "__main__":
    unittest.main()
