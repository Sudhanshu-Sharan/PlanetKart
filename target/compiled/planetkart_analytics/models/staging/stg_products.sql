

select
    product_id,
    trim(product_name) as product_name,
    trim(category) as category,
    trim(sku) as sku,
    cost,
    
    -- Basic data cleaning
    case when cost <= 0 or cost is null then 'Invalid' else 'Valid' end as cost_flag,
    upper(left(category, 1)) || lower(substring(category, 2)) as category_clean
    
from planetkart.planetkart_raw.products
where product_id is not null