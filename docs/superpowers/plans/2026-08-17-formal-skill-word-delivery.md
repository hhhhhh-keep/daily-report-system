# Formal Skill Word Delivery Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make every successful formal Skill analysis persist, download, and email the same generated Word document.

**Architecture:** Add generic document metadata to `analysis_runs`; construct a Word-backed `ReportArtifact` directly from `SkillExecution`. The generic run download endpoint reads saved metadata, while legacy PDF downloads remain available only for existing records.

**Tech Stack:** Spring Boot, JdbcTemplate/Flyway, JUnit 5/Mockito, Vue 3/TypeScript.

## Global Constraints

- Successful formal Skill runs require a non-empty Word document.
- No PDF fallback may be generated or emailed.
- Historical PDF records remain readable.

---

### Task 1: Persist generic formal-run documents

**Files:**
- Create: `daily-api/src/main/resources/db/migration/V027__add_formal_run_document_metadata.sql`
- Modify: `daily-api/src/main/java/com/company/daily/scheduling/AnalysisRunStore.java`
- Modify: `daily-api/src/main/java/com/company/daily/scheduling/AnalysisRunResponse.java`
- Test: `daily-api/src/test/java/com/company/daily/scheduling/AnalysisOrchestratorTest.java`

- [ ] Write a failing orchestration test that captures the stored Word bytes, filename, and MIME type.
- [ ] Run the focused test and confirm it fails because `AnalysisRunStore.complete` has no generic document arguments.
- [ ] Add document columns and store/read methods while retaining legacy PDF reads.
- [ ] Run the focused test and confirm it passes.

### Task 2: Use Skill Word and attach it to mail

**Files:**
- Modify: `daily-api/src/main/java/com/company/daily/reporting/ReportArtifact.java`
- Modify: `daily-api/src/main/java/com/company/daily/email/EmailMessage.java`
- Modify: `daily-api/src/main/java/com/company/daily/email/EmailService.java`
- Modify: `daily-api/src/main/java/com/company/daily/email/SmtpEmailGateway.java`
- Modify: `daily-api/src/main/java/com/company/daily/scheduling/AnalysisOrchestrator.java`
- Test: `daily-api/src/test/java/com/company/daily/scheduling/AnalysisOrchestratorTest.java`

- [ ] Write failing tests for the success path and missing-Word failure path.
- [ ] Verify the tests fail before production edits.
- [ ] Build a DOCX artifact from `renderedDocument`; do not invoke `ReportService` on the formal Skill path.
- [ ] Add MIME-aware attachment handling and verify attachment content is the Skill document.
- [ ] Run the focused backend tests.

### Task 3: Download the stored document from both admin views

**Files:**
- Modify: `daily-api/src/main/java/com/company/daily/scheduling/api/RunController.java`
- Modify: `daily-web/src/api/admin.ts`
- Modify: `daily-web/src/views/admin/analysis/AdminAnalysisView.vue`
- Modify: `daily-web/src/views/admin/runs/AdminRunsView.vue`

- [ ] Add a generic report endpoint that emits stored filename and MIME type; leave the legacy PDF endpoint for old records.
- [ ] Point both views to the generic endpoint and show the saved filename where available.
- [ ] Run frontend build.

### Task 4: Verify and hand off

- [ ] Run `mvn -Dtest=AnalysisOrchestratorTest,EmailServiceTest test` with JDK 21.
- [ ] Run `npm run build` in `daily-web`.
- [ ] Check modified Chinese text for replacement characters and mojibake.
