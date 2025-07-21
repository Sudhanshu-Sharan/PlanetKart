
    
    

select
    customer_sk as unique_field,
    count(*) as n_records

from PLANETKART.PLANETKART_ANALYTICS_planetkart_analytics.dim_customers
where customer_sk is not null
group by customer_sk
having count(*) > 1


