
create table user_trigger.users
(
    id            bigserial
        constraint users_pk
            primary key,
    user_name     varchar not null,
    user_surname  varchar not null,
    user_passport varchar not null
        unique,
    user_email    varchar not null,
    user_age      integer not null
);

alter table user_trigger.users
    owner to postgres;

----------------------------------

create table user_trigger.logs
(
    id            bigserial
        constraint logs_pk
            primary key,
    log_user_id   bigint    not null,
    log_type      varchar   not null,
    log_comment   varchar   not null,
    log_timestamp timestamp not null
);

alter table user_trigger.logs
    owner to postgres;

-----------------------------------

/*
Функция и триггер для добавления в таблице logs при удалении пользователя
*/


CREATE
or replace FUNCTION add_log_record_deleted_user() RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$$
BEGIN
INSERT INTO user_trigger.logs (id, log_user_id, log_type, log_comment, log_timestamp)
VALUES (Default, OLD.id, 'DELETED', 'user with name: ' || OLD.user_name || ' was deleted', now());
RETURN OLD;
END;
$$;

create trigger add_user_delete_trg
    before delete
    on user_trigger.users
    for each row
    execute function add_log_record_deleted_user();

-------------------
/*
Функция и триггер для добавления в таблице logs при создании пользователя
*/

create or replace function add_log_record_created_user() returns trigger
    language plpgsql
as
$$
BEGIN
INSERT INTO user_trigger.logs (id, log_user_id, log_type, log_comment, log_timestamp)
VALUES (Default, new.id, 'CREATED', 'user with name: ' || new.user_name || ' was created', now());
RETURN new;
END;
$$;

create trigger add_user_create_trg
    after insert
    on user_trigger.users
    for each row
    execute function add_log_record_created_user() ;
