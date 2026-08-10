# Plan - Generate implementation tasks

Status: Planner complete; ready for task generation

## Inputs reviewed

- `specs/001-daily-report-ai-system/spec.md`
- `specs/001-daily-report-ai-system/plan.md`
- `specs/001-daily-report-ai-system/data-model.md`
- `specs/001-daily-report-ai-system/contracts/http-api.md`
- `specs/001-daily-report-ai-system/research.md`
- `specs/001-daily-report-ai-system/quickstart.md`

## Task-generation phases

1. **Foundation and quality gates**: create the Vue 3 `daily-web` and Spring Boot modular-monolith project structure; Docker/environment baseline; PostgreSQL migrations; test fixtures; exact frontend/backend test, lint, build, migration, contract, and container commands. Establish Employee/Project schema and selectable seed/fixture data required by US1, without prematurely implementing the administrator CRUD experience.
2. **US1 / P1 - Submit and update today's report**: implement responsive `/report` and `/my-report`, report options/current-report/save contracts, DailyReport/DailyTask validation and full-collection update, same-day rule, `(employee_id, report_date)` uniqueness, dynamic task UI, formal/non-formal project selection, and regression/e2e coverage for one report with multiple tasks.
3. **US2 / P2 - Manage reports and reference data**: implement the single administrator password/session boundary, `/admin/*` management routes, Employee/Project/dictionary CRUD, report/task read management, configuration entry points, metrics and dashboard views. Preserve the no-employee-account/no-RBAC/no-SSO/no-OAuth constraint.
4. **US3 / P3 - Analyze and distribute management insight**: implement database metrics and deterministic rules, isolated LLM adapter and advisory analysis, configurable rules/prompts/dimensions/schedules/recipients/templates/model settings, Quartz scheduling, HTML/PDF report generation, SMTP email, persisted run records, error visibility, retry, and duplicate-successful-email prevention.
5. **Integration and completion**: contract compatibility, migration/rollback evidence, end-to-end quickstart scenarios, failure/degradation cases, Docker smoke verification, code-quality gates, and scope review for excluded technologies/features.

## User-story coverage requirements

- **US1 tasks** must trace to FR-001 through FR-004 and SC-001 through SC-002. Their independent verification must create, reopen, and update a same-day multi-task report and prove one effective employee/date report remains.
- **US2 tasks** must trace to FR-005, FR-006, and the applicable management portion of FR-010. Their independent verification must manage Employee/Project data, select it in reports, and prove the single-administrator boundary.
- **US3 tasks** must trace to FR-007 through FR-011 and SC-003 through SC-004. Their independent verification must run configured analysis, show selected dimensions/report/run outcome, handle model/email failure, and support safe manual rerun.
- Foundation and completion tasks must preserve FR-012 and FR-013: Vue 3 + Spring Boot modular monolith + PostgreSQL + Docker, with no approval, CRM, performance/timekeeping, multiple roles, microservices, queues, Kubernetes, or external workflow orchestration.

## Strict checklist format for generated `tasks.md`

- Use only Markdown checkbox tasks in the form `- [ ] T### [P] [US#] Concrete action with exact relative file path(s)`.
- Assign sequential, never-reused IDs starting at `T001`. `[P]` is optional and appears only when tasks are independently executable in distinct files/modules. `[US1]`, `[US2]`, and `[US3]` are mandatory for story-specific tasks; foundation and completion tasks have no story label.
- Organize headings in dependency order: Setup, Foundational, US1, US2, US3, Polish/Verification. Put each story's independent test/acceptance tasks at the end of that story section.
- Every task must name the owned file or directory and a concrete observable outcome. Do not use vague tasks such as "implement backend" or "test feature"; split work by module/contract/test boundary.
- Generate tests and contract checks before or alongside the implementation they verify. Include migration, frontend, backend, API-contract, e2e, scheduler failure, email retry, and Docker verification tasks where required by the relevant phase.
- State explicit dependencies and parallel opportunities after the checklist. Do not mark dependent tasks parallel, and do not schedule US2/US3 tasks ahead of their required data/report foundations.
- Do not create tasks for excluded features or new unapproved technology. Generated tasks must leave `docs/design-revision-v2.md` unchanged and keep secrets environment-managed.

## Handoff constraints

This Planner output is an outline only. Do not create `tasks.md`, application code, tests, or change any existing specification/planning artifact in this task. Task generation must use the current on-disk specification artifacts as source of truth.
