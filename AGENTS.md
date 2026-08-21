# 本地开发与测试环境

- 本项目所称“测试环境”是当前工作区 `E:\AI\codex\daily-report-system-analysis-quality`，必须通过根目录 `dev-start.ps1` 启动。
- 每个新对话在进行开发、验证、数据库访问或部署判断前，必须先读取本文件、`.codex/HARNESS.md`、`tasks/active.md` 和 `dev-start.ps1`。
- `dev-start.ps1` 启动本地 Spring Boot（`http://localhost:8080`）与 Vite（`http://localhost:5180`），并通过 SSH 隧道连接数据库；不要把远端 `drs-dev` Docker 容器误认为本项目的测试环境。
- 本地后端必须使用 JDK 21。若运行中的 API 锁定 `daily-api/target`，在工作区 `.tmp` 的隔离副本中执行 Maven 构建与单元测试，不重启现有服务。
- 不得因本机缺少 Docker/Testcontainers 而替代或跳过 `dev-start.ps1` 的运行期验证。

# 远端正式环境

- 正式环境主机为 `36.213.175.224`，运行容器包括 `docker-daily-api-1`、`docker-daily-web-1`、`docker-nginx-1` 和 `docker-postgres-1`。
- 远端正式环境只用于用户明确授权的诊断、部署或配置操作；默认仅可读取健康状态、容器状态、运行记录和脱敏日志。
- 排查正式故障时，优先读取正式 API 容器日志和 `analysis_runs` 的错误摘要；不得输出日报正文、收件人、模型密钥、数据库凭据或其他敏感配置。
- 不要把远端正式容器与本地测试环境混淆；任何正式环境写操作、重启、迁移、任务试运行或邮件发送都必须获得用户当次明确授权。
