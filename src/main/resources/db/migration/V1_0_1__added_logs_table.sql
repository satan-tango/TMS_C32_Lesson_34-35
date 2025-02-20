create table public.logs
(
    id            bigserial
        constraint logs_pk
            primary key,
    log_user_id   bigint    not null,
    log_type      varchar   not null,
    log_comment   varchar   not null,
    log_timestamp timestamp not null
);