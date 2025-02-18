create table if not exists library.book
(
    id          bigserial not null
    constraint book_pk
    primary key,
    book_name   varchar not null,
    book_author varchar not null,
    book_year   integer not null
);

--------------------------

create table library.users
(
    id         bigserial
        constraint users_pk
            primary key,
    user_name  varchar not null,
    user_email varchar not null
);

--------------------------------

create table if not exists library.bookings
(
    id                bigserial
    constraint bookings_pk
    primary key,
    booking_timestamp timestamp not null,
    return_timestamp  timestamp not null,
    book_id           bigint    not null
    constraint book_id_fk
    references library.book
    on update cascade on delete cascade,
    user_id           bigint    not null
    constraint user_id_fk
    references library.users
    on update cascade on delete cascade
);
-------------------------------------------