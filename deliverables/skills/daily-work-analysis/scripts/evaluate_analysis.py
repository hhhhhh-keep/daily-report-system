"""Offline quality evaluation for evidence-bound daily-analysis candidates."""

from __future__ import annotations

import re
from collections.abc import Mapping, Sequence
from dataclasses import dataclass

from validate_analysis_result import validate_analysis_result


MIN_PROJECT_RECALL = 0.80
MIN_RISK_EVIDENCE_PRECISION = 1.00
MIN_ACTION_EXECUTABILITY = 0.75
MAX_DUPLICATION_RATE = 0.10


@dataclass(frozen=True, slots=True)
class EvaluationResult:
    hard_gate_passed: bool
    error_codes: tuple[str, ...]
    project_recall: float
    risk_evidence_precision: float
    action_executability: float
    duplication_rate: float


def evaluate_case(facts: Mapping[str, object], candidate: object, expected: Mapping[str, object]) -> EvaluationResult:
    """Score a candidate without network access or nondeterministic model calls."""
    validation = validate_analysis_result(facts, candidate)
    numeric_errors = _unsupported_numeric_claims(facts, candidate)
    errors = tuple((*validation.error_codes, *("UNSUPPORTED_NUMERIC_CLAIM" for _ in numeric_errors)))
    candidate_mapping = candidate if isinstance(candidate, Mapping) else {}
    return EvaluationResult(
        hard_gate_passed=not errors,
        error_codes=errors,
        project_recall=_project_recall(candidate_mapping, expected),
        risk_evidence_precision=_risk_evidence_precision(candidate_mapping, expected),
        action_executability=_action_executability(candidate_mapping, expected),
        duplication_rate=_duplication_rate(candidate_mapping),
    )


def passes_production_gate(result: EvaluationResult) -> bool:
    """Apply the fixed release thresholds to a single deterministic evaluation."""
    return (
        result.hard_gate_passed
        and result.project_recall >= MIN_PROJECT_RECALL
        and result.risk_evidence_precision >= MIN_RISK_EVIDENCE_PRECISION
        and result.action_executability >= MIN_ACTION_EXECUTABILITY
        and result.duplication_rate <= MAX_DUPLICATION_RATE
    )


def _project_recall(candidate: Mapping[str, object], expected: Mapping[str, object]) -> float:
    required = _string_set(expected.get("required_project_ids"))
    if not required:
        return 1.0
    found = {
        item.get("project_id") for item in _items(candidate.get("project_highlights"))
        if isinstance(item.get("project_id"), str)
    }
    return len(required & found) / len(required)


def _risk_evidence_precision(candidate: Mapping[str, object], expected: Mapping[str, object]) -> float:
    expected_ids = _string_set(expected.get("risk_evidence_ids"))
    submitted = {
        evidence_id for item in _items(candidate.get("risk_items"))
        for evidence_id in _string_set(item.get("evidence_ids"))
    }
    if not submitted:
        return 1.0 if not expected_ids else 0.0
    return len(submitted & expected_ids) / len(submitted)


def _action_executability(candidate: Mapping[str, object], expected: Mapping[str, object]) -> float:
    actions = _items(candidate.get("next_day_actions"))
    if not actions:
        return 0.0
    expected_ids = _string_set(expected.get("actionable_evidence_ids"))
    executable = sum(
        bool(_text(item.get("action")) or _text(item.get("summary"))) and bool(_string_set(item.get("evidence_ids")) & expected_ids)
        for item in actions
    )
    return executable / len(actions)


def _duplication_rate(candidate: Mapping[str, object]) -> float:
    actions = [_text(item.get("action")) or _text(item.get("summary")) for item in _items(candidate.get("next_day_actions"))]
    actions = [action for action in actions if action]
    if not actions:
        return 0.0
    return (len(actions) - len(set(actions))) / len(actions)


def _unsupported_numeric_claims(facts: Mapping[str, object], candidate: object) -> tuple[str, ...]:
    known_numbers = set(_numbers_in_object(facts))
    claims = [
        value for key, value in _text_fields(candidate)
        if key in {"summary", "description", "action"}
    ]
    return tuple(number for claim in claims for number in _numbers(claim) if number not in known_numbers)


def _numbers_in_object(value: object) -> tuple[str, ...]:
    if isinstance(value, Mapping):
        return tuple(number for item in value.values() for number in _numbers_in_object(item))
    if _is_sequence(value):
        return tuple(number for item in value for number in _numbers_in_object(item))
    return _numbers(value) if isinstance(value, str) else ()


def _text_fields(value: object) -> tuple[tuple[str, str], ...]:
    if isinstance(value, Mapping):
        return tuple((str(key), item) for key, item in value.items() if isinstance(item, str)) + tuple(
            field for item in value.values() for field in _text_fields(item)
        )
    if _is_sequence(value):
        return tuple(field for item in value for field in _text_fields(item))
    return ()


def _numbers(value: str) -> tuple[str, ...]:
    return tuple(re.findall(r"\d+(?:\.\d+)?", value))


def _items(value: object) -> tuple[Mapping[str, object], ...]:
    if not _is_sequence(value):
        return ()
    return tuple(item for item in value if isinstance(item, Mapping))


def _string_set(value: object) -> set[str]:
    return {item for item in value if isinstance(item, str)} if _is_sequence(value) else set()


def _text(value: object) -> str:
    return value.strip() if isinstance(value, str) else ""


def _is_sequence(value: object) -> bool:
    return isinstance(value, Sequence) and not isinstance(value, (str, bytes, bytearray))
