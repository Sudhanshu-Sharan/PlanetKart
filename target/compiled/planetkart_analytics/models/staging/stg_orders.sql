

select
    order_id,
    customer_id,
    order_date::timestamp as order_date,
    lower(trim(status)) as order_status,
    
    -- Useful for analysis
    case when lower(status) = 'completed' then 1 else 0 end as is_completed,
    date_trunc('month', order_date::timestamp) as order_month
    
from planetkart.planetkart_raw.orders
where order_id is not null