"""CLI wrapper for the trusted daily data-package contract."""

from __future__ import annotations

import argparse
import json
from dataclasses import asdict
from pathlib import Path

from package_contract import validate_package


def main() -> int:
    parser = argparse.ArgumentParser(description="Validate a daily data package ZIP")
    parser.add_argument("path", type=Path)
    args = parser.parse_args()
    result = validate_package(args.path)
    print(json.dumps({"ok": result.ok, "errors": [asdict(issue) for issue in result.errors], "warnings": [asdict(issue) for issue in result.warnings]}, ensure_ascii=False))
    return 0 if result.ok else 2


if __name__ == "__main__":
    raise SystemExit(main())
