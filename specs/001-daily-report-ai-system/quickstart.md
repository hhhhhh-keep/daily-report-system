# 验证与启动指南

## Docker 启动

1. 将 `docker/.env.example` 复制为 `docker/.env`，至少设置强随机的 `POSTGRES_PASSWORD` 和 `ADMIN_INITIAL_PASSWORD`。
2. 可选填写 OpenAI-compatible 的 `LLM_ENDPOINT`（完整 chat-completions URL）、`LLM_MODEL`、`LLM_API_KEY`，以及公司 `SMTP_*`。密钥只由环境变量提供。
   `APP_TIMEZONE` 默认 `Asia/Shanghai`，同时用于“当天”校验和 Quartz 计划。
3. 在仓库根目录运行：

```shell
docker compose --env-file docker/.env -f docker/docker-compose.yml up -d --build
docker compose --env-file docker/.env -f docker/docker-compose.yml ps
```

浏览器访问 `http://localhost:8080/report`；管理入口为 `http://localhost:8080/admin`。

首次启动时，后端用 `ADMIN_USERNAME`（默认 `admin`）和 `ADMIN_INITIAL_PASSWORD` 创建唯一管理员并只保存 BCrypt 散列。数据库已有管理员后，修改环境变量不会覆盖密码；请登录后在“修改密码”页面更新。若初始化密码为空且尚无管理员，应用会拒绝启动。

## 核心场景

1. 管理员创建 Employee、正式 Project 或 non-formal option。
2. 打开 `/report`，选择员工与出勤，新增 morning/afternoon 等任意数量任务并保存。
3. 在 `/my-report` 读取当天日报，修改任务；数据库仍保留一份 `employee_id + report_date` 日报及完整替换后的明细。
4. 在管理端验证日报、任务、主数据和驾驶舱。
5. 在“分析配置”调整确定性阈值、Prompt 版本、维度、Quartz cron、报告/邮件模板、收件人和模型设置；模型/SMTP 密钥仍只来自环境变量。
6. 在“分析中心”立即运行，或等待 Quartz 计划；验证维度结果、运行记录和 HTML/PDF 报告。启用邮件且配置 SMTP 后，报告作为 PDF 附件发送。
7. 模型失败会保留指标/规则并记录部分失败；SMTP 失败可在任务记录中重试。同一分析日期只允许一封成功邮件，重复重试会跳过投递。

## 质量命令

后端需要 Java 21 和 Docker（集成测试使用 Testcontainers）：

```shell
cd daily-api
./mvnw verify
```

前端需要 Node.js 24：

```shell
cd daily-web
npm ci
npm test
npm run lint
npm run build
npm run e2e
```

Playwright 默认测试 `http://localhost:8080`，可通过 `E2E_BASE_URL` 和 `E2E_ADMIN_PASSWORD` 覆盖。端到端套件包含日报创建/修改、管理员基础数据、配置、分析、运行记录、PDF 和本文档快速开始场景。

## 迁移与容器冒烟

应用启动日志应显示 Flyway 成功到 V004，`GET /actuator/health` 返回 `UP`，四个 Compose 服务均为 healthy。迁移备份和恢复步骤见 `daily-api/docs/migration-recovery.md`。

已执行的最终门禁：后端 24 个测试、Checkstyle 和可执行 JAR 构建通过；前端 4 个 Vitest、ESLint、TypeScript/Vite 构建通过；Docker Playwright 3 个端到端场景在真实 PostgreSQL/API 上通过。
