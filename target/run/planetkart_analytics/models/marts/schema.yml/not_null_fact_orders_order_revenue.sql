
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select order_revenue
from PLANETKART.PLANETKART_ANALYTICS_planetkart_analytics.fact_orders
where order_revenue is null



  
  
      
    ) dbt_internal_test