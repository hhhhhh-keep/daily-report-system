# 环境配置说明

| 环境 | Spring Profile | 启动入口 | 配置来源 | 数据库 |
| --- | --- | --- | --- | --- |
| 本机开发 | `local` | `dev-start.ps1` | 未提交的 `application-local.yml` | 本机/测试库 |
| Docker 测试 | 默认配置 | `docker-compose.dev.yml` | 原有 `.env.example` | `daily_report_dev` |
| 正式 | `prod` | `docker-compose.yml` | `.env.prod.example` | `daily_report` |

测试环境保持原有配置与启动方式不变。正式环境仅使用独立的 `prod` Profile 和 `.env.prod`，避免正式凭据与测试环境混用。

```powershell
# 本机开发（不使用 Docker）
.\dev-start.ps1

# Docker 开发/测试（原有方式）
Copy-Item docker\.env.example docker\.env
docker compose --env-file docker\.env -f docker\docker-compose.dev.yml -p drs-dev up -d

# 正式部署
Copy-Item docker\.env.prod.example docker\.env.prod
docker compose --env-file docker\.env.prod -f docker\docker-compose.yml -p drs-prod up -d
```

不得将 `.env`、`.env.prod` 或 `application-local.yml` 提交到 Git；正式环境不得使用 `docker-compose.dev.yml`。
