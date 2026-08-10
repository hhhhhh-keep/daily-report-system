## [ERR-20260810-001] specify_cli_unavailable

**Logged**: 2026-08-10T00:00:00+08:00
**Priority**: medium
**Status**: pending
**Area**: config

### Summary
The requested `specify init . --integration codex` command is unavailable on PATH.

### Error
```
specify : The term 'specify' is not recognized as the name of a cmdlet, function, script file, or operable program.
```

### Context
- Command: `specify init . --integration codex`
- Working directory: `E:\AI\codex\daily-report-system`

### Suggested Fix
Install the project-approved Specify CLI or invoke it through its documented package runner.

### Metadata
- Reproducible: yes
- Related Files: .learnings/ERRORS.md

---

## [ERR-20260810-004] harness_placeholder_active_task

**Logged**: 2026-08-10T00:00:00+08:00
**Priority**: low
**Status**: resolved
**Area**: config

### Summary
Harness initialization leaves a placeholder `tasks/active.md` that prevents starting the first real task.

### Context
- `Start-CodexHarnessTask.ps1` rejected a new task as active.
- The existing task contained only placeholder text and the handoff state was `ready`.

### Resolution
- **Resolved**: 2026-08-10T00:00:00+08:00
- **Notes**: Replace the untouched placeholder with the current task using the script's force option.

### Metadata
- Reproducible: yes
- Related Files: tasks/active.md

---

## [ERR-20260810-003] unintended_learning_log_staged

**Logged**: 2026-08-10T00:00:00+08:00
**Priority**: medium
**Status**: resolved
**Area**: config

### Summary
The local learning log was included in the initial commit despite the confirmed exclusion scope.

### Context
- Intended commit scope: `.specify/`, `.agents/`
- Unexpected path: `.learnings/ERRORS.md`

### Resolution
- **Resolved**: 2026-08-10T00:00:00+08:00
- **Notes**: Remove the log from the index, amend the initial commit, and force-with-lease push the corrected history.

### Metadata
- Reproducible: unknown
- Related Files: .learnings/ERRORS.md

---

## [ERR-20260810-002] git_author_identity_missing

**Logged**: 2026-08-10T00:00:00+08:00
**Priority**: medium
**Status**: pending
**Area**: config

### Summary
Git cannot create commits because the author name and email are not configured.

### Error
```
fatal: unable to auto-detect email address
```

### Context
- Commit message: `Initialize Spec Kit for Codex`
- Staged paths: `.specify/`, `.agents/`

### Suggested Fix
Configure `user.name` and `user.email` locally for this repository, then retry the commit.

### Metadata
- Reproducible: yes
- Related Files: .learnings/ERRORS.md

---
