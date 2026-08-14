import json
import re
import time
import urllib.request
import urllib.error

cookie = open(r'e:/AI/codex/daily-report-system/.tmp/cookie.txt', 'r', encoding='utf-8').read()
m = re.search(r'JSESSIONID\s+(\S+)', cookie)
session = m.group(1) if m else ''


def get(path):
    req = urllib.request.Request(f'http://localhost:8080{path}')
    req.add_header('Cookie', f'JSESSIONID={session}')
    t0 = time.perf_counter()
    try:
        with urllib.request.urlopen(req) as r:
            body = r.read().decode('utf-8')
            ms = (time.perf_counter() - t0) * 1000
            return r.status, json.loads(body), ms
    except urllib.error.HTTPError as e:
        ms = (time.perf_counter() - t0) * 1000
        return e.code, e.read().decode('utf-8', errors='replace'), ms


def bench(label, path):
    code, body, ms = get(path)
    if code == 200 and isinstance(body, dict) and 'items' in body:
        print(f'  [OK]   {label:<35} {ms:6.1f} ms  total={body["totalItems"]:<5} page={body["page"]}/{body["totalPages"]}  items={len(body["items"])}')
    elif code == 200 and isinstance(body, list):
        print(f'  [WARN] {label:<35} {ms:6.1f} ms  LEGACY: returned List of {len(body)} items (not paginated)')
    else:
        body_str = body if isinstance(body, str) else str(body)
        print(f'  [FAIL] {label:<35} HTTP {code}  body={body_str[:200]!r}')


print('=== 全部列表端点分页验证 ===')
bench('employees page=0 size=10',       '/api/admin/employees?page=0&size=10')
bench('employees page=2 size=20',       '/api/admin/employees?page=2&size=20')
bench('projects page=0 size=5',         '/api/admin/projects?page=0&size=5')
bench('projects 默认（无 page/size）',     '/api/admin/projects')
bench('dictionaries page=0 size=10',    '/api/admin/dictionaries?page=0&size=10')
bench('runs page=0 size=5',             '/api/admin/runs?page=0&size=5')
bench('runs page=1 size=10',            '/api/admin/runs?page=1&size=10')
bench('workday-calendar 2026 page=0',   '/api/admin/workday-calendar?year=2026&page=0&size=10')
bench('workday-calendar 2026 page=1',   '/api/admin/workday-calendar?year=2026&page=1&size=10')

print()
print('=== 报表 + N+1 ===')
bench('reports 默认',                    '/api/admin/reports')
bench('reports 日期 7/23',               '/api/admin/reports?date=2026-07-23')
bench('reports 日期 7/23 page=1',        '/api/admin/reports?date=2026-07-23&page=1&size=20')
bench('reports 日期 7/23 size=200',      '/api/admin/reports?date=2026-07-23&page=0&size=200')

print()
print('=== project-activity 分页 ===')
# Find a project ID
code, projects, ms = get('/api/admin/projects?page=0&size=5')
if code == 200 and projects.get('items'):
    pid = projects['items'][0]['id']
    bench(f'project-activity (id={pid}) page=0 size=10', f'/api/admin/projects/{pid}/activity?page=0&size=10')
    bench(f'project-activity (id={pid}) 默认', f'/api/admin/projects/{pid}/activity')
