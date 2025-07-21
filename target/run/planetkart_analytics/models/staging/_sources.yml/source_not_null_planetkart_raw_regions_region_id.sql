
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select region_id
from planetkart.planetkart_raw.regions
where region_id is null



  
  
      
    ) dbt_internal_test