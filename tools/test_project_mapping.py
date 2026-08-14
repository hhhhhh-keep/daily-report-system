from pathlib import Path

source = Path("tools/prepare_july_import.py").read_text(encoding="utf-8")

assert "FALLBACK_PROJECT_CODE" in source, "unmatched daily-report text must use one explicit fallback project"
assert "return FALLBACK_PROJECT_CODE" in source, "unmatched daily-report text must not be hash-assigned to a named project"
