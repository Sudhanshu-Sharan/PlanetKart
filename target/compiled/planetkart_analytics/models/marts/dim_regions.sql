

select 
    md5(cast(coalesce(cast(region_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as region_sk,
    region_id,
    planet,
    zone,
    
    case 
        when planet = 'Earth' then 'Home_Base'
        when planet in ('Mars', 'Venus') then 'Expansion_Territory' 
        else 'Frontier'
    end as market_category,
    
    case 
        when planet = 'Earth' then 1
        when planet = 'Mars' then 2  
        when planet = 'Venus' then 3
        else 4
    end as expansion_order,
    
    current_timestamp() as created_at

from PLANETKART.PLANETKART_ANALYTICS_planetkart_stage.stg_regions