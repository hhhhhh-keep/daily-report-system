"""Stable CLI entrypoint for deterministic DOCX generation."""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

from audit_daily_report import audit_daily_report
from render_daily_report import render_daily_report


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--facts", required=True, type=Path)
    parser.add_argument("--analysis", type=Path)
    parser.add_argument("--template", required=True, type=Path)
    parser.add_argument("--output", required=True, type=Path)
    arguments = parser.parse_args()
    try:
        facts = json.loads(arguments.facts.read_text(encoding="utf-8"))
        analysis = json.loads(arguments.analysis.read_text(encoding="utf-8")) if arguments.analysis else None
        render_daily_report(arguments.template, facts, analysis, arguments.output)
        audit = audit_daily_report(arguments.output, facts)
    except (OSError, ValueError, json.JSONDecodeError) as exception:
        print(json.dumps({"status": "render_failed", "error": str(exception)}, ensure_ascii=False), file=sys.stderr)
        return 4
    if not audit.ok:
        print(json.dumps({"status": "audit_failed", "errors": list(audit.errors)}, ensure_ascii=False), file=sys.stderr)
        return 4
    print(json.dumps({"status": "rendered", "output": str(arguments.output)}, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
