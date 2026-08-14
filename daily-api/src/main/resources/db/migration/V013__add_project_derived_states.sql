create table project_derived_states (
  project_id bigint primary key references projects(id) on delete cascade,
  state varchar(50) not null,
  lifecycle varchar(30),
  current_stage varchar(100),
  state_started_date date not null,
  trigger_task_id bigint not null references daily_tasks(id),
  updated_at timestamptz not null default now()
);

create table project_state_events (
  id bigserial primary key,
  project_id bigint not null references projects(id) on delete cascade,
  state varchar(50) not null,
  current_stage varchar(100),
  trigger_task_id bigint not null references daily_tasks(id),
  occurred_date date not null,
  created_at timestamptz not null default now()
);

create index ix_project_state_events_project_date on project_state_events(project_id, occurred_date desc);
