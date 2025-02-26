{{
    config(
        materialized = 'ephemeral'
    )
}}

select
    *
from
    {{ custom_source('sources', 'orders') }}