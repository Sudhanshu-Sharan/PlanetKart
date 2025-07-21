
    
    

select
    product_sk as unique_field,
    count(*) as n_records

from PLANETKART.PLANETKART_ANALYTICS_planetkart_analytics.dim_products
where product_sk is not null
group by product_sk
having count(*) > 1


