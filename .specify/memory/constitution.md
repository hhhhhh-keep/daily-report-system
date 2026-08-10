<!--
Sync Impact Report
- Version change: 1.0.0 → 1.1.0
- Modified principles: I Requirements Are Traceable → I Modular Monolith and Separated Clients;
  III Testable Delivery → III Testable Delivery and Quality Gates;
  IV Data Integrity and Auditability → IV PostgreSQL, Migrations, and Configuration;
  V Simple, Observable Operations → V Decoupled AI and Scoped Changes
- Added sections: Fixed Technical Constraints
- Removed sections: none
- Follow-up TODOs: define the selected framework, migration tool, and concrete test/lint/build commands
  in the first implementation plan.
-->
# Daily Report System Constitution

## Core Principles

### I. Modular Monolith and Separated Clients
The system MUST remain a modular monolith with clear domain-module boundaries. The frontend and backend
MUST be independently deployable codebases or packages communicating through defined APIs; frontend
code MUST NOT access database internals or backend implementation details.

### II. Requirements and Privacy Are Traceable
Every deliverable MUST map to approved acceptance criteria and a user outcome. Personal, report, and
authentication data MUST use least-privilege access. Secrets MUST NOT appear in source control, logs,
fixtures, client bundles, or hardcoded values.

### III. Testable Delivery and Quality Gates
Core business rules MUST have automated tests at the most suitable boundary. A task is complete only
when its relevant test, lint, and build commands pass. Defects MUST receive a regression test when
practical; a failing quality gate MUST be fixed rather than bypassed.

### IV. PostgreSQL, Migrations, and Configuration
PostgreSQL is the authoritative production database. Every schema or data change MUST be represented by
an ordered, reviewable migration with an explicit rollback or recovery strategy. Configuration, URLs,
credentials, feature switches, and environment-specific behavior MUST use environment variables; code
MUST NOT hardcode environment values.

### V. Decoupled AI and Scoped Changes
AI capabilities MUST be isolated behind explicit interfaces and MUST NOT encode or replace deterministic
business rules. Changes MUST be limited to modules required by the approved task. Modifying unrelated
modules requires a documented dependency reason and explicit review.

## Fixed Technical Constraints

Production deployment MUST use Docker images and documented environment-variable configuration. Plans
MUST state module ownership, API contracts, PostgreSQL migration impact, test coverage for core rules,
and any AI boundary affected. The implementation plan MUST define the exact local `test`, `lint`, and
`build` commands before work begins.

## Development Workflow

Use Spec Kit in order: constitution, specification, plan, tasks, implementation, and verification.
Review every change for principle compliance and update documentation whenever a command, dependency,
or configuration requirement changes. Pull requests MUST state scope, verification evidence, migration
impact, and any privacy or AI-boundary impact.

## Governance

This constitution supersedes conflicting development conventions. Amendments MUST document rationale,
impact on active work, and semantic version bump: MAJOR for incompatible governance changes, MINOR for
new or materially expanded rules, and PATCH for clarifications. Each review MUST confirm compliance and
record justified exceptions in the related specification or pull request.

**Version**: 1.1.0 | **Ratified**: 2026-08-10 | **Last Amended**: 2026-08-10
