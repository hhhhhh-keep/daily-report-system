# Skill Trial Document Download Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Show the Word download action whenever a successful Skill trial has a stored report artifact.

**Architecture:** Expose artifact existence as `hasDocument` on the trial API response. The Vue view consumes that explicit state instead of inferring availability from template metadata.

**Tech Stack:** Java 21, Spring Boot, Vue 3, TypeScript, Vitest.

## Global Constraints

- Do not change artifact content, authorization, or the document download endpoint.
- Use JDK 21 for backend checks and preserve Chinese text integrity.

---

### Task 1: Expose actual document availability

**Files:**
- Modify: `daily-api/src/main/java/com/company/daily/skills/AnalysisSkillTrial.java`
- Modify: `daily-api/src/main/java/com/company/daily/skills/AnalysisSkillService.java`
- Modify: `daily-web/src/api/admin.ts`
- Test: `daily-web/tests/views/admin-skills.spec.ts`

- [ ] Add `boolean hasDocument` to `AnalysisSkillTrial`; populate it using an `exists` query on `analysis_skill_artifacts` for `REPORT_DOCX`.
- [ ] Add `hasDocument: boolean` to the frontend contract.
- [ ] Make `latestTrialHasDocument` return `latestTrial.hasDocument`.
- [ ] Add a successful-trial fixture with `hasDocument: true` and assert `[data-testid="download-docx"]` exists.
- [ ] Run the focused Vitest file, then backend compile.
