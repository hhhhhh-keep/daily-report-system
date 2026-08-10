# Task: revise-system-design-v2

## Scope

Plan a documentation-only v2 revision of `docs/system-design.md`, using the ten supplied requirements as the sole requirements source. The empty `docs/design-revision-v2.md` is not changed. The v2 document replaces prior conflicting access and automation assumptions.

## Acceptance criteria

- The design locks Vue + Spring Boot + PostgreSQL + Docker and describes a modular-monolith backend with two deliberately simple clients: an employee entry client without login and a management client with one administrator account.
- The design removes controlled collection links and their expanded security/audit mechanics, employee identity, organization hierarchy, complex RBAC, and organization-scope authorization.
- The data model and lifecycle cover `DailyReport`, N `WorkTaskDetail` records, `Personnel`, and `Project`; one report per person/day, dynamic task items, and same-day editing.
- The AI section covers effectiveness, saturation, project progress/risk, and resource collaboration/allocation. It separates deterministic program rules from LLM semantic analysis.
- The automation section defines built-in scheduling, analysis, report generation, and email. The management configuration includes AI rules, prompts, execution times, dimensions, and recipients. No external workflow engine is used.
- The document excludes approval, CRM, performance management, multi-role access, and microservices, and passes `tasks/active.md` validation.

## Plan

1. Replace the architecture overview with the fixed stack and boundaries: two Vue clients, Spring Boot modular monolith, PostgreSQL, and Docker. State that employee entry is login-free and the management client has one administrator account.
2. Simplify access and operational design: remove controlled-link lifecycle, employee identity, organization hierarchy, complex RBAC, organization-scope authorization, and expanded security/audit sections. Retain only concise administrator access and necessary operational safeguards.
3. Define the domain model and report behavior: `Personnel`, `Project`, `DailyReport`, and N `WorkTaskDetail`; one report per person/day; dynamic task details; editable on the current day.
4. Define AI responsibilities and boundaries: program rules compute deterministic indicators; LLM semantic analysis interprets narrative/task context. Cover effectiveness, workload saturation, project progress/risk, and resource collaboration/allocation recommendations.
5. Define internal automation and configuration: Spring Boot-owned scheduled analysis, report creation, and email sending; management configuration for AI rules, Prompt, execution times, analysis dimensions, and recipients. Do not use an external workflow engine.
6. Update non-goals, phased implementation guidance, and exact documentation verification. Preserve the block on application work until actual quality commands are available.

## Risks and decisions

- Login-free employee entry intentionally trades identity enforcement for low friction. Do not reintroduce the removed access model in this v2 document.
- Same-day editability needs a clear date boundary and report uniqueness rule when implemented; document the rule without choosing a schema or migration tool.
- AI recommendations are advisory. Program rules remain deterministic and explainable; LLM output must not replace rule evaluation.
- Built-in email scheduling requires future reliability, retry, recipient-validation, and configuration decisions, but this design task must not implement them or add a workflow platform.
- The source note is empty and no application manifests/scripts exist. Requirements are limited to the supplied ten items; test/lint/build status remains unverified.

## Exact verification commands

```powershell
$doc = Get-Content -Raw docs/system-design.md; @('Vue','Spring Boot','PostgreSQL','Docker','modular monolith','no employee login','single administrator account','DailyReport','WorkTaskDetail','Personnel','Project','one report per day','dynamic tasks','current day editable','personnel effectiveness','workload saturation','project progress','risk','resource collaboration','allocation recommendations','program rules','LLM semantic analysis','scheduled analysis','report generation','email delivery','AI rules','Prompt','execution times','analysis dimensions','recipients') | ForEach-Object { if ($doc -notmatch [regex]::Escape($_)) { throw "Missing required v2 design term: $_" } }
@('controlled collection link','employee identity','organization hierarchy','complex RBAC','organization-scope authorization','n8n','approval workflow','CRM','performance management','multi-role access','microservices') | ForEach-Object { if ($doc -match [regex]::Escape($_)) { throw "Removed or excluded design term remains: $_" } }
$bytes = [IO.File]::ReadAllBytes('docs/system-design.md'); if (([Text.Encoding]::UTF8.GetString($bytes) -match '\?{3,}') -or ($bytes -join ',' -match '239,191,189')) { throw 'Document contains replacement characters or repeated question marks' }
git diff --check
```

## Scope exclusions

- Do not modify `docs/design-revision-v2.md`, code, schemas/migrations, containers, CI/CD, tests, or runtime configuration.
- Do not implement user interfaces, APIs, AI integrations, scheduling, reports, email, or persistence.
- Exclude approvals, CRM, performance management, multi-role access, microservices, external workflow engines, employee login, organization hierarchy, complex RBAC, organization-scope authorization, and the prior controlled-link model.
