create table administrators (
    id smallint primary key,
    username varchar(80) not null unique,
    password_hash varchar(100) not null,
    password_changed_at timestamptz,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    constraint ck_administrators_singleton check (id = 1)
);
