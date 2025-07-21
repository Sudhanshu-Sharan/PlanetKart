{{ config(materialized='table') }}

select 
    {{ dbt_utils.generate_surrogate_key(['region_id']) }} as region_sk,
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

from {{ ref('stg_regions') }}