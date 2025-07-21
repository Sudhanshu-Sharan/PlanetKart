
    
    

select
    customer_id as unique_field,
    count(*) as n_records

from PLANETKART.PLANETKART_ANALYTICS_planetkart_analytics.dim_customers
where customer_id is not null
group by customer_id
having count(*) > 1


