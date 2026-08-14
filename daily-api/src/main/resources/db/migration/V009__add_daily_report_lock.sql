alter table daily_reports
  add column locked_at timestamptz;

create index ix_daily_reports_date_locked
  on daily_reports(report_date, locked_at);
