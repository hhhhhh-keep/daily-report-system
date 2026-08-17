"""Stable CLI entrypoint for evidence and schema validation of model analysis."""

from __future__ import annotations

import argparse
import json
import sys
from dataclasses import asdict
from pathlib import Path

from validate_analysis_result import validate_analysis_result


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--facts", required=True, type=Path)
    parser.add_argument("--analysis", required=True, type=Path)
    arguments = parser.parse_args()
    try:
        facts = json.loads(arguments.facts.read_text(encoding="utf-8"))
        analysis = json.loads(arguments.analysis.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exception:
        print(json.dumps({"status": "invalid_json", "error": str(exception)}, ensure_ascii=False), file=sys.stderr)
        return 3
    validation = validate_analysis_result(facts, analysis)
    if not validation.ok:
        print(json.dumps({"status": "invalid_analysis", "errors": [asdict(item) for item in validation.errors]},
                         ensure_ascii=False), file=sys.stderr)
        return 3
    print(json.dumps({"status": "validated"}, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
