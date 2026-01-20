select * from (
    select
        1 as A,
        'X001' as B,
        'Alpha' as C,
        10 as D,
        current_timestamp as E

    union all

    select
        2 as A,
        'X002' as B,
        'Beta' as C,
        20 as D,
        current_timestamp as E

    union all

    select
        3 as A,
        'X003' as B,
        'Gamma' as C,
        30 as D,
        current_timestamp as E

    union all

    select
        4 as A,
        'X004' as B,
        'Delta' as C,
        40 as D,
        current_timestamp as E

    union all

    select
        5 as A,
        'X005' as B,
        'Epsilon' as C,
        50 as D,
        current_timestamp as E
) src
