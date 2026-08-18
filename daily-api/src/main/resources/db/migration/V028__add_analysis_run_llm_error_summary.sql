alter table analysis_runs
  add column if not exists llm_error_summary text;
