alter table analysis_runs
  add column if not exists report_mime_type varchar(160);

update analysis_runs
set report_mime_type = 'application/pdf'
where report_pdf is not null and report_mime_type is null;
