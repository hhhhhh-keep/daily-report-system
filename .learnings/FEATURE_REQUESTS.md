# Feature Requests

## [FEAT-20260820-001] 自绘日报候选列表

**Logged**: 2026-08-20T09:30:00+08:00
**Priority**: high
**Status**: in_progress
**Area**: frontend

### Requested Capability

以系统页面候选列表替代姓名、项目和专项输入框的原生浏览器候选列表，确保不同手机和电脑终端都能显示并选择候选项。

### User Context

部分终端输入姓名关键字后不展示浏览器原生下拉候选，导致无法选择人员；项目/专项输入框存在同类风险。

### Complexity Estimate

medium

### Suggested Implementation

使用可复用 Vue 候选列表组件，支持关键字筛选、鼠标/触摸/键盘选择，并保留新项目/专项直接录入能力。

### Metadata

- Frequency: recurring
- Related Features: 日报填写、修改今日日报、项目/专项选择

---
