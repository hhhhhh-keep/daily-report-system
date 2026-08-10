# Task: daily-report-system-design

## Scope

Plan the architecture document for the Daily Report System. The Builder-owned output is `docs/system-design.md`. It must use approved option B: an admin client, an employee client, and a modular-monolith backend. Reports are submit-only and have no redaction flow.

## Acceptance criteria

- The design document includes goals/scope, system context and deployment topology, client/backend ownership, API boundaries, and core flows.
- It strictly covers: 01 Daily Report Entry and Collection Frontend, 02 Daily Report Display Frontend, 03 Daily Report Management, 04 Data Center, 05 AI Analysis Center, 06 Management Dashboard, 07 Automated Tasks, and 08 System Configuration. Identity, organization, and audit are cross-cutting foundations only, never replacements for the eight modules.
- It includes PostgreSQL entities/relationships, ordered migrations and recovery, Docker runtime boundaries, and environment-variable categories.
- It includes authentication/authorization/audit, report submission constraints, and separation of deterministic business rules from an optional AI adapter.
- It includes phased delivery, contract-first integration, core business-rule test coverage, and a mandatory pre-implementation test/lint/build gate.
- It passes the documentation validation in `tasks/active.md`.

## Plan

1. Document the system context: admin client, employee client, modular-monolith backend, PostgreSQL, optional AI provider, Docker deployment, data flows, and trust boundaries.
2. Define the eight initial modules: 01 Daily Report Entry and Collection Frontend; 02 Daily Report Display Frontend; 03 Daily Report Management; 04 Data Center; 05 AI Analysis Center; 06 Management Dashboard; 07 Automated Tasks; 08 System Configuration. Define responsibility, client/backend ownership, and API boundaries for each.
3. Define identity/access, organization, and audit as cross-cutting foundation capabilities. Clients use API contracts only and never access the database. Define the report submission path, validation, idempotency, authorization, and audit. Reports are submit-only with no approval, redaction, or AI decision flow.
4. State data and operating constraints: PostgreSQL is authoritative; all data changes are ordered migrations with recovery; Docker images and environment-variable injection prevent configuration drift.
5. Provide a staged implementation and verification section. Require the selected stack to supply exact, executable test/lint/build commands before code starts.

## Risks and decisions

- No technology stack or runnable application scripts exist. Do not claim invented test/lint/build commands pass; selecting them is an implementation-entry blocker.
- Reports can contain personal information. No redaction does not remove least-privilege access, storage/transport safeguards, audit, or log hygiene requirements.
- AI reliability, cost, and data-processing restrictions must not affect report submission. AI is optional behind an adapter; deterministic rules remain in business modules.
- Docker and PostgreSQL settings must be environment-driven and migrations controlled to avoid configuration drift and unrecoverable data changes.

## Exact verification commands

```powershell
$doc = Get-Content -Raw docs/system-design.md; @('Option B','two clients','modular monolith','01 Daily Report Entry and Collection Frontend','02 Daily Report Display Frontend','03 Daily Report Management','04 Data Center','05 AI Analysis Center','06 Management Dashboard','07 Automated Tasks','08 System Configuration','PostgreSQL','Docker','environment variables','migration','AI','daily report','submit-only','no approval') | ForEach-Object { if ($doc -notmatch [regex]::Escape($_)) { throw "Missing required design term: $_" } }
$bytes = [IO.File]::ReadAllBytes('docs/system-design.md'); if (([Text.Encoding]::UTF8.GetString($bytes) -match '\?{3,}') -or ($bytes -join ',' -match '239,191,189')) { throw 'Document contains replacement characters or repeated question marks' }
git diff --check
```

Once application projects exist, extend these with actual frontend-1, frontend-2, backend test/lint/build and migration validation commands. No such scripts currently exist.

## Scope exclusions

- This task plans and documents the architecture only. It does not implement applications, migrations, containers, or CI.
- Excludes report redaction, microservices, native mobile, AI auto-approval/decision-making, and unapproved third-party integration.
