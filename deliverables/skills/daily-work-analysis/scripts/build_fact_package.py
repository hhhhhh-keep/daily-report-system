"""Build the stable, model-independent fact object for a daily report."""

from __future__ import annotations

import json
from dataclasses import asdict
from datetime import date, timedelta
from pathlib import Path
from typing import Any

from jsonschema import Draft202012Validator, FormatChecker

from calculate_daily_metrics import (
    PersonClassification, calculate_submission_dashboard, classify_people,
    deduplicated_tasks, calculate_daily_metrics,
)
from package_contract import DataPackage, TaskEntry


_SCHEMA_PATH = Path(__file__).resolve().parents[1] / "schemas" / "daily-facts.schema.json"


def canonical_json(value: object) -> bytes:
    """Canonical JSON bytes for repeatable artifact generation."""
    return json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(",", ":")).encode("utf-8")


def tasks_in_window(package: DataPackage, start: date, end: date) -> tuple[TaskEntry, ...]:
    """Return stable, de-duplicated project tasks in the declared analysis window."""
    selected: dict[tuple[str, str], TaskEntry] = {}
    for item in package.tasks:
        task_date = date.fromisoformat(item.date)
        if task_date < start or task_date > end:
            continue
        key = (item.date, item.task_id)
        previous = selected.get(key)
        if previous is None or (
            item.report_id, item.raw_text, item.status, item.output or ""
        ) < (
            previous.report_id, previous.raw_text, previous.status, previous.output or ""
        ):
            selected[key] = item
    return tuple(selected[key] for key in sorted(selected))


def _window_context(package: DataPackage, report_date: date) -> tuple[
        tuple[TaskEntry, ...], dict[str, object], dict[str, str], dict[str, list[dict[str, object]]]]:
    start = date.fromisoformat(package.manifest.start_date)
    reports = {
        item.report_id: item for item in package.reports
        if start <= date.fromisoformat(item.date) <= report_date
    }
    names = {item.person_id: item.name for item in package.roster}
    tasks = tasks_in_window(package, start, report_date)
    relations_by_task: dict[str, list[dict[str, object]]] = {}
    for relation in _deduplicated_relations(package, {item.task_id for item in tasks}):
        relations_by_task.setdefault(str(relation["task_id"]), []).append(relation)
    return tasks, reports, names, relations_by_task


def build_project_continuity(package: DataPackage, report_date: date) -> list[dict[str, object]]:
    tasks, reports, names, relations_by_task = _window_context(package, report_date)
    project_names = {
        item.project_id: item.standard_name or (item.candidate_names[0] if item.candidate_names else item.project_id)
        for item in package.projects
    }
    status_names = {item.project_id: item.project_name for item in package.project_statuses}
    rows: list[dict[str, object]] = []
    project_ids = sorted({item.project_candidate_id for item in tasks if item.project_candidate_id})
    for project_id in project_ids:
        project_tasks = [item for item in tasks if item.project_candidate_id == project_id]
        active_dates = sorted({item.date for item in project_tasks})
        person_ids = sorted({
            reports[item.report_id].person_id for item in project_tasks if item.report_id in reports
        })
        evidence_ids = sorted({
            str(relation["evidence_id"])
            for item in project_tasks for relation in relations_by_task.get(item.task_id, [])
        } | {
            reports[item.report_id].snapshot_id for item in project_tasks if item.report_id in reports
        })
        is_current = report_date.isoformat() in active_dates
        if is_current and active_dates[0] == report_date.isoformat():
            classification = "new"
        elif is_current:
            classification = "continuing"
        elif any(item.status == "completed" for item in project_tasks if item.date == active_dates[-1]):
            classification = "last_activity_completed"
        else:
            classification = "interrupted"
        rows.append({
            "project_id": project_id,
            "project_name": status_names.get(project_id) or project_names.get(project_id, project_id),
            "active_dates": active_dates,
            "first_active_date": active_dates[0],
            "last_active_date": active_dates[-1],
            "person_ids": person_ids,
            "people": [names.get(person_id, person_id) for person_id in person_ids],
            "actions": sorted({item.raw_text for item in project_tasks if item.raw_text}),
            "outputs": sorted({item.output for item in project_tasks if item.output}),
            "status_evidence": sorted({item.status for item in project_tasks}),
            "classification": classification,
            "limitation_note": (
                "仅表示窗口内未见后续日报动态，不据此推断项目已停止。"
                if classification == "interrupted" else None
            ),
            "evidence_ids": evidence_ids,
        })
    return rows


def build_project_associations(package: DataPackage, report_date: date) -> list[dict[str, object]]:
    tasks, reports, names, relations_by_task = _window_context(package, report_date)
    project_names = {
        item.project_id: item.standard_name or (item.candidate_names[0] if item.candidate_names else item.project_id)
        for item in package.projects
    }
    rows: list[dict[str, object]] = []
    people_by_project: dict[str, set[str]] = {}
    evidence_by_project: dict[str, set[str]] = {}
    projects_by_person: dict[str, set[str]] = {}
    evidence_by_person: dict[str, set[str]] = {}
    groups = {item.person_id: item.group for item in package.roster}
    for item in tasks:
        project_id = item.project_candidate_id
        if not project_id:
            continue
        relations = relations_by_task.get(item.task_id, [])
        for relation in relations:
            person_id = str(relation["person_id"])
            evidence_id = str(relation["evidence_id"])
            people_by_project.setdefault(project_id, set()).add(person_id)
            evidence_by_project.setdefault(project_id, set()).add(evidence_id)
            projects_by_person.setdefault(person_id, set()).add(project_id)
            evidence_by_person.setdefault(person_id, set()).add(evidence_id)
    for project_id in sorted(people_by_project):
        person_ids = sorted(people_by_project[project_id])
        if len(person_ids) >= 2:
            rows.append({
                "association_id": f"project-{project_id}-multi-person",
                "association_type": "same_project_multi_person",
                "project_ids": [project_id], "person_ids": person_ids,
                "people": [names.get(item, item) for item in person_ids],
                "description": f"{project_names.get(project_id, project_id)}由{len(person_ids)}人共同参与。",
                "evidence_ids": sorted(evidence_by_project[project_id]),
            })
        project_groups = {groups.get(item, "") for item in person_ids if groups.get(item, "")}
        if len(project_groups) >= 2:
            rows.append({
                "association_id": f"project-{project_id}-cross-group",
                "association_type": "cross_group_collaboration",
                "project_ids": [project_id], "person_ids": person_ids,
                "people": [names.get(item, item) for item in person_ids],
                "description": f"{project_names.get(project_id, project_id)}涉及跨组协同。",
                "evidence_ids": sorted(evidence_by_project[project_id]),
            })
    for person_id in sorted(projects_by_person):
        project_ids = sorted(projects_by_person[person_id])
        if len(project_ids) < 2:
            continue
        rows.append({
            "association_id": f"person-{person_id}-multi-project",
            "association_type": "one_person_multi_project",
            "project_ids": project_ids, "person_ids": [person_id],
            "people": [names.get(person_id, person_id)],
            "description": f"{names.get(person_id, person_id)}在窗口内参与{len(project_ids)}个项目。",
            "evidence_ids": sorted(evidence_by_person[person_id]),
        })
    return sorted(rows, key=lambda item: (str(item["association_type"]), str(item["association_id"])))


def build_risk_assessment(package: DataPackage, report_date: date) -> list[dict[str, object]]:
    continuity = build_project_continuity(package, report_date)
    tasks, reports, _, relations_by_task = _window_context(package, report_date)
    rows: list[dict[str, object]] = []
    for item in continuity:
        if item["classification"] == "interrupted":
            rows.append({
                "risk_id": f"information-discontinuity-{item['project_id']}",
                "risk_type": "information_discontinuity", "level": "medium",
                "project_id": item["project_id"], "person_ids": item["person_ids"],
                "summary": f"{item['project_name']}在覆盖窗口后段未见日报动态，需核验当前状态。",
                "evidence_ids": item["evidence_ids"], "limitation_note": item["limitation_note"],
            })
        if len(item["active_dates"]) >= 2 and len(item["person_ids"]) == 1:
            rows.append({
                "risk_id": f"staffing-concentration-{item['project_id']}",
                "risk_type": "staffing_concentration", "level": "low",
                "project_id": item["project_id"], "person_ids": item["person_ids"],
                "summary": f"{item['project_name']}连续动态目前集中于1名人员，建议确认备份与协同安排。",
                "evidence_ids": item["evidence_ids"],
                "limitation_note": "仅基于日报参与记录，不代表实际项目团队仅有1人。",
            })
    project_names = {item["project_id"]: item["project_name"] for item in continuity}
    for project_id in sorted({item.project_candidate_id for item in tasks if item.project_candidate_id}):
        project_tasks = [item for item in tasks if item.project_candidate_id == project_id]
        risky = [item for item in project_tasks if item.status == "blocked" or item.risk or item.blocker]
        if not risky:
            continue
        person_ids = sorted({reports[item.report_id].person_id for item in risky if item.report_id in reports})
        evidence_ids = sorted({
            str(relation["evidence_id"])
            for task_item in risky for relation in relations_by_task.get(task_item.task_id, [])
        } | {reports[item.report_id].snapshot_id for item in risky if item.report_id in reports})
        rows.append({
            "risk_id": f"project-progress-{project_id}", "risk_type": "project_progress",
            "level": "high" if any(item.status == "blocked" for item in risky) else "medium",
            "project_id": project_id, "person_ids": person_ids,
            "summary": f"{project_names.get(project_id, project_id)}存在明确阻塞或风险记录。",
            "evidence_ids": evidence_ids, "limitation_note": None,
        })
    for item in _stale_projects(package, report_date):
        rows.append({
            "risk_id": f"stale-project-{item['project_id']}", "risk_type": "stale_project",
            "level": "medium", "project_id": item["project_id"], "person_ids": [],
            "summary": f"{item['project_name']}已超过{item['threshold_workdays']}个工作日无日报动态。",
            "evidence_ids": [], "limitation_note": "需结合项目维护状态人工核验。",
        })
    return sorted(rows, key=lambda item: (str(item["risk_type"]), str(item["risk_id"])))


def _person_fact(item: PersonClassification) -> dict[str, object]:
    return {
        "person_id": item.person.person_id, "name": item.person.name,
        "work_period_status": item.work_period_status, "review_reason": item.review_reason,
        "source_record_id": item.source_record_id,
    }


def _deduplicated_relations(package: DataPackage, task_ids: set[str]) -> list[dict[str, object]]:
    selected: dict[tuple[str, str, str], object] = {}
    for relation in package.task_relations:
        if relation.task_id not in task_ids:
            continue
        key = (relation.task_id, relation.person_id, relation.role)
        previous = selected.get(key)
        if previous is None or _relation_key(relation) < _relation_key(previous):
            selected[key] = relation
    return [
        {
            "task_id": relation.task_id, "person_id": relation.person_id, "role": relation.role,
            "relation_type": relation.relation_type, "evidence_id": relation.evidence_id,
            "parent_task_id": relation.parent_task_id, "related_task_id": relation.related_task_id,
        }
        for _, relation in sorted(selected.items())
    ]


def _relation_key(relation: object) -> tuple[str, ...]:
    return (
        relation.relation_type, relation.evidence_id, relation.parent_task_id or "",
        relation.related_task_id or "", relation.relation_id,
    )


def _person_efficiency(package: DataPackage, tasks: tuple[object, ...], reports: dict[str, object]) -> list[dict[str, object]]:
    names = {person.person_id: person.name for person in package.roster}
    task_people = {task.task_id: reports[task.report_id].person_id for task in tasks if task.report_id in reports}
    relations = _deduplicated_relations(package, {task.task_id for task in tasks})
    relation_by_person: dict[str, list[dict[str, object]]] = {}
    for relation in relations:
        relation_by_person.setdefault(str(relation["person_id"]), []).append(relation)
    rows: list[dict[str, object]] = []
    for person_id in sorted(set(task_people.values())):
        person_tasks = [task for task in tasks if task_people.get(task.task_id) == person_id]
        person_relations = relation_by_person.get(person_id, [])
        rows.append({
            "person_id": person_id, "name": names.get(person_id, person_id),
            "task_count": len(person_tasks),
            "completed_task_count": sum(task.status == "completed" for task in person_tasks),
            "in_progress_task_count": sum(task.status == "in_progress" for task in person_tasks),
            "blocked_task_count": sum(task.status == "blocked" for task in person_tasks),
            "project_count": len({task.project_candidate_id for task in person_tasks if task.project_candidate_id}),
            "lead_task_count": sum(item["role"] == "lead" for item in person_relations),
            "collaboration_task_count": sum(item["role"] == "collaborator" for item in person_relations),
            "evidence_ids": sorted({str(item["evidence_id"]) for item in person_relations}),
        })
    return sorted(rows, key=lambda item: (-int(item["task_count"]), str(item["person_id"])))


def _project_dynamics(package: DataPackage, tasks: tuple[object, ...]) -> tuple[list[dict[str, object]], list[dict[str, object]]]:
    statuses = {item.project_id: item for item in package.project_statuses}
    projects = {item.project_id: item for item in package.projects}
    names = {item.person_id: item.name for item in package.roster}
    relations = _deduplicated_relations(package, {task.task_id for task in tasks})
    relations_by_task: dict[str, list[dict[str, object]]] = {}
    for item in relations:
        relations_by_task.setdefault(str(item["task_id"]), []).append(item)
    formal: list[dict[str, object]] = []
    unlinked: list[dict[str, object]] = []
    for project_id in sorted({task.project_candidate_id for task in tasks if task.project_candidate_id}):
        project_tasks = [task for task in tasks if task.project_candidate_id == project_id]
        project_relations = [item for task in project_tasks for item in relations_by_task.get(task.task_id, [])]
        status = statuses.get(project_id)
        project = projects.get(project_id)
        row = {
            "project_id": project_id,
            "project_name": (status.project_name if status else None) or (project.standard_name if project else None) or project_id,
            "state": status.state if status else None, "current_stage": status.current_stage if status else None,
            "owner_name": status.owner_name if status else None,
            "lead_people": sorted({names.get(str(item["person_id"]), str(item["person_id"])) for item in project_relations if item["role"] == "lead"}),
            "collaborator_people": sorted({names.get(str(item["person_id"]), str(item["person_id"])) for item in project_relations if item["role"] == "collaborator"}),
            "task_count": len(project_tasks),
            "completed_task_count": sum(task.status == "completed" for task in project_tasks),
            "blocked_task_count": sum(task.status == "blocked" for task in project_tasks),
            "outputs": sorted({task.output for task in project_tasks if task.output}),
            "blockers": sorted({task.blocker for task in project_tasks if task.blocker}),
            "evidence_ids": sorted({str(item["evidence_id"]) for item in project_relations}),
            "snapshot_origin": status.snapshot_origin if status else None,
            "snapshot_captured_at": status.snapshot_captured_at if status else None,
        }
        (formal if status is not None and status.formal else unlinked).append(row)
    return formal, unlinked


def _inactive_workdays(latest: date, end: date, overrides: dict[date, bool]) -> int:
    cursor = latest + timedelta(days=1)
    total = 0
    while cursor <= end:
        total += bool(overrides.get(cursor, cursor.weekday() < 5))
        cursor += timedelta(days=1)
    return total


def _stale_projects(package: DataPackage, report_date: date) -> list[dict[str, object]]:
    overrides = {date.fromisoformat(item.date): item.workday for item in package.workdays}
    threshold = package.manifest.stale_project_threshold_workdays
    rows: list[dict[str, object]] = []
    for status in package.project_statuses:
        if not status.active or status.latest_report_date is None:
            continue
        inactive = _inactive_workdays(date.fromisoformat(status.latest_report_date), report_date, overrides)
        if inactive <= threshold:
            continue
        rows.append({
            "project_id": status.project_id, "project_name": status.project_name,
            "owner_name": status.owner_name, "state": status.state, "current_stage": status.current_stage,
            "latest_report_date": status.latest_report_date, "inactive_workdays": inactive,
            "threshold_workdays": threshold, "blocked_task_count": status.blocked_task_count,
            "snapshot_origin": status.snapshot_origin, "snapshot_captured_at": status.snapshot_captured_at,
        })
    return sorted(rows, key=lambda item: (-int(item["inactive_workdays"]), str(item["project_id"])))


def build_daily_facts(package: DataPackage, report_date: date) -> dict[str, object]:
    """Return only schema-validated facts in deterministic key and array order."""
    metrics = calculate_daily_metrics(package, report_date)
    classifications = classify_people(package, report_date)
    tasks = deduplicated_tasks(package, report_date)
    tasks_by_id = {task.task_id: task for task in tasks}
    report_by_id = {report.report_id: report for report in package.reports if report.date == report_date.isoformat()}
    projects_by_id = {project.project_id: project for project in package.projects}

    people_by_state = {
        state: [_person_fact(item) for item in classifications if item.state == state]
        for state in ("missing", "full_day_leave", "half_day_leave", "review_required")
    }
    work_composition = [
        {
            "task_id": task.task_id, "report_id": task.report_id, "person_id": report_by_id[task.report_id].person_id,
            "time_period": task.time_period, "task_type": task.task_type,
            "project_candidate_id": task.project_candidate_id, "status": task.status,
            "output": task.output, "next_step": task.next_step,
        }
        for task in tasks if task.report_id in report_by_id
    ]
    project_candidates = [
        {
            "project_id": project_id,
            "standard_name": projects_by_id[project_id].standard_name,
            "candidate_names": list(sorted(projects_by_id[project_id].candidate_names)),
            "merge_status": projects_by_id[project_id].merge_status,
            "manual_confirmation_status": projects_by_id[project_id].manual_confirmation_status,
        }
        for project_id in sorted({task.project_candidate_id for task in tasks if task.project_candidate_id in projects_by_id})
    ]
    risk_candidates = [
        {
            "task_id": task.task_id, "person_id": report_by_id[task.report_id].person_id,
            "status": task.status, "risk": task.risk, "blocker": task.blocker,
        }
        for task in tasks if task.report_id in report_by_id
        and (task.status == "blocked" or task.risk is not None or task.blocker is not None)
    ]
    attendance_source_ids = {
        item.source_record_id for item in package.attendance
        if item.date == report_date.isoformat()
    }
    window_start = date.fromisoformat(package.manifest.start_date)
    window_report_ids = {
        report.report_id for report in package.reports
        if window_start <= date.fromisoformat(report.date) <= report_date
    }
    evidence_ids = (
        {report.snapshot_id for report in report_by_id.values()}
        | {relation["evidence_id"] for relation in _deduplicated_relations(package, set(tasks_by_id))}
        | {snapshot["snapshot_id"] for snapshot in package.source_snapshots if snapshot["source_record_id"] in attendance_source_ids}
        | {report.snapshot_id for report in package.reports if report.report_id in window_report_ids}
    )
    evidence = [
        {"evidence_id": snapshot["snapshot_id"], "raw_text": snapshot["raw_record"]}
        for snapshot in sorted(package.source_snapshots, key=lambda item: item["snapshot_id"])
        if snapshot["snapshot_id"] in evidence_ids
    ]
    status_distribution = {
        status: sum(task.status == status for task in tasks)
        for status in ("blocked", "completed", "in_progress", "planned")
    }
    dashboard = calculate_submission_dashboard(package, report_date)
    formal_project_dynamics, unlinked_project_dynamics = _project_dynamics(package, tasks)
    missing_or_half = [
        _person_fact(item) for item in classifications
        if item.state == "missing" or (item.state == "half_day_leave" and item.work_period_status == "missing")
    ]
    reconstructed = [item for item in package.project_statuses if item.snapshot_origin == "reconstructed"]
    report_date_text = package.manifest.report_date or report_date.isoformat()
    continuity = build_project_continuity(package, report_date)
    associations = build_project_associations(package, report_date)
    risk_assessment = build_risk_assessment(package, report_date)
    facts: dict[str, object] = {
        "data_contract_version": "1.2.0",
        "period": {
            "report_date": report_date_text,
            "start_date": package.manifest.start_date,
            "end_date": package.manifest.end_date,
            "timezone": package.manifest.timezone,
        },
        "metrics": asdict(metrics),
        "missing_people": people_by_state["missing"],
        "full_day_leave_people": people_by_state["full_day_leave"],
        "half_day_leave_people": people_by_state["half_day_leave"],
        "review_required_people": people_by_state["review_required"],
        "work_composition": work_composition,
        "status_distribution": status_distribution,
        "project_candidates": project_candidates,
        "collaborations": _deduplicated_relations(package, set(tasks_by_id)),
        "risk_candidates": risk_candidates,
        "attendance_summary": {
            **asdict(dashboard),
            "leave_people": metrics.full_day_leave_people + metrics.half_day_leave_people,
            "missing_people_count": len(missing_or_half),
            "missing_people": missing_or_half,
            "full_day_leave_people": people_by_state["full_day_leave"],
            "half_day_leave_people": people_by_state["half_day_leave"],
            "review_required_people": people_by_state["review_required"],
        },
        "efficiency_summary": _person_efficiency(package, tasks, report_by_id),
        "formal_project_dynamics": formal_project_dynamics,
        "unlinked_project_dynamics": unlinked_project_dynamics,
        "stale_project_alerts": _stale_projects(package, report_date),
        "project_continuity": continuity,
        "project_associations": associations,
        "risk_assessment": risk_assessment,
        "data_quality": {
            "project_status_coverage": "available" if package.project_statuses else "unavailable",
            "reconstructed_project_count": len(reconstructed),
            "limitations": ([
                f"{item.project_name}的历史状态为事后重建（采集时间：{item.snapshot_captured_at or '未知'}）"
                for item in sorted(reconstructed, key=lambda value: value.project_id)
            ] if reconstructed else ([] if package.project_statuses else ["数据包未提供项目状态快照"])),
        },
        "evidence": evidence,
    }
    _validate_facts(facts)
    return facts


def _validate_facts(facts: dict[str, object]) -> None:
    schema = json.loads(_SCHEMA_PATH.read_text(encoding="utf-8"))
    validator = Draft202012Validator(schema, format_checker=FormatChecker())
    errors = sorted(validator.iter_errors(facts), key=lambda error: list(error.absolute_path))
    if errors:
        raise ValueError("daily-facts schema validation failed: " + "; ".join(error.message for error in errors))
