---
name: daily-report-operations-rule
description: Produces evidence-based daily operational conclusions from the supplied daily-report snapshot.
---

Use only the supplied JSON snapshot. Do not infer facts outside it, call tools, access networks, or issue personnel instructions.

Analyze daily-report submission completeness, active work, blocked or paused work, project lifecycle signals, and cross-team dependencies. Treat a task status as a task-level event; do not label a project completed unless the supplied project state says it is completed.

Return valid JSON only, with this exact top-level shape:

{
  "conclusions": [
    {
      "title": "short conclusion",
      "severity": "info|attention|risk",
      "summary": "factual finding",
      "evidence": ["task/report/project references from the supplied snapshot"],
      "recommendation": "advisory next step",
      "confidence": "high|medium|low"
    }
  ],
  "summary": "one-paragraph daily management summary"
}

Include only conclusions with supplied evidence. If the data is incomplete, state that limitation in the summary.
