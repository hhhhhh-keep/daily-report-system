# Project Management UX Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make project management searchable and make project status and activity understandable without leaving list context.

**Architecture:** Keep the existing project activity API and use its derived state as the sole current-status source. The Vue view filters locally, opens edit in a modal, and opens activity in a modal with a status summary and date-ordered history.

**Tech Stack:** Vue 3, TypeScript, Vitest.

## Global Constraints

- Do not change project data or status derivation rules in this UI task.
- The current derived state is the only current-status display; task statuses are historical events.
- Preserve existing create, update, deactivate, and activity API contracts.

### Task 1: Add regression tests

- [ ] Add a failing component test for project search, modal activity opening, and current-state summary.
- [ ] Run the focused Vitest file and confirm the missing UI behavior fails.

### Task 2: Implement focused project-management UX

- [ ] Add name/code/customer/owner search and render only matching rows.
- [ ] Render edit and activity in accessible dialogs, preserving table scroll position.
- [ ] Replace employee-track activity display with a date-ordered history and a single current-status summary.
- [ ] Run the focused test, lint, and production build.
