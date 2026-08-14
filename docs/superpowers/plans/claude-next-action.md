# Claude Next Action

Owner: User (reviewer)
Reviewer: Claude (autonomous dev session on cloud)
Status: action_required

## Current State

Cloud dev compose 上 PG 起来了，但本地 Docker Desktop 没有 Linux engine，
`./mvnw verify` 的 12 个集成测试卡在 Testcontainers 拉 daemon。
这条信息是 User 的回复：你不用为了验证改而去打镜像、跑 Testcontainers。
本地 dev 已经配好，热重载链路打通——验证由 User 在浏览器里做。

User 已在浏览器里看过几个页面，发现 UI/数据展示有几处需要修（见 #2-#4）。

## Required Fixes

### 1. 跳过 Testcontainers / Docker Desktop 验证路径

- **File(s):** N/A（流程改动，不动代码）
- **Problem:** 后端集成测试用 Testcontainers 拉本地 Docker Desktop daemon，
  引擎管道 `//./pipe/dockerDesktopLinuxEngine` 不存在，verify 失败。
- **Requirement:** 你不需要为验证代码改动而起 Docker / Testcontainers。
  本地 dev 环境已就位，User 自己验证：
  - 前端 Vite HMR —— http://localhost:5180
    （保存 .vue/.ts 即热替换，无需重启）
  - 后端 Spring Boot DevTools —— http://localhost:8080
    （保存 .java 后 `./mvnw -DskipTests compile` → DevTools 在 ~5.5s 内重启 context，
    PID 不变，浏览器无需刷新）
  - PG —— `127.0.0.1:5432` 通过 SSH 隧道到 `36.213.175.224:5432`
    → `drs-dev-postgres-1` 容器（dev compose `-p drs-dev`，库 `daily_report_dev`，
    用户 `drs_pg_admin / 1qaz@WSX`）
- **Allowed minimal fix(es):**
  - 继续做业务代码改动、Flyway 迁移、数据校验、字典配置、文档更新。
    这些交付不需要 Docker 跑得起来。
  - 想确认编译通过：`./mvnw -B -DskipTests compile`（不要跑 `verify`）。
  - Testcontainers 集成测试 / Docker Desktop 路径挂起，等以后单独规划。
- **Required verification:** `./mvnw -B -DskipTests compile` exit 0。
  其它运行期验证（业务行为、UI、API 响应）由 User 在本地浏览器完成，不需要你执行。

### 2. 报告详情页（图2）只显示部分任务字段，缺少采集表（图3）的字段

- **File(s):** `daily-web/src/views/admin/AdminReportsView.vue`（"查看任务" 抽屉/弹窗部分），
  以及后端 `daily-api` 对应 admin reports 接口的 DTO
- **Problem:** 详情面板只渲染了 `任务 1 · 时段 · 项目 · 内容 · 状态（blocked）`，
  缺失以下采集表（图3）的字段：
  - **工作任务类型**（行业/项目支撑 等）
  - **阶段分类**
  - **工作阶段**
  - **参与角色**（主责 等）
  - **当前状态**（进行中 等）
- **Requirement:** 详情面板要把 DailyTaskForm 的全部字段都展示出来。
  字段顺序、标签中文与采集表保持一致；如果某个字段为空也要渲染出来（显示"-"占位）。
  数据来源：后端 admin reports list 接口当前返回的 DTO 是否包含这些字段？
  如果没有，先把 DTO 加全，再让前端读。
- **Allowed minimal fix(es):**
  - 后端：扩展 report list 详情 DTO，把 DailyTask 的完整字段暴露出来（无需新增表）。
  - 前端：AdminReportsView.vue 详情区按 DailyTaskForm 的字段顺序逐项渲染。
  - 字段为 null/空时显示 `-` 而不是隐藏整行。
- **Required verification:** User 在浏览器重新加载 http://localhost:5180/admin/reports ，
  点击任一行的"查看任务"，确认 6+ 字段都出现。

### 3. 报告列表页（图1）缺少搜索/筛选功能

- **File(s):** `daily-web/src/views/admin/AdminReportsView.vue`
- **Problem:** 顶部只有一个"报告日期"日期选择器，没有任何按员工 / 关键字 / 状态的筛选。
  数据多了之后无法定位记录。
- **Requirement:** 在日期选择器旁加：
  - 员工下拉（与 AdminEmployeesView 类似，从字典接口拉）
  - 关键字搜索框（匹配"项目名称"或"工作内容"，不区分大小写）
  - 任务状态 / 出勤状态 chips（多选过滤）
  前端做去抖 / 节流，服务端走 query param 过滤即可，不必改表结构。
- **Allowed minimal fix(es):**
  - 前端：组件层做本地过滤或拼 query param 调 admin reports 接口。
  - 后端：如果接口当前不支持多条件过滤，加上 `employeeId` / `keyword` / `status`
    这几个可选 query param，按需模糊查询。
- **Required verification:** 输入"test1"只剩 test1 的行；勾上"leave"只显示请假的记录。

### 4. 报告列表与详情有英文字段（present / leave / blocked / morning），需中文 i18n

- **File(s):**
  - 前端：`daily-web/src/views/admin/AdminReportsView.vue`、
    `daily-web/src/components/report/DailyTaskForm.vue`、相关 `daily-web/src/api/*.ts`
  - 后端：对应 DTO / enum（`daily-api/src/main/java/.../dto/` 与 `domain/enums/`）
- **Problem:** UI 显示英文枚举值（出勤 `present`/`leave`，任务状态 `blocked`，
  时段 `morning`），跟整个系统中文风格不一致。
- **Requirement:** 这些枚举值要么：
  - (a) 前后端都改为中文常量（数据库值同步迁移，破坏性，看你判断），或
  - (b) 前端做 i18n 映射表（推荐，不改数据），展示时把 `present → 出勤`、
    `leave → 请假`、`blocked → 阻塞`、`morning → 上午`、`afternoon → 下午` 等。
- **Allowed minimal fix(es):**
  - 在前端 `src/i18n/` 或组件里加一个 `attendanceLabel` / `taskStatusLabel` / `periodLabel`
    枚举映射函数；任何展示位置都走映射，禁止直接渲染英文。
  - 后端不改（保持英文 enum 与 DB 值不变）。
  - 字典里如果有"出勤类型 / 任务状态 / 时段"配置项，优先从字典拉，没字典再走静态映射。
- **Required verification:** 列表和详情页英文不再出现，全部中文。

## Required Verification Before Returning

```bash
cd /daily-report-system/daily-api
./mvnw -B -DskipTests compile
```

应输出 `BUILD SUCCESS`。前端 type-check：`cd /daily-report-system/daily-web && npm run build`
（或 `vue-tsc --noEmit` 如果装了）。

User 在浏览器刷新页面后**手动验证** UI 行为（详情字段、搜索、中文展示）。

## Required Documentation Updates

如果改了 admin reports 接口的 query param，更新 API 文档（本项目暂无独立 API 文档，可跳过）。

## Scope Guard

**在本轮内做**：
- #2 详情字段补全
- #3 列表搜索/筛选
- #4 英文枚举中文 i18n 映射
- 业务逻辑 / Service / Controller 改动以支持 #2-#4
- Flyway 迁移文件改动（如果 #2 需要新增列）
- 字典 / 业务配置改动
- `mvnw compile` 自检

**本轮不做**：
- 跑 `./mvnw verify` / 跑集成测试
- 启动 Docker Desktop 或为 Testcontainers 配环境
- 打包镜像 / `docker compose build`
- 重启 dev compose 任何 service（除非显式需要）
- 改 prod 数据库 schema（dev 库 `daily_report_dev` 可改，prod `daily_report` 不要碰）