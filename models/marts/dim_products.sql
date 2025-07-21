{{ config(materialized='table') }}

with product_metrics as (
    select 
        p.product_id,
        p.product_name,
        p.category,
        p.sku,
        p.cost,
        
        count(oi.order_id) as total_sales,
        sum(oi.quantity) as total_quantity_sold,
        sum(oi.line_total) as total_revenue,
        avg(oi.unit_price) as avg_selling_price,
        sum(oi.line_total - (p.cost * oi.quantity)) as total_profit,
        avg(oi.unit_price - p.cost) as avg_profit_per_unit,
        count(distinct o.customer_id) as unique_customers,
        max(o.order_date) as last_sold_date
        
    from {{ ref('stg_products') }} p
    left join {{ ref('stg_order_items') }} oi on p.product_id = oi.product_id
    left join {{ ref('stg_orders') }} o on oi.order_id = o.order_id 
    where o.order_status = 'completed' or o.order_status is null
    group by 1,2,3,4,5
)

select 
    {{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_sk,
    product_id,
    product_name,
    category,
    sku,
    cost,
    coalesce(total_sales, 0) as total_sales,
    coalesce(total_quantity_sold, 0) as total_quantity_sold,
    coalesce(total_revenue, 0) as total_revenue,
    coalesce(total_profit, 0) as total_profit,
    coalesce(unique_customers, 0) as unique_customers,
    last_sold_date,
    
    case 
        when coalesce(total_profit, 0) >= 30 then 'High_Profit'
        when coalesce(total_profit, 0) >= 10 then 'Medium_Profit'
        when coalesce(total_profit, 0) > 0 then 'Low_Profit'
        when coalesce(total_profit, 0) < 0 then 'Loss_Making'
        else 'Never_Sold'
    end as profit_segment,
    
    case 
        when coalesce(total_sales, 0) >= 3 then 'Best_Seller'
        when coalesce(total_sales, 0) >= 2 then 'Good_Seller'
        when coalesce(total_sales, 0) = 1 then 'Slow_Mover'
        else 'No_Sales'
    end as sales_performance,
    
    case 
        when coalesce(total_revenue, 0) > 0 then round((coalesce(total_profit, 0) / total_revenue) * 100, 1)
        else 0 
    end as profit_margin_pct,
    
    current_timestamp() as created_at

from product_metrics