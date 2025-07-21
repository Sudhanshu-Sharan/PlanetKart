

select
    order_id,
    product_id,
    quantity,
    unit_price,
    
    -- Key metrics for analysis
    quantity * unit_price as line_total
    
from planetkart.planetkart_raw.order_items
where order_id is not null and product_id is not null