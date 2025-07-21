
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        revenue_segment as value_field,
        count(*) as n_records

    from PLANETKART.PLANETKART_ANALYTICS_planetkart_analytics.dim_customers
    group by revenue_segment

)

select *
from all_values
where value_field not in (
    'High_Value','Medium_Value','Low_Value','No_Purchase'
)



  
  
      
    ) dbt_internal_test