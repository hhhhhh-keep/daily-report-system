"""Validation gate for evidence-bound model analysis results."""

from __future__ import annotations

import json
from collections.abc import Mapping, Sequence
from dataclasses import dataclass
from pathlib import Path
from typing import Any

from jsonschema import Draft202012Validator

from package_contract import ValidationIssue


_SCHEMA_PATH = Path(__file__).resolve().parents[1] / "schemas" / "daily-analysis.schema.json"
_ERROR_PLACEHOLDERS = (
    "invalid input",
    "data package or evidence is empty or unreadable",
    "事实包不完整或未提供",
    "无法生成整体判断",
    "未调用模型或模型结果未通过校验",
)


@dataclass(frozen=True, slots=True)
class AnalysisValidationResult:
    analysis: Mapping[str, object] | None
    errors: tuple[ValidationIssue, ...]

    @property
    def ok(self) -> bool:
        return not self.errors

    @property
    def error_codes(self) -> tuple[str, ...]:
        return tuple(issue.code for issue in self.errors)


def validate_analysis_result(daily_facts: Mapping[str, object], candidate: object) -> AnalysisValidationResult:
    """Accept only schema-valid output whose references are present in daily facts."""
    errors: list[ValidationIssue] = []
    errors.extend(_schema_errors(candidate))
    if not isinstance(candidate, Mapping):
        return AnalysisValidationResult(None, tuple(errors))

    if _contains_key(candidate, "metrics"):
        errors.append(_issue("METRICS_MUTATED", "metrics", "Model output may not contain deterministic metrics"))

    known_evidence = _known_values(daily_facts, "evidence_id")
    known_people = _known_values(daily_facts, "person_id")
    known_projects = _known_values(daily_facts, "project_id") | _known_values(daily_facts, "project_candidate_id")
    errors.extend(_unknown_reference_errors(candidate, "evidence_ids", known_evidence, "UNKNOWN_EVIDENCE_ID"))
    errors.extend(_unknown_reference_errors(candidate, "person_ids", known_people, "UNKNOWN_PERSON_ID"))
    errors.extend(_unknown_reference_errors(candidate, "project_id", known_projects, "UNKNOWN_PROJECT_ID"))
    errors.extend(_missing_evidence_errors(candidate))
    errors.extend(_reconstructed_project_errors(daily_facts, candidate))
    errors.extend(_placeholder_errors(candidate))
    errors.extend(_required_semantic_section_errors(daily_facts, candidate))
    errors.extend(_efficiency_specificity_errors(daily_facts, candidate))

    return AnalysisValidationResult(None if errors else dict(candidate), tuple(errors))


def _schema_errors(candidate: object) -> list[ValidationIssue]:
    schema = json.loads(_SCHEMA_PATH.read_text(encoding="utf-8"))
    validator = Draft202012Validator(schema)
    return [
        _issue("SCHEMA_INVALID", "/".join(str(part) for part in error.absolute_path), error.message)
        for error in sorted(validator.iter_errors(candidate), key=lambda item: list(item.absolute_path))
    ]


def _known_values(value: object, key: str) -> set[str]:
    values: set[str] = set()
    if isinstance(value, Mapping):
        for name, item in value.items():
            if name == key and isinstance(item, str):
                values.add(item)
            values.update(_known_values(item, key))
    elif _is_list(value):
        for item in value:
            values.update(_known_values(item, key))
    return values


def _unknown_reference_errors(candidate: Mapping[str, object], key: str, known: set[str], code: str) -> list[ValidationIssue]:
    errors: list[ValidationIssue] = []
    for path, value in _references(candidate, key):
        values = value if _is_list(value) else (value,)
        for item in values:
            if isinstance(item, str) and item not in known:
                errors.append(_issue(code, path, f"Unknown {key}: {item}"))
    return errors


def _references(value: object, key: str, path: str = "") -> list[tuple[str, object]]:
    references: list[tuple[str, object]] = []
    if isinstance(value, Mapping):
        for name, item in value.items():
            item_path = f"{path}/{name}" if path else name
            if name == key:
                references.append((item_path, item))
            references.extend(_references(item, key, item_path))
    elif _is_list(value):
        for index, item in enumerate(value):
            references.extend(_references(item, key, f"{path}/{index}"))
    return references


def _missing_evidence_errors(candidate: Mapping[str, object]) -> list[ValidationIssue]:
    errors: list[ValidationIssue] = []
    for section in ("risk_items", "next_day_actions"):
        items = candidate.get(section)
        if not _is_list(items):
            continue
        for index, item in enumerate(items):
            if isinstance(item, Mapping) and not item.get("evidence_ids"):
                errors.append(_issue("MISSING_EVIDENCE", f"{section}/{index}/evidence_ids", f"{section} items require evidence_ids"))
    return errors


def _reconstructed_project_errors(daily_facts: Mapping[str, object], candidate: Mapping[str, object]) -> list[ValidationIssue]:
    reconstructed = {
        item.get("project_id") for section in ("formal_project_dynamics", "stale_project_alerts")
        for item in _mapping_items(daily_facts.get(section))
        if item.get("snapshot_origin") == "reconstructed" and isinstance(item.get("project_id"), str)
    }
    errors: list[ValidationIssue] = []
    for path, project_id in _references(candidate, "project_id"):
        if project_id not in reconstructed:
            continue
        item_path = path.rsplit("/", 1)[0] if "/" in path else ""
        item = _value_at(candidate, item_path)
        if not isinstance(item, Mapping) or not isinstance(item.get("limitation_note"), str) or not item["limitation_note"].strip():
            errors.append(_issue("RECONSTRUCTED_WITHOUT_LIMITATION", path, "Reconstructed project conclusions require a limitation note"))
    return errors


def _placeholder_errors(candidate: Mapping[str, object]) -> list[ValidationIssue]:
    errors: list[ValidationIssue] = []
    for key in ("summary", "description", "action"):
        for path, value in _references(candidate, key):
            if not isinstance(value, str):
                continue
            normalized = " ".join(value.lower().split())
            if any(phrase in normalized for phrase in _ERROR_PLACEHOLDERS):
                errors.append(_issue("ERROR_PLACEHOLDER", path, "Model returned an error placeholder instead of analysis"))
    return errors


def _required_semantic_section_errors(
        daily_facts: Mapping[str, object], candidate: Mapping[str, object]) -> list[ValidationIssue]:
    if candidate.get("data_contract_version") != "1.2.0":
        return []
    section_map = {
        "efficiency_summary": "efficiency_insights",
        "project_continuity": "continuity_analysis",
        "project_associations": "association_analysis",
        "risk_assessment": "risk_items",
    }
    errors: list[ValidationIssue] = []
    for fact_section, analysis_section in section_map.items():
        if _mapping_items(daily_facts.get(fact_section)) and not _mapping_items(candidate.get(analysis_section)):
            errors.append(_issue(
                "MISSING_REQUIRED_ANALYSIS", analysis_section,
                f"{analysis_section} must contain an evidence-backed item when {fact_section} is non-empty",
            ))
    for index, item in enumerate(_mapping_items(candidate.get("efficiency_insights"))):
        if not item.get("person_ids"):
            errors.append(_issue(
                "EFFICIENCY_WITHOUT_PERSON", f"efficiency_insights/{index}/person_ids",
                "Efficiency observations must identify at least one person from the fact package",
            ))
    return errors


def _efficiency_specificity_errors(
        daily_facts: Mapping[str, object], candidate: Mapping[str, object]) -> list[ValidationIssue]:
    names_by_id = {
        str(item.get("person_id")): str(item.get("name"))
        for item in _mapping_items(daily_facts.get("efficiency_summary"))
        if item.get("person_id") and item.get("name")
    }
    errors: list[ValidationIssue] = []
    for index, item in enumerate(_mapping_items(candidate.get("efficiency_insights"))):
        person_ids = item.get("person_ids") if _is_list(item.get("person_ids")) else ()
        expected_names = [names_by_id.get(str(person_id)) for person_id in person_ids]
        expected_names = [name for name in expected_names if name]
        summary = str(item.get("summary") or "")
        if expected_names and not any(name in summary for name in expected_names):
            errors.append(_issue(
                "EFFICIENCY_MISSING_PERSON_NAME", f"efficiency_insights/{index}/summary",
                "Efficiency observations must name at least one referenced person",
            ))
    return errors


def _mapping_items(value: object) -> tuple[Mapping[str, object], ...]:
    return tuple(item for item in value if isinstance(item, Mapping)) if _is_list(value) else ()


def _value_at(value: object, path: str) -> object:
    current = value
    for part in path.split("/") if path else ():
        if isinstance(current, Mapping):
            current = current.get(part)
        elif _is_list(current) and part.isdigit():
            current = current[int(part)]
        else:
            return None
    return current


def _contains_key(value: object, key: str) -> bool:
    return bool(_references(value, key))


def _is_list(value: object) -> bool:
    return isinstance(value, Sequence) and not isinstance(value, (str, bytes, bytearray))


def _issue(code: str, path: str, message: str) -> ValidationIssue:
    return ValidationIssue(code=code, path=path, message=message)
