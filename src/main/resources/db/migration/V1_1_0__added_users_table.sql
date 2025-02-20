create table public.users
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

