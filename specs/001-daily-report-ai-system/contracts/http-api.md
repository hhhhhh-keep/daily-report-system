# HTTP 接口契约

## 员工接口

- `GET /api/report/options`：返回在岗 employees、projects、dictionaries 和 non-formal options。
- `GET /api/reports?employeeId=&date=`：返回所选 employee/date 的当前日报。
- `PUT /api/reports/current`：创建或更新一份当前日报及其完整任务集合。

保存 payload 包含 employee、date、attendance、可选 note 和 task array。必须使用有效引用和任务字段；重复 employee/date 更新而非创建。

## 管理员接口

- `POST/DELETE /api/admin/session`、`PUT /api/admin/password`
- CRUD：employees、projects、dictionaries、reports、analysis configuration、schedules、email/model settings。
- 读取：dashboard、personnel/project/risk/resource analysis、reports、task runs。
- `POST /api/admin/runs/{id}/retry`：重新运行失败/部分失败的运行。

## 内部流程

Quartz 调用 metrics/rules → LLM analysis → HTML/PDF report → SMTP email。失败记录 outcome；重试必须避免重复成功投递。
