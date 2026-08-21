# Progress — daily-analysis-json-reliability

Run: 20260821-091959
Status: code verification passed; local 22:10 observation pending

Implementation and verification evidence (2026-08-21):

- 17:30/22:00 快照任务维持纯快照职责；`PeriodAnalysisScheduleManager` 恢复根据启用配置
  注册唯一的 DAILY 22:10 分析触发器。
- `LlmAnalysisAdapter` 从规则包指令提取 JSON Schema，并请求 OpenAI 兼容的
  `response_format.json_schema`（`strict=true`）。端点以 HTTP 4xx 拒绝时，在同一调用内回退
  为 `json_object`，随后仍由本地 Skill 校验器拦截不合规输出。
- `SkillPackageValidator` 将已验证的规则包 Schema 作为 `ValidatedSkillPackage` 的字段；首轮和
  修复轮均由同一带 Schema 的指令驱动。修复输入继续携带原候选和 Python 校验器的机器可读错误。
- 隔离 JDK 21 定向 Java 回归：21 tests, 0 failures, 0 errors
  (`PeriodAnalysisScheduleManagerTest` 1、`LlmAnalysisAdapterTest` 7、
  `SkillAnalysisExecutorTest` 13)。
- 配置的 Python 3.12 全量 Skill 回归：49 tests, 0 failures, 0 errors；其中包括脱敏的
  2026-08-20 人员姓名遗漏、必填分析区块遗漏两类故障签名。
- 隔离 JDK 21 Maven `-DskipTests package` 通过，Checkstyle 0 violations。

The test environment is the local workspace launched by `dev-start.ps1`, not a remote development
container. Restart the existing local process through `dev-start.ps1` before observing the next
22:10 scheduled DAILY analysis; no production action has occurred.

Additional local UI incident evidence (2026-08-21):

- The report entry view used one `loading` flag for two unrelated operations: loading report options
  and loading an already-submitted report after selecting an employee. The latter replaced the form
  with the misleading “正在加载日报选项…” message.
- The employee search-value watcher could continuously retrigger the submitted-report read. Local
  backend logs recorded repeated reads for the same employee; the final repeated read was at
  13:58:26 after the watcher was removed.
- `optionsLoading` now isolates the initial option request, while employee selection uses `loading`.
  Targeted frontend regression: 11 tests passed; frontend production build passed. The local proxy
  returned HTTP 200 for both `/api/report/options` and the existing-report lookup after the change.

Deployment record (2026-08-21):

- Commit `42a9a4d` was pushed to `origin/master` and deployed to the production API/Web containers.
  The deployment created `/daily-report-system/.deploy-backups/release-42a9a4d-20260821-163600`
  before replacing only application source; database, `.env`, and log volumes were not changed.
- Production API/Web/Nginx health checks passed after the rebuild.
- Rule Skill `daily-work-analysis` v3.1.5 and document template v3.2.7 were built and fully tested
  locally. On 2026-08-21, at the user's explicit direction, both ZIP packages were integrity-checked
  and written directly to the production Skills version store as DAILY drafts (RULE v3, TEMPLATE v3).
  Their stored package sizes match the validated local packages. No LLM invocation, trial, publish,
  or email send occurred; the administrator will initiate the trial manually.

