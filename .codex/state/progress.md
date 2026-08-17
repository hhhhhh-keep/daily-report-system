# Progress — 配置技能模型超时

Run: 20260817-111611
Status: completed

## Builder evidence

- `EnvironmentProperties.Llm` 新增 `skillRequestTimeout`，默认 300 秒；`application.yml` 支持 `LLM_SKILL_REQUEST_TIMEOUT` 覆盖。
- `LlmAnalysisAdapter.analyzeSkill` 使用该属性；普通分析保留原 90 秒超时。
- 成对 Skill 试运行的前端 Axios 超时已调整为 360 秒。
- 红绿测试：后端 `LlmAnalysisAdapterTest` 6/6 通过；前端 `admin-skills.spec.ts` 1/1 通过。
- 回归：JDK 21 `mvnw.cmd -B -DskipTests compile` 成功；前端 `npm test` 29/29、lint、build 成功；`/actuator/health` 为 UP。

