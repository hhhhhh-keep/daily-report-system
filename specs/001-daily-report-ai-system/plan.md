# 实施规划：日报 AI 分析系统

**分支**：`001-daily-report-ai-system` | **日期**：2026-08-10 | **规格**：[spec.md](spec.md)

## 摘要

建设部门内部日报、AI 分析和管理辅助系统：一个 Vue 3 Web 应用、一个 Spring Boot 模块化单体、PostgreSQL 和 Docker。应用自身负责调度、报告和邮件。

## 技术上下文

**语言**：Java 21；TypeScript/Vue 3。**存储**：PostgreSQL。**运行时**：Linux Docker 容器。
**依赖**：Spring Boot、Quartz、Vue Router、PostgreSQL driver、LLM 与 SMTP adapters。
**测试**：JUnit/Spring 集成、Vue 组件/e2e、API 契约和 migrations。
**约束**：一个管理员；无员工登录；每员工/日期一份日报；无 RBAC、审批、n8n、队列、Kubernetes、CRM、绩效或工时系统。

## 宪章检查

通过：模块化单体、PostgreSQL migrations、Docker/environment 配置、AI 与确定性规则分离。实施前定义并运行实际的前端/后端 `test`、`lint` 和 `build` 命令。

## 交付阶段

1. 创建 Vue/Spring 项目、Docker 基线、环境校验、migrations 和质量命令。
2. 实现 Employee/Project 主数据及 DailyReport/DailyTask 当日更新规则。
3. 增加管理员访问、管理视图、数据指标和驾驶舱。
4. 增加规则引擎、LLM adapter、配置、Quartz、报告、SMTP、运行记录和重试。
5. 验证契约、每日唯一性、任务更新、分析降级、邮件重试和容器。

## 规划覆盖

规划覆盖日报主表与动态工作任务明细、人员和项目基础数据、人员效能、项目风险、资源调配建议、规则加 LLM 混合分析、AI 规则配置、定时分析、报告生成、邮件发送、管理驾驶舱和 Docker 部署。

## 项目结构

```text
daily-web/                 # Vue 3: /report, /my-report, /admin/*
daily-api/                 # Spring Boot modules
docker/                    # nginx and local deployment assets
specs/001-daily-report-ai-system/
├── research.md
├── data-model.md
├── contracts/http-api.md
└── quickstart.md
```
