# Plan — 配置技能模型超时

Run: 20260817-111611
Status: awaiting design review

## 设计

- 后端将 Skill LLM 请求超时提取为 `daily.llm.skill-request-timeout`，默认 `PT300S`。
- 前端成对试运行请求超时调整为 360 秒，以覆盖后端处理和回传开销。
- 不改变普通分析的 90 秒超时、模型请求负载、认证或重试策略。

## 验证

- 增加后端配置与适配器覆盖测试。
- 执行后端测试、前端 lint 与生产构建。

