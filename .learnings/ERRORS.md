## [ERR-20260810-001] specify_cli_unavailable

**Logged**: 2026-08-10T00:00:00+08:00
**Priority**: medium
**Status**: pending
**Area**: config

### Summary
The requested `specify init . --integration codex` command is unavailable on PATH.

### Error
```
specify : The term 'specify' is not recognized as the name of a cmdlet, function, script file, or operable program.
```

### Context
- Command: `specify init . --integration codex`
- Working directory: `E:\AI\codex\daily-report-system`

### Suggested Fix
Install the project-approved Specify CLI or invoke it through its documented package runner.

### Metadata
- Reproducible: yes
- Related Files: .learnings/ERRORS.md

---

## [ERR-20260819-072] backend_maven_not_on_path

**Logged**: 2026-08-19T13:51:00+08:00
**Priority**: low
**Status**: resolved
**Area**: tests

### Summary
当前 PowerShell 会话未配置全局 `mvn` 命令，后端验证应使用项目自带 Maven Wrapper。

### Error
```
mvn: The term 'mvn' is not recognized as a name of a cmdlet, function, script file, or executable program.
```

### Resolution
- **Resolved**: 2026-08-19T13:51:00+08:00
- **Notes**: 改用 `daily-api\\mvnw.cmd`，避免依赖机器级 Maven PATH 配置。

### Metadata
- Reproducible: yes
- Related Files: daily-api/mvnw.cmd

---

## [ERR-20260819-071] frontend_test_wrong_workdir

**Logged**: 2026-08-19T00:00:00+08:00
**Priority**: low
**Status**: resolved
**Area**: verification

### Summary
定向前端测试误在仓库根目录运行，`npx` 使用了临时 Vitest，未加载项目别名配置。

### Resolution
- 切换到 `daily-web` 后使用项目锁定的测试依赖执行。

---

## [ERR-20260819-070] chinese_integrity_scan_regex

**Logged**: 2026-08-19T00:00:00+08:00
**Priority**: low
**Status**: resolved
**Area**: verification

### Summary
中文完整性扫描把 `????` 当作正则量词，导致 `rg` 表达式无效。

### Resolution
- 改用固定字符串匹配逐项扫描。

---

## [ERR-20260819-065] harness_task_state_write_denied

**Logged**: 2026-08-19T00:00:00+08:00
**Priority**: low
**Status**: open
**Area**: workflow

### Summary
启动“导入官方工作日历”任务时，Harness 无法写入 `.codex/state/progress.md`。

### Error
```
Access to the path '...\\.codex\\state\\progress.md' is denied.
```

### Context
- 已使用 `-Force` 切换到用户明确授权的新任务。
- 代码和验证记录将先落在 `tasks/`，待状态目录权限恢复后补齐 Harness 状态文件。

---

## [ERR-20260819-066] calendar_maven_target_lock

**Logged**: 2026-08-19T00:00:00+08:00
**Priority**: low
**Status**: resolved
**Area**: verification

### Summary
本机开发后端占用 `daily-api/target/classes`，直接 Maven 编译无法覆盖类文件。

### Error
```
error writing DailyApiApplication: ... target/classes/...class
```

### Resolution
- 使用独立临时副本执行后端单元测试，不停止正在运行的测试后端。

---

## [ERR-20260819-067] calendar_verify_workdir

**Logged**: 2026-08-19T00:00:00+08:00
**Priority**: low
**Status**: resolved
**Area**: verification

### Summary
独立 Maven 副本首次执行时未切换工作目录，Maven 从仓库根目录查找 `pom.xml`。

### Resolution
- 后续在副本目录中执行 Maven Wrapper。

---

## [ERR-20260819-068] vitest_mock_hoisting

**Logged**: 2026-08-19T00:00:00+08:00
**Priority**: low
**Status**: resolved
**Area**: test

### Summary
工作日历组件测试的 mock 引用了被 Vitest 提升前尚未初始化的变量。

### Resolution
- 将 spy 定义改为 `vi.hoisted`，确保 mock 工厂执行前可用。

---

## [ERR-20260819-069] official_notice_html_entities

**Logged**: 2026-08-19T00:00:00+08:00
**Priority**: medium
**Status**: resolved
**Area**: calendar-import

### Summary
中国政府网公告正文使用数字 HTML 实体表示句号，首版仅移除标签导致落款日期被并入节假日段。

### Resolution
- 在解析前解码数字 HTML 实体，并以同一官方公告重新验证识别数量。

---

## [ERR-20260819-064] local_flyway_v026_checksum_mismatch

**Logged**: 2026-08-19T00:00:00+08:00
**Priority**: medium
**Status**: resolved
**Area**: config

### Summary
本地测试环境连接的既有数据库中，V026 的历史校验和与当前源码不一致，Flyway 因安全校验阻止应用启动。

### Error
```
Migration checksum mismatch for migration version 026
Applied: 1746183818; resolved locally: 604648173
```

### Resolution
- **Resolved**: 2026-08-19T00:00:00+08:00
- **Notes**: 仅在 `application-local.yml` 禁用 Flyway，保留数据库和正式环境迁移校验不变。

### Metadata
- Reproducible: yes
- Related Files: daily-api/src/main/resources/application-local.yml

---

## [ERR-20260819-063] local_log_directory_not_overridden

**Logged**: 2026-08-19T00:00:00+08:00
**Priority**: medium
**Status**: resolved
**Area**: config

### Summary
本地 Spring Boot 启动沿用了生产日志目录 `/var/log/daily-api`，Windows 下无权限创建，导致应用在初始化日志时退出。

### Error
```
RollingFileAppender openFile(/var/log/daily-api/daily-api.log,true) failed: Access denied
```

### Resolution
- **Resolved**: 2026-08-19T00:00:00+08:00
- **Notes**: 日志配置支持 `DAILY_LOG_DIRECTORY` 覆盖；本地启动脚本显式写入工作区日志目录，生产默认路径不变。

### Metadata
- Reproducible: yes
- Related Files: daily-api/src/main/resources/logback-spring.xml, dev-start.ps1

---

## [ERR-20260819-061] testcontainers_docker_unavailable

**Logged**: 2026-08-19T00:00:00+08:00
**Priority**: medium
**Status**: pending
**Area**: tests

### Summary
后端集成测试已完成编译，但 Testcontainers 未找到可用 Docker 环境，业务测试未执行。

### Error
```
IllegalStateException: Could not find a valid Docker environment
```

### Context
- 独立验证副本使用 JDK 21，主代码与测试代码均已编译完成。
- `CurrentReportServiceTest` 依赖 PostgreSQL Testcontainer。

### Suggested Fix
在具备 Docker 环境的 CI 或开发机上执行 `CurrentReportServiceTest`。

### Metadata
- Reproducible: yes
- Related Files: daily-api/src/test/java/com/company/daily/report/CurrentReportServiceTest.java

---

## [ERR-20260819-062] process_commandline_access_denied

**Logged**: 2026-08-19T00:00:00+08:00
**Priority**: low
**Status**: resolved
**Area**: infra

### Summary
诊断 Java 测试进程命令行时，Windows WMI 拒绝读取该进程信息。

### Error
```
Get-CimInstance Win32_Process: 拒绝访问
```

### Resolution
- **Resolved**: 2026-08-19T00:00:00+08:00
- **Notes**: 改为读取 Surefire 测试报告确认实际失败原因。

### Metadata
- Reproducible: yes
- Related Files: none

---

## [ERR-20260819-060] powershell_maven_property_quoting

**Logged**: 2026-08-19T00:00:00+08:00
**Priority**: low
**Status**: resolved
**Area**: tests

### Summary
PowerShell 调用 Maven 时未引用带点的 `-D` 属性，属性名称被错误拆解为生命周期参数。

### Error
```
Unknown lifecycle phase ".build.directory=target-verify"
```

### Resolution
- **Resolved**: 2026-08-19T00:00:00+08:00
- **Notes**: 以单引号传递完整 Maven `-Dproject.build.directory=...` 参数。

### Metadata
- Reproducible: yes
- Related Files: daily-api/pom.xml

---

## [ERR-20260819-058] maven_source_encoding

**Logged**: 2026-08-19T00:00:00+08:00
**Priority**: high
**Status**: resolved
**Area**: backend

### Summary
Maven 编译未固定 UTF-8，在 Windows 默认字符集下将大量既有中文 Java 源码误读为语法错误。

### Error
```
Compilation failure across existing Java source files with garbled Chinese diagnostics
```

### Context
- 失败文件横跨 admin、analysis、configuration 等未改动模块。
- 本次变更仅涉及 `CurrentReportService` 与其测试。

### Suggested Fix
在测试命令中将 `JAVA_HOME` 指向本机 JDK 21；不改动全局环境配置。

### Metadata
- Reproducible: yes
- Related Files: daily-api/pom.xml

### Resolution
- **Resolved**: 2026-08-19T00:00:00+08:00
- **Notes**: 根因是 `JAVA_HOME` 指向 JDK 8，而非源码编码。

---

## [ERR-20260819-059] maven_running_backend_class_lock

**Logged**: 2026-08-19T00:00:00+08:00
**Priority**: low
**Status**: resolved
**Area**: backend

### Summary
正在运行的本地后端锁住 Maven 默认构建目录中的 class 文件，导致验证编译无法覆盖。

### Error
```
error writing DailyApiApplication: target/classes/.../DailyApiApplication.class
```

### Resolution
- **Resolved**: 2026-08-19T00:00:00+08:00
- **Notes**: 改用独立的 `target-verify` 构建目录，不中断本地服务。

### Metadata
- Reproducible: yes
- Related Files: daily-api/target/classes

---

## [ERR-20260819-057] admin_projects_label_test_setup

**Logged**: 2026-08-19T00:00:00+08:00
**Priority**: low
**Status**: resolved
**Area**: tests

### Summary
项目分类文案测试未先打开新增窗口，导致断言了未渲染的表单文本。

### Error
```
expected wrapper text to contain '正式项目（未勾选为专项工作）'
```

### Resolution
- **Resolved**: 2026-08-19T00:00:00+08:00
- **Notes**: 测试先触发“新增正式项目 / 专项工作”再检查表单文案。

### Metadata
- Reproducible: yes
- Related Files: daily-web/tests/views/admin-projects.spec.ts

---

## [ERR-20260819-056] harness_state_write_denied

**Logged**: 2026-08-19T00:00:00+08:00
**Priority**: low
**Status**: resolved
**Area**: docs

### Summary
Harness 已创建本次任务文件，但写入受保护的 `.codex/state` 文件时被拒绝。

### Error
```
Access to the path '.codex\\state\\critique.md' is denied.
```

### Resolution
- **Resolved**: 2026-08-19T00:00:00+08:00
- **Notes**: 已创建的 `tasks/active.md` 作为本次任务记录；用允许的补丁方式维护验收和验证证据。

### Metadata
- Reproducible: yes
- Related Files: .codex/state/critique.md, tasks/active.md
- See Also: ERR-20260819-054

---

## [ERR-20260819-055] harness_completion_marker

**Logged**: 2026-08-19T00:00:00+08:00
**Priority**: low
**Status**: resolved
**Area**: docs

### Summary
Harness 只识别独立的 `LOOP_COMPLETE` 行，现有交接文件仅把它写在状态字段中，导致新任务被阻止。

### Error
```
The active task is not complete. Finish it first, or pass -Force to intentionally replace it.
```

### Resolution
- **Resolved**: 2026-08-19T00:00:00+08:00
- **Notes**: 为已通过复核的旧任务补充独立完成标记，再正常启动新任务。

### Metadata
- Reproducible: yes
- Related Files: .codex/state/handoff.md
- See Also: ERR-20260819-054

---

## [ERR-20260819-054] harness_start_active_task

**Logged**: 2026-08-19T00:00:00+08:00
**Priority**: low
**Status**: resolved
**Area**: docs

### Summary
Harness 启动脚本未将验收项全部勾选的 active 任务识别为完成，阻止新任务启动。

### Error
```
The active task is not complete. Finish it first, or pass -Force to intentionally replace it.
```

### Context
- `tasks/active.md` 的验收项已完成，但缺少脚本所需的完成状态标记。

### Resolution
- **Resolved**: 2026-08-19T00:00:00+08:00
- **Notes**: 使用 `apply_patch` 更新任务记录，避免用 `-Force` 覆盖现有状态。

### Metadata
- Reproducible: yes
- Related Files: tasks/active.md
- See Also: ERR-20260818-HARNESS-STATE-001

---

## [ERR-20260818-RG-010] regex_escaping

**Logged**: 2026-08-18T18:10:00+08:00
**Priority**: low
**Status**: resolved
**Area**: tooling

### Summary
实体字段检索时，`rg` 正则表达式中的括号未正确转义，导致命令解析失败。

### Resolution
- 后续优先使用固定文本模式或 `-e` 指定多个模式；复杂正则先单独验证。

---

## [ERR-20260818-PATCH-011] duplicate_patch_target

**Logged**: 2026-08-18T18:11:00+08:00
**Priority**: low
**Status**: resolved
**Area**: tooling

### Summary
一次 `apply_patch` 同时对同一文件使用删除和新增操作，补丁格式被拒绝。

### Resolution
- 改为每个文件使用单一更新补丁，避免重复目标操作。

---

## [ERR-20260818-PATCH-012] protected_harness_state

**Logged**: 2026-08-18T18:12:00+08:00
**Priority**: low
**Status**: resolved
**Area**: tooling

### Summary
`apply_patch` 无法删除 `.codex/state/plan.md`，该 Harness 状态目录受运行环境保护。

### Resolution
- 尝试以原子更新方式维护状态；若仍受限，在任务记录中保留状态并在交付时明确说明。

---

## [ERR-20260818-TOOLS-013] missing_local_postgres_cli

**Logged**: 2026-08-18T18:13:00+08:00
**Priority**: low
**Status**: resolved
**Area**: tooling

### Summary
本机环境未安装 `psql` 和 `pg_dump`，不能直接使用 PostgreSQL CLI 导出测试库。

### Resolution
- 改用已部署 PostgreSQL 容器中的客户端，并通过 SSH 隧道访问本机测试数据库。

---

## [ERR-20260818-MAVEN-014] wrong_working_directory

**Logged**: 2026-08-18T18:15:00+08:00
**Priority**: low
**Status**: resolved
**Area**: verification

### Summary
从仓库根目录调用 Maven Wrapper，Wrapper 未切换至 `daily-api`，因此找不到 `pom.xml`。

### Resolution
- 后续以 `daily-api` 为工作目录调用 `mvnw.cmd test`。

---

## [ERR-20260818-MAVEN-015] local_source_encoding

**Logged**: 2026-08-18T18:16:00+08:00
**Priority**: medium
**Status**: open
**Area**: verification

### Summary
本机 Maven 使用 Java 17 编译要求 Java 21 的源码，导致 `record`、文本块等语法被错误解析并显示为乱码。

### Resolution
- 本次日志与定向同步不修改业务 Java 源码；部署验证使用生产 Docker（Java 21）构建与运行结果。后续本地验证须切换 JDK 21。

---

## [ERR-20260818-COMPOSE-016] missing_local_deploy_env

**Logged**: 2026-08-18T18:18:00+08:00
**Priority**: low
**Status**: resolved
**Area**: verification

### Summary
本机直接执行 Compose 配置校验时未提供生产 `.env`，必填数据库变量未展开。

### Resolution
- 不在本机创建或复制生产凭据；部署后使用服务器保留的 `docker/.env` 执行 Compose 校验。

---

## [ERR-20260818-SYNC-017] reverse_tunnel_rejected

**Logged**: 2026-08-18T18:20:00+08:00
**Priority**: medium
**Status**: resolved
**Area**: security

### Summary
为同步测试数据建立本机 PostgreSQL 反向隧道的操作被安全策略拒绝，因为这会临时向远端开放整个测试数据库端口。

### Resolution
- 改为在本机只导出已授权的人员和技术连接字段，并通过加密 SSH 标准输入直接导入生产库；不开放端口，不产生完整数据库转储。

---

## [ERR-20260818-SYNC-018] sensitive_connection_sync_requires_consent

**Logged**: 2026-08-18T18:24:00+08:00
**Priority**: medium
**Status**: blocked
**Area**: security

### Summary
定向同步脚本包含模型 API Key 和 SMTP 密码。安全策略要求用户明确确认跨环境复制这些凭据，不能仅依据“同步技术连接数据”推定授权。

### Resolution
- 已停止导入。待用户明确授权后，只传输已列明的模型和 SMTP 凭据字段，不迁移其他配置或业务数据。

---

## [ERR-20260818-VERIFY-019] postgres_container_os_user

**Logged**: 2026-08-18T18:28:00+08:00
**Priority**: low
**Status**: resolved
**Area**: verification

### Summary
生产 PostgreSQL 容器中不存在与数据库角色同名的 Linux 用户，`docker exec -u` 查询失败。

### Resolution
- 使用容器默认用户，并通过容器注入的 PostgreSQL 环境变量进行数据库认证。

---

## [ERR-20260818-SYNC-020] windows_pipe_encoding

**Logged**: 2026-08-18T18:32:00+08:00
**Priority**: medium
**Status**: resolved
**Area**: data-sync

### Summary
Windows Java 进程向 SSH 管道输出中文人员数据时使用本地代码页，生产 PostgreSQL 以 UTF-8 读取，导入事务在首条中文记录处回滚。

### Resolution
- 明确以 `-Dfile.encoding=UTF-8` 运行导出程序后重试；失败事务未提交，因此生产人员数据未被部分写入。

---

## [ERR-20260818-SYNC-021] powershell_java_option_parsing

**Logged**: 2026-08-18T18:33:00+08:00
**Priority**: low
**Status**: resolved
**Area**: data-sync

### Summary
PowerShell 调用 Java 时，`-Dfile.encoding=UTF-8` 未作为 JVM 选项传递，Java 将其误当为类名。

### Resolution
- 使用 `JAVA_TOOL_OPTIONS` 注入 UTF-8 JVM 选项，避免 PowerShell 参数解析差异。

---

## [ERR-20260818-HARNESS-022] completed_task_not_recognized

**Logged**: 2026-08-18T18:40:00+08:00
**Priority**: low
**Status**: resolved
**Area**: tooling

### Summary
Harness 已记录上一任务 `LOOP_COMPLETE`，但启动新诊断任务时仍判定 `tasks/active.md` 未完成。

### Resolution
- 本次只读诊断不覆盖已完成任务；在现有 Harness 状态中记录诊断证据。

---

## [ERR-20260818-LOG-023] remote_pipeline_quoting

**Logged**: 2026-08-18T18:41:00+08:00
**Priority**: low
**Status**: resolved
**Area**: diagnostics

### Summary
PowerShell 将 SSH 远端命令中的 `grep` 正则管道误解析为本地表达式，日志检索未执行。

### Resolution
- 使用 Base64 编码的远端 shell 脚本执行只读日志筛选，避免多层引号与管道冲突。

---

## [ERR-20260818-LLM-024] nested_sql_quoting

**Logged**: 2026-08-18T18:43:00+08:00
**Priority**: low
**Status**: resolved
**Area**: diagnostics

### Summary
生产配置只读查询中为避免输出密钥而拼接的 SQL 字符串字面量在远端 shell 层被改写，导致语法错误。

### Resolution
- 改用不含字符串字面量的 `length(model_api_key)` 只读校验，避免多层引号。

---

## [ERR-20260818-EMAIL-025] missing_migration_file_lookup

**Logged**: 2026-08-18T18:46:00+08:00
**Priority**: low
**Status**: resolved
**Area**: diagnostics

### Summary
检查周期邮件配置迁移时引用了不存在的 V025 文件名，附加读取失败。

### Resolution
- 邮件测试失败原因已由服务代码明确：全局 `email_enabled` 未开启；后续以运行库配置字段为准，不依赖该文件名。

---

## [ERR-20260818-PATCH-026] empty_patch_hunk

**Logged**: 2026-08-18T18:50:00+08:00
**Priority**: low
**Status**: resolved
**Area**: tooling

### Summary
初始化 SMTP 修复 Harness 任务时，补丁包含空的状态文件更新块，校验失败。

### Resolution
- 移除空更新块后重新写入任务与计划状态。

---

## [ERR-20260818-PATCH-027] harness_heading_encoding

**Logged**: 2026-08-18T18:51:00+08:00
**Priority**: low
**Status**: resolved
**Area**: tooling

### Summary
Harness 自动生成的状态标题在本机控制台显示为乱码，按显示文本匹配补丁失败。

### Resolution
- 对状态文件仅匹配稳定的 `Status` 行，避免依赖乱码标题文本。

---

## [ERR-20260818-VERIFY-028] local_docker_unavailable

**Logged**: 2026-08-18T18:56:00+08:00
**Priority**: low
**Status**: resolved
**Area**: verification

### Summary
本机 Docker Desktop 引擎未启动，无法用本机 Java 21 容器运行后端测试。

### Resolution
- 前端已在本机通过构建；后端测试改在生产服务器的隔离临时目录与 Java 21 Maven 容器中执行，不接触运行中的应用目录。

---

## [ERR-20260818-VERIFY-029] running_backend_locks_target

**Logged**: 2026-08-18T18:59:00+08:00
**Priority**: low
**Status**: resolved
**Area**: verification

### Summary
测试环境正在运行的 Spring Boot 进程锁定了默认 `target/classes`，导致 JDK 21 Maven 编译无法覆盖类文件。

### Resolution
- 使用独立构建目录运行测试，不停止正在使用的测试环境服务。

---

## [ERR-20260818-MAVEN-030] powershell_maven_property_parsing

**Logged**: 2026-08-18T19:00:00+08:00
**Priority**: low
**Status**: resolved
**Area**: verification

### Summary
PowerShell 调用 Maven Wrapper 时错误解析了 `-Dproject.build.directory` 参数，Maven 将残余文本当作生命周期阶段。

### Resolution
- 改由 `cmd.exe /c` 调用 Wrapper，保留 Maven `-D` 参数原样传递。

---

## [ERR-20260818-MAVEN-031] build_directory_not_overridable

**Logged**: 2026-08-18T19:01:00+08:00
**Priority**: low
**Status**: resolved
**Area**: verification

### Summary
即使 Maven 参数已正确传递，项目构建仍使用默认 `target`，无法避开运行中后端占用的类文件。

### Resolution
- 使用已完成的隔离 Java 21 容器单元测试作为后端验证；不停止本机测试服务。

---

## [ERR-20260818-DEPLOY-032] frontend_scp_destination

**Logged**: 2026-08-18T19:04:00+08:00
**Priority**: medium
**Status**: resolved
**Area**: deployment

### Summary
同时上传两个不同层级的前端文件时使用了共同的 `src` 目标目录，导致文件被放入错误的根目录。

### Resolution
- 在构建前删除两份精确识别的错误临时文件，并分别上传至 `src/api` 与 `src/views/admin/config`；不影响运行中的容器。

---

## [ERR-20260818-DEPLOY-033] stale_production_test_source

**Logged**: 2026-08-18T19:06:00+08:00
**Priority**: medium
**Status**: resolved
**Area**: deployment

### Summary
生产 Docker 构建会编译测试源码。后端服务方法签名已更新，但生产目录尚未同步对应测试文件，构建在替换容器前失败。

### Resolution
- 同步已在隔离 Java 21 环境通过的测试文件后重建。失败发生在镜像构建阶段，运行中的生产服务未被替换。

---

## [ERR-20260818-LOCAL-034] port_inspection_permission

**Logged**: 2026-08-18T19:08:00+08:00
**Priority**: low
**Status**: resolved
**Area**: local-runtime

### Summary
沙箱内读取本机 8080 监听进程被 Windows 拒绝访问，无法安全识别待重启的后端进程。

### Resolution
- 使用提升权限的只读进程检查，确认监听者后再执行限定范围的后端重启。

---

## [ERR-20260818-LOCAL-035] test_backend_not_running

**Logged**: 2026-08-18T19:09:00+08:00
**Priority**: low
**Status**: resolved
**Area**: local-runtime

### Summary
提升权限检查确认本机 8080 当前没有监听进程，因此无需停止旧测试后端。

### Resolution
- 直接以 JDK 21 启动测试环境后端，使其加载本次 SMTP 修复源码。

---

## [ERR-20260818-LOCAL-036] background_start_command_expansion

**Logged**: 2026-08-18T19:11:00+08:00
**Priority**: low
**Status**: resolved
**Area**: local-runtime

### Summary
启动隐藏测试后端时，外层 PowerShell 提前展开了内层 `$env:JAVA_HOME`，使带空格的 JDK 路径被当作命令执行，后端未启动。

### Resolution
- 改用不展开的 here-string 作为子 PowerShell 命令，确保 JDK 21 路径在子进程内正确赋值。

---

## [ERR-20260818-LOCAL-037] dev_database_flyway_checksum

**Logged**: 2026-08-18T19:13:00+08:00
**Priority**: medium
**Status**: open
**Area**: local-runtime

### Summary
测试库记录的 V026 Flyway 校验和与当前测试源码不一致，导致本机 Spring Boot 在初始化时退出；未修改生产环境。

### Resolution
- 本次 SMTP 修复已通过隔离 Java 21 单测和生产镜像构建。若需恢复常规本机启动，应在确认后对测试库执行 Flyway repair，或采用临时只读验证绕过校验。

---

## [ERR-20260818-BROWSER-038] skill_path_expansion

**Logged**: 2026-08-18T19:15:00+08:00
**Priority**: low
**Status**: resolved
**Area**: tooling

### Summary
页面回归前读取 Browser skill 时错误使用了 `sites` 子目录，技能文件路径不存在。

### Resolution
- 按技能根 `r3` 的直接 `browser` 子目录重新读取后再执行页面检查。

---

## [ERR-20260818-BROWSER-039] unsupported_tab_create

**Logged**: 2026-08-18T19:17:00+08:00
**Priority**: low
**Status**: resolved
**Area**: verification

### Summary
页面回归时假设 Browser runtime 提供 `tabs.create()`，实际接口不支持该方法。

### Resolution
- 重新读取已连接 Browser 的运行时文档后，按其提供的导航接口继续检查。

---

## [ERR-20260818-004] browser_skill_path_typo

**Logged**: 2026-08-18T15:39:00+08:00
**Priority**: low
**Status**: resolved
**Area**: tests

### Summary
The in-app browser skill was addressed through the Sites cache path instead of its configured bundle root.

### Resolution
- **Resolved**: 2026-08-18T15:39:00+08:00
- **Notes**: Use `openai-bundled/browser/...` from the configured skill root.

### Metadata
- Reproducible: yes
- Related Files: none

---

## [ERR-20260818-003] powershell_javascript_syntax

**Logged**: 2026-08-18T15:34:00+08:00
**Priority**: low
**Status**: resolved
**Area**: tests

### Summary
A PowerShell verification command used JavaScript method syntax directly instead of invoking Node.

### Error
```
Missing ')' in method call.
```

### Resolution
- **Resolved**: 2026-08-18T15:34:00+08:00
- **Notes**: Run the date-format assertion through `node -e`.

### Metadata
- Reproducible: yes
- Related Files: daily-web/src/components/report/ReportForm.vue

---

## [ERR-20260818-002] typescript_replaceall_target

**Logged**: 2026-08-18T15:32:00+08:00
**Priority**: low
**Status**: resolved
**Area**: frontend

### Summary
The configured TypeScript target does not include `String.replaceAll`.

### Error
```
Property 'replaceAll' does not exist on type 'string'.
```

### Resolution
- **Resolved**: 2026-08-18T15:32:00+08:00
- **Notes**: Replaced it with `replace(/-/g, ...)`, which works with the current target.

### Metadata
- Reproducible: yes
- Related Files: daily-web/src/components/report/ReportForm.vue

---

## [ERR-20260818-001] powershell_rg_pattern_quoting

**Logged**: 2026-08-18T15:28:00+08:00
**Priority**: low
**Status**: resolved
**Area**: tests

### Summary
PowerShell parsed an unquoted `rg` expression containing `|` as a shell pipeline, so the display-check command did not run as intended.

### Error
```
The term 'priority' is not recognized as a name of a cmdlet.
```

### Suggested Fix
Pass regular-expression arguments in single quotes when they contain shell metacharacters such as `|` or parentheses.

### Resolution
- **Resolved**: 2026-08-18T15:28:00+08:00
- **Notes**: Re-ran the check with a single-quoted expression.

### Metadata
- Reproducible: yes
- Related Files: daily-web/src/views/admin/runs/AdminRunsView.vue

---

## [ERR-20260810-004] harness_placeholder_active_task

**Logged**: 2026-08-10T00:00:00+08:00
**Priority**: low
**Status**: resolved
**Area**: config

### Summary
Harness initialization leaves a placeholder `tasks/active.md` that prevents starting the first real task.

### Context
- `Start-CodexHarnessTask.ps1` rejected a new task as active.
- The existing task contained only placeholder text and the handoff state was `ready`.

### Resolution
- **Resolved**: 2026-08-10T00:00:00+08:00
- **Notes**: Replace the untouched placeholder with the current task using the script's force option.

### Metadata
- Reproducible: yes
- Related Files: tasks/active.md

---

## [ERR-20260810-003] unintended_learning_log_staged

**Logged**: 2026-08-10T00:00:00+08:00
**Priority**: medium
**Status**: resolved
**Area**: config

### Summary
The local learning log was included in the initial commit despite the confirmed exclusion scope.

### Context
- Intended commit scope: `.specify/`, `.agents/`
- Unexpected path: `.learnings/ERRORS.md`

### Resolution
- **Resolved**: 2026-08-10T00:00:00+08:00
- **Notes**: Remove the log from the index, amend the initial commit, and force-with-lease push the corrected history.

### Metadata
- Reproducible: unknown
- Related Files: .learnings/ERRORS.md

---

## [ERR-20260810-002] git_author_identity_missing

**Logged**: 2026-08-10T00:00:00+08:00
**Priority**: medium
**Status**: pending
**Area**: config

### Summary
Git cannot create commits because the author name and email are not configured.

### Error
```
fatal: unable to auto-detect email address
```

### Context
- Commit message: `Initialize Spec Kit for Codex`
- Staged paths: `.specify/`, `.agents/`

### Suggested Fix
Configure `user.name` and `user.email` locally for this repository, then retry the commit.

### Metadata
- Reproducible: yes
- Related Files: .learnings/ERRORS.md

---
# Errors

## [ERR-20260819-053] harness_initializer_state_permission_session_probe

**Logged**: 2026-08-19T09:50:00+08:00
**Priority**: low
**Status**: resolved
**Area**: docs

### Summary
The Harness initializer created the session-probe task but could not update protected state files.

### Resolution
- **Resolved**: 2026-08-19T09:50:00+08:00
- **Notes**: Current scope and verification are kept in the task files.

### Metadata
- Reproducible: yes
- Related Files: tasks/active.md
- See Also: ERR-20260819-051

---

## [ERR-20260819-052] task_record_wildcard_path

**Logged**: 2026-08-19T09:47:00+08:00
**Priority**: low
**Status**: resolved
**Area**: docs

### Summary
An `apply_patch` task-record update used a wildcard in the target path, which the patcher does not support.

### Resolution
- **Resolved**: 2026-08-19T09:47:00+08:00
- **Notes**: Resolve the exact generated task filename before patching it.

### Metadata
- Reproducible: yes
- Related Files: tasks/20260819-094154-fix-admin-remember-login.md

---

## [ERR-20260819-051] harness_initializer_state_permission_repeat

**Logged**: 2026-08-19T09:45:00+08:00
**Priority**: low
**Status**: resolved
**Area**: docs

### Summary
The Harness initializer created the new task file but could not write protected state files.

### Resolution
- **Resolved**: 2026-08-19T09:45:00+08:00
- **Notes**: Use the active and dated task files for the task record until state-file permissions are repaired.

### Metadata
- Reproducible: yes
- Related Files: tasks/20260819-094*.md
- See Also: ERR-20260819-041, ERR-20260819-050

---

## [ERR-20260819-050] harness_initializer_repeated_state_permission

**Logged**: 2026-08-19T09:30:00+08:00
**Priority**: low
**Status**: resolved
**Area**: docs

### Summary
The Harness initializer again created the task file but could not update protected state files.

### Resolution
- **Resolved**: 2026-08-19T09:30:00+08:00
- **Notes**: Task scope and verification are recorded in `tasks/active.md` and the dated task file.

### Metadata
- Reproducible: yes
- Related Files: tasks/20260819-093930-clarify-new-project-entry.md
- See Also: ERR-20260819-041, ERR-20260819-046

---

## [ERR-20260819-049] frontend_test_baseline_failures

**Logged**: 2026-08-19T09:25:00+08:00
**Priority**: medium
**Status**: pending
**Area**: tests

### Summary
The full frontend suite has six pre-existing failures in technical-connection and period-statistics tests, unrelated to the report-entry files changed in this task.

### Error
```
AdminTechnicalConnectionView: 2 failed
AdminReportsView: 4 failed
```

### Suggested Fix
Update those stale tests or restore the removed test fixtures in a separate task; do not alter unrelated production features while changing the employee report entry page.

### Metadata
- Reproducible: yes
- Related Files: daily-web/tests/views/admin-configuration.spec.ts, daily-web/tests/views/admin-reports.spec.ts

---

## [ERR-20260819-048] powershell_node_assertion_quoting

**Logged**: 2026-08-19T09:22:00+08:00
**Priority**: low
**Status**: resolved
**Area**: tests

### Summary
A Node source assertion embedded in a PowerShell double-quoted command broke on nested template-literal syntax.

### Resolution
- **Resolved**: 2026-08-19T09:22:00+08:00
- **Notes**: Use a PowerShell here-string for the Node program to preserve literal characters.

### Metadata
- Reproducible: yes
- Related Files: daily-web/src/components/report/DailyTaskForm.vue

---

## [ERR-20260819-047] browser_runtime_trusted_dependency

**Logged**: 2026-08-19T09:20:00+08:00
**Priority**: low
**Status**: pending
**Area**: tests

### Summary
The in-app browser runtime could not resolve its trusted browser service dependency, so automated visual verification was unavailable.

### Error
```
Trusted RPC dependency must resolve within a configured trusted code path
```

### Suggested Fix
Repair the bundled browser runtime trust configuration, then rerun the mobile visual smoke test.

### Metadata
- Reproducible: yes
- Related Files: none

---

## [ERR-20260819-046] harness_state_prepend_unsupported

**Logged**: 2026-08-19T09:14:00+08:00
**Priority**: low
**Status**: pending
**Area**: docs

### Summary
The available patcher cannot insert content into the legacy-encoded Harness state files without matching their unreadable initial bytes.

### Suggested Fix
Regenerate those four state files through a workspace process with direct write permission after their historic content is archived.

### Metadata
- Reproducible: yes
- Related Files: .codex/state/*.md
- See Also: ERR-20260819-043, ERR-20260819-045

---

## [ERR-20260819-045] harness_state_bom_context_mismatch

**Logged**: 2026-08-19T09:12:00+08:00
**Priority**: low
**Status**: resolved
**Area**: docs

### Summary
Even the ASCII Harness headings could not be matched by the patcher, indicating a byte-order mark or legacy encoding at file start.

### Resolution
- **Resolved**: 2026-08-19T09:12:00+08:00
- **Notes**: Insert current task state at line 1 without matching historical file content.

### Metadata
- Reproducible: yes
- Related Files: .codex/state/*.md

---

## [ERR-20260819-044] harness_state_delete_rejected

**Logged**: 2026-08-19T09:10:00+08:00
**Priority**: low
**Status**: resolved
**Area**: docs

### Summary
Replacing generated Harness state files by deleting them was rejected because it could remove prior task records.

### Resolution
- **Resolved**: 2026-08-19T09:10:00+08:00
- **Notes**: Preserve prior records and prepend the current task state instead.

### Metadata
- Reproducible: yes
- Related Files: .codex/state/*.md

---

## [ERR-20260819-043] harness_state_patch_encoding

**Logged**: 2026-08-19T09:08:00+08:00
**Priority**: low
**Status**: resolved
**Area**: docs

### Summary
Harness state files contain legacy encoding artifacts, so a context-based patch could not locate the expected text.

### Resolution
- **Resolved**: 2026-08-19T09:08:00+08:00
- **Notes**: Replace only the generated Harness state files in separate patches instead of matching garbled historic content.

### Metadata
- Reproducible: yes
- Related Files: .codex/state/plan.md

---

## [ERR-20260819-040] optional_agents_file_missing

**Logged**: 2026-08-19T09:00:00+08:00
**Priority**: low
**Status**: resolved
**Area**: docs

### Summary
Startup inspection attempted to read a repository-level `AGENTS.md`, but this repository relies on injected global instructions and does not contain that optional file.

### Resolution
- **Resolved**: 2026-08-19T09:00:00+08:00
- **Notes**: Use `Test-Path` before reading optional repository instruction files; continue with `.codex/HARNESS.md` and injected instructions.

### Metadata
- Reproducible: yes
- Related Files: .codex/HARNESS.md

---

## [ERR-20260818-016] deployed_directory_has_no_git_metadata

**Logged**: 2026-08-18T17:25:00+08:00
**Priority**: low
**Status**: resolved
**Area**: infra

### Summary
The existing `/daily-report-system` deployment is a copied runtime package and does not contain Git metadata, so it cannot be updated with `git pull`.

### Error
```
fatal: not a git repository
```

### Suggested Fix
Synchronize the application source and Docker configuration while preserving the remote environment file and database volume.

### Metadata
- Reproducible: yes
- Related Files: docker/docker-compose.yml

---

## [ERR-20260818-015] computer_use_skill_path_misread

**Logged**: 2026-08-18T17:15:00+08:00
**Priority**: low
**Status**: resolved
**Area**: infra

### Summary
The initial attempt to read the Computer Use skill used an incorrect bundled path.

### Error
```
Cannot find path '...\\skills\\computer-use\\26.810.52044\\SKILL.md'
```

### Suggested Fix
Use the exact configured skill-root path: `openai-bundled\\computer-use\\26.810.52044\\skills\\computer-use\\SKILL.md`.

### Metadata
- Reproducible: yes
- Related Files: none

---

## [ERR-20260818-014] deployment_ssh_private_key_inaccessible

**Logged**: 2026-08-18T17:10:00+08:00
**Priority**: high
**Status**: blocked
**Area**: infra

### Summary
The deployment host is reachable, but the execution sandbox cannot open the user's SSH private key to authenticate as root.

### Error
```
Load key "C:/Users/whn/.ssh/id_rsa": Permission denied
root@36.213.175.224: Permission denied (publickey,password).
```

### Suggested Fix
Run deployment from the user's local PowerShell session or grant the deployment runner read access to the required private key.

### Metadata
- Reproducible: yes
- Related Files: C:\\Users\\whn\\.ssh\\id_rsa, dev-start.ps1
- See Also: ERR-20260818-013

---

## [ERR-20260818-013] sandbox_cannot_read_user_ssh_private_key

**Logged**: 2026-08-18T17:00:00+08:00
**Priority**: high
**Status**: blocked
**Area**: infra

### Summary
The execution sandbox cannot read the user's Gitee private key, so Git cannot authenticate to push the repository.

### Error
```
Load key "C:/Users/whn/.ssh/id_ed25519_gitee": Permission denied
```

### Suggested Fix
Run the release commit and push from the user's local PowerShell session, where the private key is accessible.

### Metadata
- Reproducible: yes
- Related Files: C:\\Users\\whn\\.ssh\\id_ed25519_gitee
- See Also: ERR-20260818-009, ERR-20260818-011

---

## [ERR-20260818-012] git_ssh_command_windows_path_escaping

**Logged**: 2026-08-18T16:55:00+08:00
**Priority**: low
**Status**: resolved
**Area**: infra

### Summary
Backslashes in a Windows identity-file path were consumed while Git parsed `GIT_SSH_COMMAND`.

### Error
```
Identity file C:Userswhn.sshid_ed25519_gitee not accessible
```

### Suggested Fix
Use forward slashes in identity-file paths passed through `GIT_SSH_COMMAND`.

### Metadata
- Reproducible: yes
- Related Files: .git/config

---

## [ERR-20260818-011] gitee_ssh_public_key_rejected

**Logged**: 2026-08-18T16:50:00+08:00
**Priority**: high
**Status**: pending
**Area**: infra

### Summary
After host verification, Gitee rejected public-key authentication for the repository SSH URL.

### Error
```
git@gitee.com: Permission denied (publickey).
```

### Suggested Fix
Configure the intended private-key path in the SSH client and ensure its public key is associated with a Gitee account that can write this repository.

### Metadata
- Reproducible: yes
- Related Files: C:\\Users\\whn\\.ssh\\config, .git/config

---

## [ERR-20260818-010] gitee_ssh_host_key_unverified

**Logged**: 2026-08-18T16:45:00+08:00
**Priority**: medium
**Status**: pending
**Area**: infra

### Summary
Gitee SSH authentication could not begin because the host key is not verified in the local known-hosts store.

### Error
```
Host key verification failed.
```

### Suggested Fix
Verify Gitee's published SSH host fingerprint before adding it to a workspace-scoped known-hosts file.

### Metadata
- Reproducible: yes
- Related Files: C:\\Users\\whn\\.ssh\\known_hosts

---

## [ERR-20260818-009] gitee_https_credentials_unavailable

**Logged**: 2026-08-18T16:40:00+08:00
**Priority**: medium
**Status**: pending
**Area**: infra

### Summary
The Gitee HTTPS remote cannot authenticate because Windows has no usable secure-channel credentials.

### Error
```
schannel: AcquireCredentialsHandle failed: SEC_E_NO_CREDENTIALS
```

### Suggested Fix
Use the configured Gitee SSH key and `git@gitee.com:hainnn/daily-report-system.git` for repository operations.

### Metadata
- Reproducible: yes
- Related Files: .git/config

---

## [ERR-20260818-008] harness_state_write_denied

**Logged**: 2026-08-18T16:30:00+08:00
**Priority**: medium
**Status**: pending
**Area**: docs

### Summary
The Harness task initializer can create `tasks/active.md` but cannot write `.codex/state/*` in the current sandbox.

### Error
```
Access to the path '...\\.codex\\state\\plan.md' is denied.
```

### Suggested Fix
Grant the task initializer write access to `.codex/state/`, then rerun it to regenerate the four Harness state files.

### Metadata
- Reproducible: yes
- Related Files: .codex/state/plan.md, .codex/state/progress.md, .codex/state/critique.md, .codex/state/handoff.md

---

## [ERR-20260818-007] audit_command_path_assumptions

**Logged**: 2026-08-18T16:25:00+08:00
**Priority**: low
**Status**: resolved
**Area**: docs

### Summary
Read-only audit commands assumed a repository `AGENTS.md` and passed a Windows wildcard directly to `rg`; the repository uses the injected global instructions and `rg` does not expand that wildcard.

### Error
```
Cannot find path '...\\AGENTS.md' because it does not exist.
rg: docs\\*.md: IO error ... invalid filename syntax
```

### Suggested Fix
Test optional instruction files before reading and pass the directory to `rg` instead of a Windows wildcard.

### Metadata
- Reproducible: yes
- Related Files: .codex/HARNESS.md, docs/

---

## [ERR-20260818-005] harness_completion_marker_format

**Logged**: 2026-08-18T14:20:00+08:00
**Priority**: low
**Status**: pending
**Area**: docs

### Summary
新任务启动被拦截：前一任务的交接文件只包含 `Status: LOOP_COMPLETE`，而脚本要求独占一行的 `LOOP_COMPLETE`；该文件当前受沙箱只读限制，无法补写。

### Error
```
The active task is not complete. Finish it first, or pass -Force to intentionally replace it.
```

### Suggested Fix
在可写的 Harness 状态目录中，将 `LOOP_COMPLETE` 作为独立一行写入交接文件。

### Metadata
- Reproducible: yes
- Related Files: .codex/state/handoff.md, C:\Users\whn\.codex\Start-CodexHarnessTask.ps1

---

## [ERR-20260818-006] browser_screenshot_method_unavailable

**Logged**: 2026-08-18T14:25:00+08:00
**Priority**: low
**Status**: resolved
**Area**: tests

### Summary
The claimed browser tab does not expose a `playwright.screenshot` method in this runtime.

### Error
```
myReportTab.playwright.screenshot is not a function
```

### Suggested Fix
Use the browser skill's documented screenshot path instead of assuming a Playwright-style method is available.

### Metadata
- Reproducible: yes
- Related Files: none

---

## [ERR-20260812-001] apply_patch_encoding_mismatch

**Logged**: 2026-08-12T00:00:00+08:00
**Priority**: low
**Status**: resolved
**Area**: docs

### Summary
Patch matching failed after terminal output rendered UTF-8 Chinese text as mojibake.

### Suggested Fix
Use the original UTF-8 text, verified from file bytes, when patching affected files.

### Metadata
- Reproducible: yes
- Related Files: tasks/active.md

---
## [ERR-20260818-DEPLOY-FRONTEND-001] docker_build

**Logged**: 2026-08-18T17:36:00+08:00
**Priority**: high
**Status**: resolved
**Area**: infra

### Summary
远端覆盖解压未删除旧前端文件，导致 Docker 构建编译到了当前源码中已不存在的旧配置页面。

### Error
```
AdminConfigurationView.vue(57,50): error TS2339: Property 'modelApiKeyReference' does not exist
```

### Context
- 将仅包含当前源码的 tar 包解压到 `/daily-report-system` 后执行 `docker compose up -d --build`。
- tar 覆盖不会移除上一版本遗留文件；本地目录不存在该组件，远端仍保留。

### Suggested Fix
部署前以可回滚备份为前提，清理并替换 `daily-api`、`daily-web` 与 `docker` 源码目录，同时保留 `docker/.env` 和 Docker 数据卷。

### Metadata
- Reproducible: yes
- Related Files: docker/docker-compose.yml

### Resolution
- **Resolved**: 2026-08-18T17:50:00+08:00
- **Notes**: 使用整目录可回滚替换，避免 tar 覆盖残留文件。

---

## [ERR-20260818-DEPLOY-DATABASE-002] docker_compose_start

**Logged**: 2026-08-18T17:45:00+08:00
**Priority**: critical
**Status**: resolved
**Area**: infra

### Summary
新 API 连接已有 PostgreSQL 数据卷时，数据库中保留的用户密码与远端 `.env` 当前密码不一致。

### Error
```
FATAL: password authentication failed for user "drs_pg_admin"
```

### Context
- 应用源码目录已整目录替换，`docker/.env` 原样保留。
- PostgreSQL 数据卷未清除，容器健康但 API 在 Flyway 初始化阶段无法认证。

### Suggested Fix
通过 PostgreSQL 容器本地 Unix socket 将数据库用户密码重设为受保留 `.env` 管理的值，再重启 API；不导出、不展示凭据。

### Metadata
- Reproducible: yes
- Related Files: docker/docker-compose.yml, docker/.env

### Resolution
- **Resolved**: 2026-08-18T17:48:00+08:00
- **Notes**: 已通过容器本地认证将数据库角色密码校准为保留 `.env` 的值。

---

## [ERR-20260818-DEPLOY-MIGRATION-005] flyway_v026

**Logged**: 2026-08-18T17:49:00+08:00
**Priority**: high
**Status**: resolved
**Area**: backend

### Summary
V026 将历史可空收件人字段写入新增非空列，导致 Flyway 迁移失败。

### Error
```
null value in column "email_recipients" violates not-null constraint
```

### Resolution
- **Resolved**: 2026-08-18T17:50:00+08:00
- **Notes**: 在 V026 使用 `coalesce` 写入空字符串和默认邮件标题；远端 V026–V029 已核验成功。

### Metadata
- Reproducible: yes
- Related Files: daily-api/src/main/resources/db/migration/V026__add_period_email_delivery.sql

---

## [ERR-20260818-DEPLOY-HARNESS-006] apply_patch

**Logged**: 2026-08-18T17:53:00+08:00
**Priority**: low
**Status**: resolved
**Area**: docs

### Summary
一次补丁同时删除并新增同一 Harness 状态文件，导致补丁校验拒绝。

### Resolution
- **Resolved**: 2026-08-18T17:53:00+08:00
- **Notes**: 改为单个 Update File 补丁。

### Metadata
- Reproducible: yes
- Related Files: .codex/state/progress.md, .codex/state/handoff.md

---

## [ERR-20260818-ADMIN-PASSWORD-007] remote_command_quoting

**Logged**: 2026-08-18T17:55:00+08:00
**Priority**: low
**Status**: resolved
**Area**: infra

### Summary
PowerShell 与 SSH 的多层引号使容器工具探测命令未实际执行。

### Resolution
- **Resolved**: 2026-08-18T17:55:00+08:00
- **Notes**: 改用 PowerShell here-string 组装命令，再以 Base64 传递固定 SQL，避免嵌套引号。

### Metadata
- Reproducible: yes
- Related Files: none

---

## [ERR-20260818-ADMIN-PASSWORD-008] bcrypt_module_missing

**Logged**: 2026-08-18T17:57:00+08:00
**Priority**: low
**Status**: resolved
**Area**: infra

### Summary
本机 Python 3.12 未安装 `bcrypt` 模块，无法直接生成管理员密码哈希。

### Error
```
ModuleNotFoundError: No module named 'bcrypt'
```

### Suggested Fix
复用项目 Maven 缓存中的 Spring Security BCrypt 与 Commons Logging 实现，以临时 Java 类生成哈希，不安装额外依赖。

### Metadata
- Reproducible: yes
- Related Files: daily-api/pom.xml

### Resolution
- **Resolved**: 2026-08-18T18:00:00+08:00
- **Notes**: 使用项目本地 Maven 缓存的 Spring Security BCrypt 和 Commons Logging 生成哈希并完成接口验证。

---

## [ERR-20260818-HARNESS-009] start_task_permission

**Logged**: 2026-08-18T18:05:00+08:00
**Priority**: low
**Status**: resolved
**Area**: docs

### Summary
Harness 启动脚本无法直接写入受运行环境保护的状态文件。

### Error
```
Set-Content: Access to .codex/state/progress.md is denied
```

### Resolution
- **Resolved**: 2026-08-18T18:05:00+08:00
- **Notes**: 继续通过受允许的 `apply_patch` 维护 Harness 状态。

### Metadata
- Reproducible: yes
- Related Files: .codex/state/progress.md

---

---

## [ERR-20260818-DEPLOY-POWERSHELL-003] remote_command_quoting

**Logged**: 2026-08-18T17:47:00+08:00
**Priority**: medium
**Status**: resolved
**Area**: infra

### Summary
PowerShell 将远端 shell 的 `2>/dev/null || true` 误解析为本地重定向和管道。

### Error
```
Could not find a part of the path 'E:\\dev\\null'.
```

### Context
- 在 PowerShell 内嵌套 SSH 双引号命令时包含 POSIX 重定向。

### Suggested Fix
将远端命令拆分为不含 shell 控制符的 SSH 调用，或使用单引号保持远端命令字面量。

### Metadata
- Reproducible: yes
- Related Files: none

### Resolution
- **Resolved**: 2026-08-18T17:47:00+08:00
- **Notes**: 后续改为拆分命令执行。

---

## [ERR-20260818-DEPLOY-PSQL-004] remote_sql_quoting

**Logged**: 2026-08-18T17:51:00+08:00
**Priority**: low
**Status**: resolved
**Area**: infra

### Summary
远端只读迁移核验的字符串拼接 SQL 在多层 shell 引号中丢失了冒号字面量。

### Error
```
ERROR: syntax error at or near ":"
```

### Context
- 服务健康检查已通过；失败仅发生在附加的只读显示语句。

### Suggested Fix
核验时使用表格字段输出，避免跨 PowerShell、SSH 和 psql 的字符串拼接引号。

### Metadata
- Reproducible: yes
- Related Files: none

### Resolution
- **Resolved**: 2026-08-18T17:51:00+08:00
- **Notes**: 后续改为无字符串条件的字段查询；多层 shell 不使用 SQL 字符串字面量。

---
## [ERR-20260819-001] harness_state_write

**Logged**: 2026-08-19T00:00:00+08:00
**Priority**: low
**Status**: resolved
**Area**: docs

### Summary
Harness 初始化脚本无法写入现有状态文件，需保留任务内容并用补丁更新。

### Error
```
Access to the path '.codex\\state\\plan.md' is denied.
```

### Resolution
- 任务信息已写入 `tasks/active.md`；后续状态文件通过受控补丁更新。

---

## [ERR-20260819-002] maven_sandbox_compile_lock

**Logged**: 2026-08-19T00:00:00+08:00
**Priority**: low
**Status**: resolved
**Area**: tests

### Summary
受限会话下 Maven 无法覆盖已生成的类文件，授权执行后测试正常通过。

### Error
```
Compilation failure: DailyApiApplication.class could not be written.
```

### Resolution
- 使用 JDK 21 的授权 Maven 定向测试完成验证；无需修改源码或测试配置。

---
