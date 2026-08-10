# Task: simplify-access-design

## Scope

Plan a documentation-only update to `docs/system-design.md`. Simplify the approved architecture's access design without changing any code or infrastructure. The entry client uses a controlled collection link instead of employee login. The display client has one administrator account.

## Acceptance criteria

- The document defines the controlled collection-link lifecycle: unguessable identifier, creation/ownership, expiry, administrative disablement, validation before submission, anti-abuse submission limiting, and minimal audit fields.
- The document makes entry access anonymous with respect to employee accounts and makes display access a single authenticated administrator account.
- The document removes employee identities, organization hierarchy, complex RBAC, and organization-scope authorization; it does not replace them with another role model.
- The document preserves administrator authentication, link validation, least privilege, protected transport/storage, secret management, safe logging, and audit.
- The documented change passes the exact verification commands in `tasks/active.md`; no application quality gate is claimed passed.

## Plan

1. Replace the access-model overview with two paths: anonymous report entry through a controlled collection link and administrator-only report display through one managed account.
2. Specify the collection-link controls: cryptographically strong opaque token, expiry timestamp, active/disabled state, validation, anti-abuse rate limit, and minimal audit events. Do not associate a submitted report with an employee account.
3. Specify the one-account administrator boundary: retain administrator authentication and least privilege, but remove employee authentication and all role-, hierarchy-, and organization-scope authorization logic.
4. Update data-flow, API-contract, security, and operations sections consistently: links and administrator credentials are secrets; audit only the minimum submission/access events; do not log raw tokens or report content unnecessarily.
5. Add the documentation verification evidence and retain the implementation-entry quality-gate blocker until real project scripts exist.

## Risks and decisions

- Anonymous entry reduces attribution. Minimal audit must record link, timestamp, request outcome, and abuse-control signal without reconstructing employee identity.
- A leaked collection link can be abused. Opaque high-entropy tokens, expiry, disablement, rate limiting, transport protection, and log redaction are mandatory controls.
- A single administrator account creates an availability and accountability concentration. The design must preserve credential protection and audit without introducing unapproved multi-role/RBAC scope.
- This task only changes the design. Runtime behavior, migrations, and automated quality commands remain unknown until an implementation task and selected stack exist.

## Exact verification commands

```powershell
$doc = Get-Content -Raw docs/system-design.md; @('controlled collection link','unguessable','expiry','disable','rate limit','submission audit','no employee login','single administrator account','administrator authentication','link validation','least privilege') | ForEach-Object { if ($doc -notmatch [regex]::Escape($_)) { throw "Missing required access-design term: $_" } }
@('employee identity','organization hierarchy','complex RBAC','organization-scope authorization') | ForEach-Object { if ($doc -match [regex]::Escape($_)) { throw "Removed access-design term remains: $_" } }
$bytes = [IO.File]::ReadAllBytes('docs/system-design.md'); if (([Text.Encoding]::UTF8.GetString($bytes) -match '\?{3,}') -or ($bytes -join ',' -match '239,191,189')) { throw 'Document contains replacement characters or repeated question marks' }
git diff --check
```

## Scope exclusions

- Do not edit code, schemas/migrations, Docker, CI/CD, tests, or real access-control data.
- Do not implement controlled-link generation/validation, rate limiting, authentication, audit persistence, or an administrator UI.
- Exclude employee accounts, organization hierarchy, complex RBAC, organization-scoped authorization, and approval workflows.
