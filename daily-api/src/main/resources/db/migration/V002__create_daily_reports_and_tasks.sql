create table daily_reports (
    id bigserial primary key,
    report_date date not null,
    employee_id bigint not null references employees(id),
    attendance_status varchar(50) not null,
    note varchar(2000),
    status varchar(30) not null default 'submitted',
    submitted_at timestamptz not null default now(),
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    constraint uk_daily_reports_employee_date unique (employee_id, report_date),
    constraint ck_daily_reports_status check (status in ('submitted'))
);

create table daily_tasks (
    id bigserial primary key,
    report_id bigint not null references daily_reports(id) on delete cascade,
    time_period varchar(30) not null,
    project_id bigint not null references projects(id),
    work_type varchar(100) not null,
    participation_role varchar(30) not null,
    progress_result varchar(4000) not null,
    current_status varchar(30) not null,
    issue_type varchar(100),
    collaboration_role varchar(100),
    collaboration_requirement varchar(2000),
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    constraint ck_daily_tasks_time_period
        check (time_period in ('morning', 'afternoon', 'full-day', 'fragmented')),
    constraint ck_daily_tasks_participation_role
        check (participation_role in ('owner', 'collaborator', 'temporary-support')),
    constraint ck_daily_tasks_current_status
        check (current_status in ('completed', 'progressing', 'waiting-feedback', 'at-risk', 'blocked'))
);

create index idx_daily_reports_report_date on daily_reports(report_date);
create index idx_daily_tasks_report_id on daily_tasks(report_id);
create index idx_daily_tasks_project_id on daily_tasks(project_id);
