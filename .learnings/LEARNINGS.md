# Learnings

## [LRN-20260812-001] correction

**Logged**: 2026-08-12T10:55:00+08:00
**Priority**: medium
**Status**: resolved
**Area**: tests

### Summary
Local verification uses the running proxy environment; Docker Desktop and Testcontainers are intentionally out of scope.

### Details
The required local backend check is `./mvnw -B -DskipTests compile`; runtime API and UI verification are performed by the user through the hot-reload environment.

### Suggested Action
Read `docs/superpowers/plans/claude-next-action.md` before selecting verification commands for this task.

### Metadata
- Source: user_feedback
- Related Files: docs/superpowers/plans/claude-next-action.md
- Tags: local-dev, verification, testcontainers

---
