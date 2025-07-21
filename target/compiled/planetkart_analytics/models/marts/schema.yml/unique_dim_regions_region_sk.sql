
    
    

select
    region_sk as unique_field,
    count(*) as n_records

from PLANETKART.PLANETKART_ANALYTICS_planetkart_analytics.dim_regions
where region_sk is not null
group by region_sk
having count(*) > 1


