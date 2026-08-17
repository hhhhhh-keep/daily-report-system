# Handoff — 配置技能模型超时

Run: 20260817-111611
Status: complete

LOOP_COMPLETE

Skill 试运行现在默认允许模型响应 300 秒，可通过 `LLM_SKILL_REQUEST_TIMEOUT` 覆盖；浏览器等待 360 秒。运行中的本机后端健康检查为 UP，用户可在 Skills 页面重新执行试运行验证上游模型响应。

