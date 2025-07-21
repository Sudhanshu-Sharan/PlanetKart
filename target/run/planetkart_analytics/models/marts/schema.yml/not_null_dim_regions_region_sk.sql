
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select region_sk
from PLANETKART.PLANETKART_ANALYTICS_planetkart_analytics.dim_regions
where region_sk is null



  
  
      
    ) dbt_internal_test