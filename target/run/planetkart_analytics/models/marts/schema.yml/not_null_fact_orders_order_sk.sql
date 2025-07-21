
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select order_sk
from PLANETKART.PLANETKART_ANALYTICS_planetkart_analytics.fact_orders
where order_sk is null



  
  
      
    ) dbt_internal_test