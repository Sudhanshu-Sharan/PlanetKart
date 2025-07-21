{{ config(materialized='table') }}

with order_facts as (
    select 
        o.order_id,
        o.customer_id,
        c.region_id,
        o.order_date,
        o.order_status,
        
        -- Order metrics (aggregated from order items)
        sum(oi.quantity) as total_quantity,
        sum(oi.line_total) as order_revenue,
        sum(p.cost * oi.quantity) as order_cost,
        sum(oi.line_total - (p.cost * oi.quantity)) as order_profit,
        count(oi.product_id) as products_count
        
    from {{ ref('stg_orders') }} o
    left join {{ ref('stg_order_items') }} oi on o.order_id = oi.order_id
    left join {{ ref('stg_products') }} p on oi.product_id = p.product_id
    left join {{ ref('stg_customers') }} c on o.customer_id = c.customer_id
    group by o.order_id, o.customer_id, c.region_id, o.order_date, o.order_status
)

select 
    -- Surrogate keys for star schema
    {{ dbt_utils.generate_surrogate_key(['order_id']) }} as order_sk,
    {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_sk,
    {{ dbt_utils.generate_surrogate_key(['region_id']) }} as region_sk,
    
    -- Natural keys
    order_id,
    customer_id,
    region_id,
    order_date,
    order_status,
    
    -- Measures
    total_quantity,
    order_revenue,
    order_cost,
    order_profit,
    products_count,
    
    -- Business metrics
    case 
        when order_profit >= 20 then 'High_Profit'
        when order_profit >= 5 then 'Medium_Profit'
        when order_profit > 0 then 'Low_Profit'
        else 'No_Profit'
    end as profit_tier,
    
    case 
        when order_revenue >= 150 then 'Large'
        when order_revenue >= 80 then 'Medium'
        else 'Small'
    end as order_size,
    
    case when order_status = 'completed' then 1 else 0 end as is_completed,
    
    current_timestamp() as created_at

from order_facts