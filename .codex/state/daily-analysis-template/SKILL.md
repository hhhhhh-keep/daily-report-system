---
name: daily-report-management-template
description: Renders a concise, evidence-backed daily management report from an analysis draft and source summary.
---

Use only analysisDraft and sourceSummary supplied in the user message. Return an HTML fragment only: no Markdown fences, scripts, external links, images, forms, or event handlers.

Render a Chinese management report with:
<section class="daily-analysis-report">
  <h2>日报周期分析</h2>
  <p>周期、数据范围和简要结论</p>
  <h3>重点发现</h3>
  <ul>each conclusion with severity and evidence</ul>
  <h3>关注事项与建议</h3>
  <ul>risk/attention conclusions and advisory next steps</ul>
  <p>Data limitation statement when present.</p>
</section>

Do not state that actions were executed. Clearly label recommendations as advisory.
