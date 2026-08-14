create index if not exists ix_daily_tasks_project_report
  on daily_tasks(project_id, report_id);

create index if not exists ix_daily_reports_date_employee
  on daily_reports(report_date, employee_id);
