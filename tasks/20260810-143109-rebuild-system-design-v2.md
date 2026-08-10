# Task: rebuild-system-design-v2

## Scope

Plan a from-scratch rebuild of the deleted `docs/system-design.md`. `docs/design-revision-v2.md` is the sole and complete requirements source. This task creates only the design document; it does not create code, infrastructure, or migrations.

## Acceptance criteria

- The document uses one Vue 3 `daily-web` project: `/report` for mobile entry, `/my-report` for same-day report editing, and `/admin/*` for the PC management client. Docker is `nginx`, `daily-web`, `daily-api`, and `postgres`; the backend is a Spring Boot modular monolith using PostgreSQL.
- Access is intentionally minimal: a stable internal fixed report URL with no employee login and a single administrator account with password hash, Session/JWT, password change, and logout. Employee accounts, RBAC, multi-admin roles, SSO, OAuth, and access matrices are excluded.
- The document specifies all exact `DailyReport` and `DailyTask` fields, unique constraint, dynamic task behavior, exact enums for time period, participation role, and current status, and current-day edit semantics using `created_at`/`updated_at` without version management.
- The document specifies Employee/Project fields, administrator-maintained reference data, and non-formal projects used before a formal project code exists.
- It specifies the detailed personnel, project, resource, and report-quality analysis dimensions; program metrics/rules and LLM semantic/advisory responsibilities; built-in Quartz/report/email/SMTP workflow; management configuration; task-run log and retry.
- It shows the final architecture and exclusions, and passes the verification in `tasks/active.md`.

## Plan

1. Rebuild the positioning, scope, and exclusions: an internal lightweight daily-report collection, AI analysis, and management-assistance system. Lock Vue 3 + Spring Boot modular monolith + PostgreSQL + Docker; exclude approval, CRM, performance, timesheet, employee accounts, complex roles/audit, microservices, n8n, queues, and Kubernetes.
2. Define the simplified user paths and one-web-project deployment: a fixed `/report` URL shared internally without employee login; `/my-report` reopens the same employee/date report for current-day view/edit; one `/admin/*` administrator login; `daily-web` routes and responsive mobile/PC ownership; `nginx`, `daily-web`, `daily-api`, `postgres` services.
3. Define exact daily-report data contracts: `DailyReport(id, report_date, employee_id, attendance_status, submitted_at, updated_at, status)` with unique `(employee_id, report_date)`; `DailyTask(id, report_id, time_period, project_id, work_type, participation_role, progress_result, current_status, issue_type, collaboration_role, collaboration_requirement)`; no fixed task-count limit.
4. Define enum and edit behavior: time period = morning, afternoon, full day, ad-hoc time; participation role = primary owner, collaborator, temporary support; current status = completed, normal progress, waiting for feedback, at risk, blocked. A person maintains one valid report per day and can overwrite/update it on that day; only `created_at` and `updated_at` are required, with no version history.
5. Define foundation entities: Employee (`id`, name, team, employee type/position, active flag) and Project (`id`, name, customer, industry, stage, owner, priority, status, nullable code). Require the six non-formal project options: customer expansion, no formal project, internal initiative, department routine work, training/learning, other.
6. Define the report-entry UI contract: date, name, attendance, dynamic task cards with time period/project/work type/role/progress/status; show issue type, required collaboration role, and risk/collaboration need only for exceptions; optional additional notes. Replace morning/afternoon free-text boxes.
7. Define AI analysis in four sections. Personnel: workload, saturation, multi-project concurrency, task switching, role mix, continuous-work trend. Project: progress state, new/ongoing/deepening/completed work, persistent waiting, suspected stagnation, risk aggregation, multi-person collaboration. Resources: missing resource/role, overloaded staff, available capacity, allocation suggestions. Report quality: missing report, missing AM/PM tasks, vague description, missing result, unexplained exception.
8. Define hybrid analysis flow and responsibility: database metrics and program rules calculate attendance, task/project/AM/PM/exception counts, support/waiting streaks, multi-person projects, and concurrency; the LLM analyzes task complexity, workload synthesis, real progress, risk semantics/correlation, resource demand/allocation advice, and management summary. LLM output is advisory only.
9. Define built-in operations: Quartz scheduled comprehensive analysis (configurable, initially daily 22:00), metrics/rules/LLM pipeline, `ReportService` HTML/PDF output, `EmailService` SMTP sending, management configuration for dictionaries, AI rules/Prompt versions, schedule/dimensions, recipients/CC/title/report templates, model configuration, and SMTP secrets through environment variables. Define task-run records, error viewing, and manual retry.
10. End with the final architecture: internal fixed link -> Vue 3 -> Spring Boot modules (report, personnel/project, metrics, rules, AI, Quartz, reports, email, configuration) -> PostgreSQL -> LLM API; company SMTP externally; Docker service boundary. Add the exact verification and quality-gate prerequisite.

## Risks and decisions

- The fixed employee link intentionally does not prove that the selected name is the actual submitter. This internal-tool tradeoff must remain explicit and must not be replaced by the removed controlled-link/token lifecycle.
- Daily uniqueness and same-day overwrite need database/API decisions later; the document specifies the contract only, not migrations or endpoint mechanics.
- Reference `Employee` data supports reporting and uniqueness but is not an employee authentication/account system.
- LLM analysis must remain advisory and separate from deterministic metrics/rules. It must not automatically execute staffing or project decisions.
- Internal scheduled reports/email require future retry, failure, recipient, and SMTP-operations implementation decisions; this task plans their design only.
- There are no application manifests or quality scripts. No test/lint/build result may be inferred from the document task.

## Exact verification commands

```powershell
$doc = Get-Content -Raw docs/system-design.md; @('daily-web','Vue 3','/report','/my-report','/admin/*','Spring Boot','modular monolith','PostgreSQL','nginx','daily-api','postgres','fixed report link','no employee login','single administrator account','password hash','Session/JWT','DailyReport','DailyTask','employee_id + report_date','time_period','morning','afternoon','full day','ad-hoc time','participation_role','primary owner','collaborator','temporary support','current_status','completed','normal progress','waiting for feedback','at risk','blocked','Employee','Project','customer expansion','no formal project','internal initiative','department routine work','training/learning','personnel dimension','project dimension','resource dimension','report quality','program rules','LLM semantic analysis','Quartz','HTML/PDF','EmailService','SMTP','environment variables','task-run records','manual retry','n8n is not used') | ForEach-Object { if ($doc -notmatch [regex]::Escape($_)) { throw "Missing required v2 architecture term: $_" } }
@('controlled collection link','high-entropy token','link validation','link-level rate limit','submission audit','employee account system','complex RBAC','multi-administrator roles','SSO','OAuth','approval workflow','CRM','performance management','timesheet system','microservices','message queue','Kubernetes') | ForEach-Object { if ($doc -match [regex]::Escape($_)) { throw "Removed or excluded design term remains: $_" } }
$bytes = [IO.File]::ReadAllBytes('docs/system-design.md'); if (([Text.Encoding]::UTF8.GetString($bytes) -match '\?{3,}') -or ($bytes -join ',' -match '239,191,189')) { throw 'Document contains replacement characters or repeated question marks' }
git diff --check
```

## Scope exclusions

- Do not change the requirements source, code, schema/migrations, Docker, CI/CD, tests, or runtime configuration.
- Do not implement the web application, backend modules, authentication, data persistence, scheduled jobs, AI, reporting, email, task retry, or deployment.
- Exclude approval, CRM, performance/timesheet systems, employee account system, RBAC/multi-role access, complex audit, microservices, n8n, message queues, Kubernetes, and the former controlled-link/token model.
