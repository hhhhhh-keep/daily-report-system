"""Stable CLI entrypoint: validated DataPackage ZIP to canonical daily facts JSON."""

from __future__ import annotations

import argparse
import json
import sys
from dataclasses import asdict
from datetime import date
from pathlib import Path

from build_fact_package import build_daily_facts, canonical_json
from package_contract import validate_package


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", required=True, type=Path)
    parser.add_argument("--date", required=True, type=date.fromisoformat)
    parser.add_argument("--output", required=True, type=Path)
    arguments = parser.parse_args()
    validation = validate_package(arguments.input)
    if not validation.ok or validation.package is None:
        print(json.dumps({"status": "invalid_data_package", "errors": [asdict(item) for item in validation.errors]},
                         ensure_ascii=False), file=sys.stderr)
        return 2
    try:
        facts = build_daily_facts(validation.package, arguments.date)
        arguments.output.parent.mkdir(parents=True, exist_ok=True)
        arguments.output.write_bytes(canonical_json(facts))
    except (OSError, ValueError) as exception:
        print(json.dumps({"status": "facts_failed", "error": str(exception)}, ensure_ascii=False), file=sys.stderr)
        return 2
    print(json.dumps({"status": "prepared", "output": str(arguments.output)}, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
