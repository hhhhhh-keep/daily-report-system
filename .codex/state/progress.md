# Progress 鈥?fix-smtp-test-validation

Run: 20260818-174859
Status: completed

- 测试邮件改为接收一次性测试收件人和抄送人，不再使用全局 `email_enabled`、正式收件人或正式抄送人。
- 测试环境前端构建通过；SMTP 服务单测在隔离 Java 21 容器中通过。
- 本机测试后端以 JDK 21 启动并返回健康状态；Flyway 仅对该进程临时禁用，未修改测试库。
- 同一份测试源码已部署到生产，四项容器均 healthy。

## 20260819 fix-published-skill-pair-feedback

- 后端发布入口已对已发布版本对直接返回。
- Skills 页面改为“当前版本已发布”并禁用重复操作。
- 服务测试、8 项组件测试、构建、健康检查及重复发布接口均已通过。

## 20260819 simplify-ai-fallback-message

- 新降级任务不再保存校验 JSON；完整技术详情仅留在服务日志。
- 分析中心和 Skills 中心均将历史同类错误显示为简短中文。
- 服务测试、12 项前端组件测试、构建和重启后健康检查均已通过。

