# 填报累计统计优化 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add custom date-range statistics, pagination, and full-range Excel export to the admin reports page.

**Architecture:** Keep all period aggregation in `ReportPeriodStatisticsService`. Add a custom-window entry point and a small XLSX writer service used only by the export controller endpoint. The Vue page retains weekly/monthly shortcuts and pages the already-loaded person list locally.

**Tech Stack:** Spring Boot 4, Java 21 standard-library XLSX ZIP writer, Vue 3, TypeScript, Vitest.

## Global Constraints

- Date ranges are inclusive and use the configured workday calendar.
- Existing weekly/monthly endpoint behavior remains compatible.
- Export uses the same statistics result as the UI and contains no raw daily report content.

---

### Task 1: Range-aware aggregation and Excel endpoint

**Files:**
- Modify: `daily-api/src/main/java/com/company/daily/report/service/ReportPeriodStatisticsService.java`
- Create: `daily-api/src/main/java/com/company/daily/report/service/ReportPeriodStatisticsExcelExporter.java`
- Modify: `daily-api/src/main/java/com/company/daily/report/api/AdminReportController.java`
- Test: `daily-api/src/test/java/com/company/daily/report/ReportPeriodStatisticsServiceTest.java`

- [ ] Add a failing test for inclusive custom-range workday counts.
- [ ] Add `statistics(LocalDate start, LocalDate end)` and share the aggregation path with weekly/monthly requests.
- [ ] Add a failing test asserting an XLSX export is non-empty and uses the requested range.
- [ ] Implement the standard-library XLSX writer and controller download response with Chinese column headers.
- [ ] Run the focused backend test.

### Task 2: Reports page controls, paging, and download

**Files:**
- Modify: `daily-web/src/api/admin.ts`
- Modify: `daily-web/src/views/admin/AdminReportsView.vue`
- Test: `daily-web/tests/views/admin-reports.spec.ts`

- [ ] Add a failing Vue test for custom-range calls, paged people rows, and export invocation.
- [ ] Extend the API client for custom ranges and blob downloads.
- [ ] Add date controls, local person pagination using `Pagination.vue`, and a Blob download action.
- [ ] Run the focused frontend test and production build.
