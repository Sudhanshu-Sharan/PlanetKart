{{ config(materialized='view') }}

-- Customer Intelligence Dashboard
-- Shows key customer segments and behavioral patterns

SELECT 
    -- Customer segmentation summary
    revenue_segment,
    lifecycle_stage,
    COUNT(*) as customer_count,
    ROUND(AVG(total_revenue), 2) as avg_revenue_per_customer,
    ROUND(AVG(total_profit), 2) as avg_profit_per_customer,
    ROUND(AVG(profit_margin_pct), 1) as avg_margin_pct,
    
    -- Business insights
    ROUND(SUM(total_revenue), 2) as segment_total_revenue,
    ROUND(SUM(total_profit), 2) as segment_total_profit,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1) as pct_of_customers,
    ROUND(SUM(total_revenue) * 100.0 / SUM(SUM(total_revenue)) OVER(), 1) as pct_of_revenue

FROM {{ ref('dim_customers') }}
WHERE total_orders > 0
GROUP BY revenue_segment, lifecycle_stage
ORDER BY segment_total_profit DESC

-- Customer segment profitability, where to focus retention efforts, which segments drive revenue