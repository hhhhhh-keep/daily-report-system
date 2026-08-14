"""Apply V016 via psycopg2 (psql not on PATH)."""
import psycopg2

conn = psycopg2.connect(
    host='localhost', port=5432,
    dbname='daily_report_dev', user='drs_pg_admin', password='1qaz@WSX',
)
conn.autocommit = True
cur = conn.cursor()

with open(r'e:/AI/codex/daily-report-system/daily-api/src/main/resources/db/migration/V016__pagination_indexes_and_prompt_snapshot.sql', encoding='utf-8') as f:
    sql = f.read()

print('--- applying V016 ---')
try:
    cur.execute(sql)
    print('  OK')
except Exception as e:
    print(f'  ERROR: {e}')

# Verify
cur.execute("""
  select indexname from pg_indexes
  where schemaname='public'
  and indexname in ('ix_daily_reports_report_date_desc',
                    'ix_projects_name_trgm',
                    'ix_daily_tasks_progress_trgm')
  order by indexname
""")
print('--- new indexes ---')
for row in cur.fetchall():
    print(f'  {row[0]}')

cur.execute("""
  select column_name from information_schema.columns
  where table_name='analysis_runs' and column_name='prompt_version_snapshot'
""")
print('--- prompt_version_snapshot column ---')
for row in cur.fetchall():
    print(f'  {row[0]}')

conn.close()
