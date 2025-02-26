{{
  config(
        materialized = 'table',
        location_root = 's3://data-trainings-dev-bucket/databricks-coding-dojo/jnadal/transformed/'
    )
}}

with final as (
    select
        date_trunc('hour', created_at) as _hour
        , count(1) as nb_commands
        , sum(amount) as turnover
        , max(now()) as inserted_at
    from
        {{ ref('base_orders') }}
    group by
        1
)

select * from final
