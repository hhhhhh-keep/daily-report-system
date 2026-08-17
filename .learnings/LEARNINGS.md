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

## [LRN-20260817-001] correction

**Logged**: 2026-08-17T11:22:00+08:00
**Priority**: high
**Status**: resolved
**Area**: tests

### Summary
本机开发验证使用 dev-start.ps1 的 SSH 隧道和远程 PostgreSQL，不启动 Docker 或 Testcontainers。

### Details
本次误将本地 Docker/Testcontainers 视作 Maven 全量测试的前提。用户明确指出 `dev-start.ps1` 是本机开发入口；现有项目文档要求后端使用 JDK 21 执行 `mvnw -B -DskipTests compile`，运行期行为由浏览器热重载环境验证。

### Suggested Action
涉及本机开发任务时先读取 `dev-start.ps1` 与 `docs/superpowers/plans/claude-next-action.md`，不要启动 Docker 或运行依赖 Testcontainers 的全量测试。

### Metadata
- Source: user_feedback
- Related Files: dev-start.ps1, docs/superpowers/plans/claude-next-action.md
- Tags: local-dev, verification, testcontainers
- See Also: LRN-20260812-001
- Recurrence-Count: 2

---
