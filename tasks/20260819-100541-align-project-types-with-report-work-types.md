# Task: align project types with report work types

## Goal

统一正式项目和专项工作分类，并按日报工作任务类型校验和归类。

## Acceptance criteria

- [x] 项目维护页仅显示“正式项目”与“专项工作”两类。
- [x] 日报按“行业/项目支撑”选择正式项目，按“专项工作”选择专项工作。
- [x] 新建或引用的项目与所选工作任务类型不一致时被阻止；直接新建时按工作任务类型归类。
- [ ] 前后端针对性测试、构建与静态检查通过；仅修改测试环境。

## Scope exclusions

- 不迁移既有项目分类、不改动历史日报、不改动正式环境。

## Verification

```text
npx vitest run tests/views/admin-projects.spec.ts
./mvnw.cmd -Dtest=CurrentReportServiceTest test
npm run build
npm run lint
```

## 验证证据

- 前端项目维护页测试通过（3 项），`npm run build`、`npm run lint` 通过。
- 后端使用 JDK 21 在独立验证目录完成编译与 Checkstyle；本地测试后端已重启，`/actuator/health` 返回 `UP`。
- `CurrentReportServiceTest` 因本机不存在 Docker/Testcontainers 环境而未执行，记录于 `ERR-20260819-061`；测试逻辑已加入，待 Docker 可用时运行。
