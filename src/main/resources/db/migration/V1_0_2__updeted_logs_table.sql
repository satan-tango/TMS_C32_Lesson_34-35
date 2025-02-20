alter table public.logs
drop column log_type;

alter table public.logs
    add log_type_operation varchar not null;
