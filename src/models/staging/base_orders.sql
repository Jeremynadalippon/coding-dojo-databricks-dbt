select
    *
from
    {{ source("sources", "orders") }}
where
    order_date >= '{{ var("date_from") }}'