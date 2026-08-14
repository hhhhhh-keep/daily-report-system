"""Diagnose: did the keyword=公安 count change?"""
import json
import re
import urllib.request

cookie = open(r'e:/AI/codex/daily-report-system/.tmp/cookie.txt', 'r', encoding='utf-8').read()
m = re.search(r'JSESSIONID\s+(\S+)', cookie)
session = m.group(1) if m else ''


def get(path):
    req = urllib.request.Request(f'http://localhost:8080{path}')
    req.add_header('Cookie', f'JSESSIONID={session}')
    with urllib.request.urlopen(req) as r:
        return json.loads(r.read().decode('utf-8'))


# Pull the admin project list to find 公安 projects
projects = get('/api/admin/projects')
print(f'{len(projects)} projects')
for p in projects:
    if '公安' in p['name']:
        print(f'  matching: id={p["id"]} name={p["name"]}')

# Try keyword=公安 WITHOUT date filter — should match all dates
print()
print('=== 关键字=公安 无日期过滤，期望 > 1 行 ===')
r = get('/api/admin/reports?keyword=%E5%85%AC%E5%AE%89&page=0&size=200')
print(f'  total={r["totalItems"]} items={len(r["items"])}')
for x in r['items'][:30]:
    print(f'    {x["date"]}  {x["employeeName"]} ({x["attendance"]})  taskCount={x["taskCount"]}')

# Try same with date filter
print()
print('=== 关键字=公安 + date=7/23，期望匹配 7/23 那天有 公安 项目任务的员工 ===')
r = get('/api/admin/reports?date=2026-07-23&keyword=%E5%85%AC%E5%AE%89&page=0&size=200')
print(f'  total={r["totalItems"]} items={len(r["items"])}')
for x in r['items']:
    print(f'    {x["date"]}  {x["employeeName"]} ({x["attendance"]})  taskCount={x["taskCount"]}')
