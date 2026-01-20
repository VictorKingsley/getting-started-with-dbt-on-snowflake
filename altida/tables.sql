create or replace table my_target_table (
    A number not null,
    B varchar not null,
    C varchar,
    D number,
    E timestamp_ntz,

    constraint pk_my_target primary key (A, B)
);
