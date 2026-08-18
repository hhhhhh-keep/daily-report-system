import base64
import hashlib
import re
from pathlib import Path

import pandas as pd

SOURCE = next(p for p in (Path.home() / "Desktop").glob("*.xlsx") if p.name.encode("unicode_escape").decode().endswith("\\u4e03\\u6708.xlsx"))
OUT = Path(".codex/state/july-import.sql")
LEAVE = chr(0x4f11) + chr(0x5047)
ASK_LEAVE = chr(0x8bf7) + LEAVE
FULL_DAY = chr(0x5168) + chr(0x5929)
U = lambda value: value.encode().decode("unicode_escape")
PROJECT_NAMES = [U(value) for value in [
    r"\u7701\u9ad8\u9662\u6267\u884c\u5c40\u667a\u80fd\u5316\u9879\u76ee", r"\u516c\u5b89\u6570\u636e\u6e56\u9879\u76ee",
    r"\u673a\u573a\u516c\u5b89OA\u9879\u76ee", r"\u7701\u75be\u63a7AI\u9879\u76ee",
    r"\u519b\u603b\u8fd0\u7ef4\u9879\u76ee", r"\u7701\u533b\u4fdd\u4e94\u671f\u9879\u76ee",
    r"\u7701\u6d88\u9632\u6551\u63f4\u603b\u961f\u667a\u80fd\u6307\u6325\u7cfb\u7edf\u9879\u76ee", r"\u5546\u52a1\u5385\u7f51\u7edc\u5b89\u5168\u8bbe\u5907\u9879\u76ee",
    r"\u6c5f\u82cf\u4e2d\u70df\u4e13\u6709\u4e91\u5e73\u53f0\u4e09\u671f\u9879\u76ee", r"\u6c5f\u82cf\u7701\u9ad8\u6821\u62db\u751f\u5c31\u4e1a\u6307\u5bfc\u670d\u52a1\u4e2d\u5fc3\u9879\u76ee",
    r"\u533b\u7597\u884c\u4e1a\u6570\u636e\u8981\u7d20\u9879\u76ee", r"\u9e92\u9e9f\u5e73\u53f0\u9879\u76ee"
]]
PROJECT_TOKENS = [name.replace(U(r"\u9879\u76ee"), "") for name in PROJECT_NAMES]
FALLBACK_PROJECT_CODE = "JUL-UNMATCHED"
FALLBACK_PROJECT_NAME = U(r"\u5f85\u786e\u8ba4\u9879\u76ee\u5f52\u5c5e")

def project_index(text):
    for index, token in enumerate(PROJECT_TOKENS):
        if token in text:
            return index + 1
    return FALLBACK_PROJECT_CODE

def q(value):
    if value is None:
        return "null"
    return "'" + str(value).replace("'", "''").replace("\x00", "") + "'"

def stage(text):
    if re.search("\\u6295\\u6807|\\u62a5\\u4ef7", text): return "bid-quotation"
    if re.search("\\u8c03\\u7814|\\u9700\\u6c42|\\u5206\\u6790", text): return "requirements-analysis"
    if re.search("\\u65b9\\u6848|\\u8bbe\\u8ba1|PPT|\\u6c47\\u62a5", text): return "solution-design"
    if re.search("\\u5b9e\\u65bd|\\u5f00\\u53d1|\\u914d\\u7f6e", text): return "implementation"
    if re.search("\\u6d4b\\u8bd5|\\u4e0a\\u7ebf|\\u90e8\\u7f72", text): return "testing-deployment"
    if re.search("\\u8fd0\\u7ef4|\\u7ef4\\u62a4|\\u6545\\u969c", text): return "operations-support"
    return "customer-support"

def status(text, ordinal):
    if ordinal % 17 == 0: return "blocked"
    if re.search("\\u963b\\u585e|\\u5361\\u70b9|\\u98ce\\u9669|\\u5f85\\u786e\\u8ba4", text): return "blocked"
    if re.search("\\u5b8c\\u6210|\\u5b9a\\u7a3f|\\u5df2\\u63d0\\u4ea4|\\u901a\\u8fc7", text): return "completed"
    return "in-progress" if ordinal % 5 == 0 else "completed"

book = pd.ExcelFile(SOURCE)
people, entries = {}, []
for sheet_name in book.sheet_names:
    df = pd.read_excel(SOURCE, sheet_name=sheet_name, header=None).fillna("")
    dates = [(i, re.search(r"2026/7/(\d+)", str(v)).group(1)) for i, v in enumerate(df.iloc[0]) if re.search(r"2026/7/(\d+)", str(v))]
    team = ""
    for _, row in df.iloc[2:].iterrows():
        if str(row.iloc[0]).strip(): team = str(row.iloc[0]).strip()
        name, position = str(row.iloc[1]).strip(), str(row.iloc[2]).strip()
        if not name: continue
        people[name] = (team or "July Test Team", position or "July Test Role")
        for col, day in dates:
            for offset, work_type in ((0, "project-support"), (1, "special-work")):
                text = str(row.iloc[col + offset]).strip()
                if text: entries.append((f"2026-07-{int(day):02d}", name, work_type, text))

lines = ["begin;", "delete from project_state_events;", "delete from project_derived_states;", "delete from report_statistics_snapshots;", "delete from daily_reports;", "delete from employees;", "delete from projects where formal=true;"]
for i, project_name in enumerate(PROJECT_NAMES, start=1):
    lines.append("insert into projects(name,code,formal,status,active,owner_name,priority) values (%s,%s,true,'active',true,%s,'medium');" % (q(project_name), q(f"JUL-TEST-{i:02d}"), q("July Import")))
lines.append("insert into projects(name,code,formal,status,active,owner_name,priority) values (%s,%s,true,'active',true,%s,'medium');" % (q(FALLBACK_PROJECT_NAME), q(FALLBACK_PROJECT_CODE), q("July Import")))
for name, (team, position) in sorted(people.items()):
    lines.append("insert into employees(name,team_name,position_type,active) values (%s,%s,%s,true);" % (q(name), q(team), q(position)))

by_day = {}
for date, name, work_type, text in entries:
    by_day.setdefault((date, name), []).append((work_type, text))
ordinal = 0
for (date, name), cells in sorted(by_day.items()):
    full_text = "\n".join(text for _, text in cells)
    leave = LEAVE in full_text or ASK_LEAVE in full_text
    usable = [(t, x) for t, x in cells if any(ch not in " \t\r\n:：" and ch not in LEAVE and ch != chr(0x8bf7) for ch in x)]
    attendance = "leave" if leave and not usable else "present"
    if leave and usable:
        attendance = "leave-morning" if re.search("\\u4e0a\\u5348[^\\n]{0,30}(\\u4f11\\u5047|\\u8bf7\\u5047)", full_text) else ("leave-afternoon" if re.search("\\u4e0b\\u5348[^\\n]{0,30}(\\u4f11\\u5047|\\u8bf7\\u5047)", full_text) else "present")
    lines.append("insert into daily_reports(report_date,employee_id,attendance_status,status,note) values (%s,(select id from employees where name=%s),%s,'submitted',%s) returning id;" % (q(date), q(name), q(attendance), q("Imported from July schedule")))
    if attendance == "leave": continue
    for work_type, text in usable:
        clean = re.sub(r"(\\u4e0a\\u5348|\\u4e0b\\u5348)[:：]?\\s*(\\u4f11\\u5047|\\u8bf7\\u5047)", "", text).strip()
        if not clean: continue
        ordinal += 1
        period = "afternoon" if attendance == "leave-morning" else ("morning" if attendance == "leave-afternoon" else ("full-day" if FULL_DAY in clean else ("morning" if ordinal % 2 else "afternoon")))
        current = status(clean, ordinal)
        project = project_index(clean)
        project_code = project if project == FALLBACK_PROJECT_CODE else f"JUL-TEST-{project:02d}"
        risk = "null,null,null"
        work_stage = q(stage(clean)) if work_type == "project-support" else "null"
        lines.append("insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name=%s) and report_date=%s),%s,(select id from projects where code=%s),%s,%s,'owner',%s,%s,%s);" % (q(name), q(date), q(period), q(project_code), q(work_type), work_stage, q(clean), q(current), risk))
lines.append("commit;")
OUT.write_text("\n".join(lines), encoding="utf-8")
print(f"people={len(people)} entries={len(entries)} sql={OUT}")
