"""Benchmark reports endpoint: count + wall-clock time + sample items."""
import json
import re
import time
import urllib.request

cookie = open(r'e:/AI/codex/daily-report-system/.tmp/cookie.txt', 'r', encoding='utf-8').read()
m = re.search(r'JSESSIONID\s+(\S+)', cookie)
session = m.group(1) if m else ''


def get(path):
    req = urllib.request.Request(f'http://localhost:8080{path}')
    req.add_header('Cookie', f'JSESSIONID={session}')
    t0 = time.perf_counter()
    with urllib.request.urlopen(req) as r:
        body = r.read().decode('utf-8')
    elapsed_ms = (time.perf_counter() - t0) * 1000
    return json.loads(body), elapsed_ms


def bench(label, path):
    try:
        body, ms = get(path)
    except urllib.error.HTTPError as e:
        print(f'  [FAIL] {label}: HTTP {e.code} -- {e.read().decode("utf-8", errors="replace")[:200]}')
        return None
    if isinstance(body, dict) and 'items' in body:
        print(f'  [OK]   {label:<40} {ms:7.1f} ms  total={body["totalItems"]:<5} page={body["page"]}/{body["totalPages"]}  items={len(body["items"])}')
        if body['items']:
            sample = body['items'][0]
            print(f'         sample[0]: id={sample["id"]} {sample["employeeName"]} {sample["attendance"]} taskCount={sample["taskCount"]}')
    else:
        print(f'  [WARN] {label}: returned non-page payload ({len(body)} items, first type {type(body[0]).__name__ if body else "?"})')
    return ms


print('=== 报表分页 + N+1 修复 ===')
bench('无过滤 page=0 size=20', '/api/admin/reports?page=0&size=20')
bench('日期 7/23 page=0 size=20', '/api/admin/reports?date=2026-07-23&page=0&size=20')
bench('日期 7/23 page=1 size=20', '/api/admin/reports?date=2026-07-23&page=1&size=20')
bench('日期 7/23 page=0 size=50', '/api/admin/reports?date=2026-07-23&page=0&size=50')
bench('日期 7/23 + 出勤=leave', '/api/admin/reports?date=2026-07-23&attendance=leave&page=0&size=20')
bench('日期 7/23 + 关键字=公安', '/api/admin/reports?date=2026-07-23&keyword=%E5%85%AC%E5%AE%89&page=0&size=20')
bench('日期 7/23 + 关键字=公安 page=1', '/api/admin/reports?date=2026-07-23&keyword=%E5%85%AC%E5%AE%89&page=1&size=20')

print()
print('=== 默认参数（不带 page/size）应该自动用 page=0 size=20 ===')
bench('默认 page=0 size=20', '/api/admin/reports')
