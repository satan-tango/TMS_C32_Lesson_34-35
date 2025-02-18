/*
Создать функцию, которая находит последнего зарегистрированного пользователя.
Написал функцию, которая находит самый большой id, это и будет последний
зарегистрированный пользователь.
*/

create table user_function.users
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

alter table user_function.users
    owner to postgres;

---------------------------------
CREATE
OR REPLACE FUNCTION find_last_created_user_name()
    RETURNS varchar
    LANGUAGE plpgsql
AS
'
    DECLARE
        last_created_user_name varchar;
    BEGIN
        SELECT user_name
        INTO last_created_user_name
        FROM user_function.users
        ORDER BY id desc
        LIMIT 1;
        return last_created_user_name;
    END;
';

-----------------------------
select find_last_created_user_name();