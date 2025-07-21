
  create or replace   view PLANETKART.PLANETKART_ANALYTICS_advance_analytics.product_insights
  
  
  
  
  as (
    --Product Performance



-- Product Portfolio Analysis
-- Identifies winners, losers, and opportunities

SELECT 
    category,
    profit_segment,
    COUNT(*) as products_in_segment,
    ROUND(SUM(total_revenue), 2) as category_revenue,
    ROUND(SUM(total_profit), 2) as category_profit,
    ROUND(AVG(profit_margin_pct), 1) as avg_margin,
    
    -- Top performer in each category
    MAX(CASE WHEN total_profit > 0 THEN product_name END) as top_product,
    MAX(total_profit) as highest_profit,
    
    -- Performance insights
    ROUND(SUM(total_revenue) * 100.0 / SUM(SUM(total_revenue)) OVER(), 1) as pct_of_total_revenue,
    COUNT(CASE WHEN sales_performance = 'Best_Seller' THEN 1 END) as best_sellers_count

FROM PLANETKART.PLANETKART_ANALYTICS_planetkart_analytics.dim_products
GROUP BY category, profit_segment
HAVING SUM(total_revenue) > 0
ORDER BY category_profit DESC

--Which categories are most profitable, product mix optimization, inventory focus areas
  );

