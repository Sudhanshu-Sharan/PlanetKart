--Regional Performance



-- Multi-Planetary Market Analysis
-- Regional expansion and performance insights

SELECT 
    r.planet,
    r.market_category,
    
    -- Market size metrics
    COUNT(DISTINCT f.customer_id) as unique_customers,
    COUNT(f.order_id) as total_orders,
    ROUND(SUM(f.order_revenue), 2) as total_revenue,
    ROUND(SUM(f.order_profit), 2) as total_profit,
    
    -- Performance metrics
    ROUND(AVG(f.order_revenue), 2) as avg_order_value,
    ROUND(SUM(f.order_profit) / SUM(f.order_revenue) * 100, 1) as profit_margin_pct,
    ROUND(COUNT(f.order_id) * 1.0 / COUNT(DISTINCT f.customer_id), 1) as orders_per_customer,
    
    -- Market insights
    ROUND(SUM(f.order_revenue) * 100.0 / SUM(SUM(f.order_revenue)) OVER(), 1) as market_share_pct

FROM PLANETKART.PLANETKART_ANALYTICS_planetkart_analytics.fact_orders f
JOIN PLANETKART.PLANETKART_ANALYTICS_planetkart_analytics.dim_regions r ON f.region_sk = r.region_sk
WHERE f.is_completed = 1
GROUP BY r.planet, r.market_category
ORDER BY total_profit DESC

-- Which planets are most profitable, expansion opportunities, market penetration rates