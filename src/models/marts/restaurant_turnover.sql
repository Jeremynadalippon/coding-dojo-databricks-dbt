{{
    config(
        materialized='table',
    )
}}

with orders as (
    select * from {{ ref("base_orders") }}
)

, grouped as (
    select
        restaurant_identifier
        , sum(amount) as turnover
    from
        orders
    group by
        restaurant_identifier
)

, final as (
    select
        *
        , '{{ var("date_from") }}' as date_from
        , '{{ run_started_at }}' as run_started_at
    from
        grouped
)
select
    *
from
    final
order by
    turnover desc
