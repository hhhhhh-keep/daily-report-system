alter table analysis_runs
  add column if not exists analysis_period varchar(20) not null default 'DAILY',
  add column if not exists period_start date,
  add column if not exists period_end date,
  add column if not exists rule_version_id bigint,
  add column if not exists rule_snapshot_json text,
  add column if not exists prompt_snapshot text,
  add column if not exists schema_snapshot_json text,
  add column if not exists source_snapshot_json text,
  add column if not exists display_data_json text,
  add column if not exists model_name_snapshot varchar(160);

update analysis_runs set period_start=analysis_date,period_end=analysis_date
  where period_start is null or period_end is null;

insert into analysis_rule_versions(
  analysis_period, version_number, status, change_note, rules_json, prompt_template,
  custom_schema_json, trial_succeeded_at, published_at
)
select 'DAILY', 1, 'PUBLISHED', '系统默认日报规则', '{}',
  '基于日报任务输出可追溯的 AI 辅助分析。', '{}', current_timestamp, current_timestamp
where not exists (select 1 from analysis_rule_versions where analysis_period='DAILY')
union all
select 'WEEKLY', 1, 'PUBLISHED', '系统默认周报规则', '{}',
  '基于本周日报趋势输出可追溯的 AI 辅助分析。', '{}', current_timestamp, current_timestamp
where not exists (select 1 from analysis_rule_versions where analysis_period='WEEKLY')
union all
select 'MONTHLY', 1, 'PUBLISHED', '系统默认月报规则', '{}',
  '基于本月日报趋势输出可追溯的 AI 辅助分析。', '{}', current_timestamp, current_timestamp
where not exists (select 1 from analysis_rule_versions where analysis_period='MONTHLY');

create index if not exists ix_analysis_runs_period_window
  on analysis_runs(analysis_period, period_start desc, period_end desc, started_at desc);
