
  create or replace   view PLANETKART.PLANETKART_ANALYTICS_advance_analytics.business_kpis
  
  
  
  
  as (
    

-- Executive KPI Dashboard - Fixed Single Row Results
WITH core_metrics AS (
    SELECT 
        SUM(order_revenue) as total_revenue,
        SUM(order_profit) as total_profit,
        ROUND(AVG(order_revenue), 2) as avg_order_value,
        COUNT(DISTINCT customer_id) as unique_customers
    FROM PLANETKART.PLANETKART_ANALYTICS_planetkart_analytics.fact_orders
    WHERE is_completed = 1
),

customer_metrics AS (
    SELECT 
        COUNT(*) as total_active_customers,
        COUNT(CASE WHEN total_orders >= 2 THEN 1 END) as repeat_customers,
        COUNT(CASE WHEN revenue_segment = 'High_Value' THEN 1 END) as high_value_customers
    FROM PLANETKART.PLANETKART_ANALYTICS_planetkart_analytics.dim_customers
    WHERE total_orders > 0
),

product_metrics AS (
    SELECT 
        MAX(total_profit) as max_profit,
        MAX(total_sales) as max_sales
    FROM PLANETKART.PLANETKART_ANALYTICS_planetkart_analytics.dim_products
),

top_product AS (
    SELECT 
        product_name as most_profitable_product
    FROM PLANETKART.PLANETKART_ANALYTICS_planetkart_analytics.dim_products
    WHERE total_profit = (SELECT MAX(total_profit) FROM PLANETKART.PLANETKART_ANALYTICS_planetkart_analytics.dim_products)
    LIMIT 1
),

best_seller AS (
    SELECT 
        product_name as best_selling_product
    FROM PLANETKART.PLANETKART_ANALYTICS_planetkart_analytics.dim_products
    WHERE total_sales = (SELECT MAX(total_sales) FROM PLANETKART.PLANETKART_ANALYTICS_planetkart_analytics.dim_products)
    LIMIT 1
),

regional_metrics AS (
    SELECT 
        COUNT(DISTINCT planet) as planets_served
    FROM PLANETKART.PLANETKART_ANALYTICS_planetkart_analytics.dim_regions
)

SELECT 
    'PlanetKart Executive Summary' as report_title,
    CURRENT_DATE() as report_date,
    
    -- Financial Metrics
    cm.total_revenue,
    cm.total_profit,
    cm.avg_order_value,
    
    -- Customer Metrics
    custm.total_active_customers,
    custm.repeat_customers,
    custm.high_value_customers,
    
    -- Product Performance
    tp.most_profitable_product,
    pm.max_profit as highest_product_profit,
    bs.best_selling_product,
    pm.max_sales as highest_sales_count,
    
    -- Regional Data
    rm.planets_served,
    
    -- Business Ratios
    ROUND(cm.total_profit / cm.total_revenue * 100, 1) as overall_profit_margin,
    ROUND(custm.repeat_customers * 100.0 / custm.total_active_customers, 1) as repeat_customer_rate

FROM core_metrics cm
CROSS JOIN customer_metrics custm
CROSS JOIN product_metrics pm
CROSS JOIN top_product tp
CROSS JOIN best_seller bs
CROSS JOIN regional_metrics rm
  );

