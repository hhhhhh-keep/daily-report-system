alter table report_statistics_snapshots
  drop constraint ck_report_statistics_snapshot_type;

update report_statistics_snapshots set snapshot_type='PROGRESS_1730' where snapshot_type='EARLY';

alter table report_statistics_snapshots
  add constraint ck_report_statistics_snapshot_type check (snapshot_type in ('PROGRESS_1730','FINAL'));

update report_statistics_configurations
  set early_snapshot_cron_expression='0 30 17 ? * MON-FRI';
