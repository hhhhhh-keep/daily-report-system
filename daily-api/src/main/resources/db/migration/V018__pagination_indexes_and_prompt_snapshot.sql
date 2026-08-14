-- 报表分页与 SQL 优化
-- 1. daily_reports 按日期倒序的复合索引，覆盖报表默认排序 + 日期筛选
create index if not exists ix_daily_reports_report_date_desc
  on daily_reports(report_date desc);

-- 2. pg_trgm GIN 索引：加速项目名 / 任务进度的模糊查询
--    不带前导通配时 B-tree 可用，但用户输入总是带 % 前缀，
--    必须用 trigram 才能让 LIKE '%x%' 走索引扫描而非顺序扫描
create extension if not exists pg_trgm;
create index if not exists ix_projects_name_trgm
  on projects using gin (lower(name) gin_trgm_ops);
create index if not exists ix_daily_tasks_progress_trgm
  on daily_tasks using gin (lower(progress_result) gin_trgm_ops);

-- 3. analysis_runs 补 prompt_version_snapshot 列（之前漏建，导致 runs 列表 500）
alter table analysis_runs
  add column if not exists prompt_version_snapshot varchar(40);
