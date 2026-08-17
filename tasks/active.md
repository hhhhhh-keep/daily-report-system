# Task: 配置技能模型超时

## Goal

避免成对 Skill 试运行在模型响应超过固定 180 秒时无条件失败，并保持浏览器端等待时间与后端上限一致。

## Acceptance criteria

- [ ] Skill 模型调用超时可通过配置覆盖，默认值为 300 秒。
- [ ] 前端成对 Skill 试运行请求等待 360 秒，不早于后端超时中断。
- [ ] 保持现有模型请求体、重试逻辑和其他调用路径不变。
- [ ] 后端测试、前端 lint 与构建通过。

## Scope exclusions

- 不更改已保存的模型端点、模型名称或 API Key。
- 不修改 Skill 包、试运行结果或历史业务数据。
- 不引入新的重试策略。

## Verification

```text
cd daily-api; .\mvnw.cmd test
cd daily-web; npm run lint; npm run build
```

