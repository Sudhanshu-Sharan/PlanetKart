{{ config(materialized='table') }}

with customer_metrics as (
    select 
        c.customer_id,
        c.customer_name,
        c.email,
        c.region_id,
        c.signup_date,
        c.customer_tenure,
        
        count(o.order_id) as total_orders,
        count(case when o.order_status = 'completed' then 1 end) as completed_orders,
        sum(case when o.order_status = 'completed' then oi.line_total else 0 end) as total_revenue,
        avg(case when o.order_status = 'completed' then oi.line_total end) as avg_order_value,
        sum(case when o.order_status = 'completed' then oi.line_total - (p.cost * oi.quantity) else 0 end) as total_profit,
        max(o.order_date) as last_order_date
        
    from {{ ref('stg_customers') }} c
    left join {{ ref('stg_orders') }} o on c.customer_id = o.customer_id
    left join {{ ref('stg_order_items') }} oi on o.order_id = oi.order_id
    left join {{ ref('stg_products') }} p on oi.product_id = p.product_id
    group by 1,2,3,4,5,6
)

select 
    {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_sk,
    customer_id,
    customer_name,
    email,
    region_id,
    signup_date,
    customer_tenure,
    total_orders,
    completed_orders,
    coalesce(total_revenue, 0) as total_revenue,
    coalesce(total_profit, 0) as total_profit,
    last_order_date,
    
    -- Revenue segments
    case 
        when coalesce(total_revenue, 0) >= 150 then 'High_Value'
        when coalesce(total_revenue, 0) >= 80 then 'Medium_Value'
        when coalesce(total_revenue, 0) > 0 then 'Low_Value'
        else 'No_Purchase'
    end as revenue_segment,
    
    -- Profit segments
    case 
        when coalesce(total_profit, 0) >= 20 then 'Highly_Profitable'
        when coalesce(total_profit, 0) >= 5 then 'Profitable'
        when coalesce(total_profit, 0) > 0 then 'Low_Profit'
        else 'Unprofitable'
    end as profit_segment,
    
    -- Lifecycle stage (behavior-based)
    case 
        when total_orders = 0 then 'Never_Purchased'
        when total_orders >= 3 then 'Loyal_Customer'
        when total_orders = 2 then 'Repeat_Customer'
        when coalesce(total_revenue, 0) >= 200 then 'High_Value_Single'
        else 'One_Time_Buyer'
    end as lifecycle_stage,
    
    -- Customer type segmentation
    case 
        when total_orders >= 2 and coalesce(total_revenue, 0) >= 300 then 'VIP_Customer'
        when total_orders >= 2 and coalesce(total_revenue, 0) >= 150 then 'Premium_Repeat'
        when total_orders >= 2 then 'Standard_Repeat'
        when coalesce(total_revenue, 0) >= 200 then 'High_Potential'
        else 'Standard_Single'
    end as customer_type,
    
    -- CHURN ANALYSIS
    case 
        when total_orders = 0 then 'Never_Active'
        when last_order_date >= '2024-06-01' then 'Currently_Active'
        when last_order_date >= '2024-05-01' then 'Recently_Active'
        when last_order_date >= '2024-04-01' then 'At_Risk'
        when last_order_date >= '2024-03-01' then 'High_Churn_Risk'
        else 'Likely_Churned'
    end as churn_risk,
    
    -- Engagement pattern analysis
    case 
        when total_orders = 0 then 'No_Engagement'
        when total_orders >= 3 then 'High_Engagement'
        when total_orders = 2 then 'Repeat_Engagement'
        else 'Single_Engagement'
    end as engagement_pattern,
    
    -- Profit margin calculation
    case 
        when coalesce(total_revenue, 0) > 0 then round((coalesce(total_profit, 0) / total_revenue) * 100, 1)
        else 0 
    end as profit_margin_pct,
    
    current_timestamp() as created_at

from customer_metrics