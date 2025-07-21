{{ config(materialized='view') }}

select
    region_id,
    upper(trim(planet)) as planet,
    upper(trim(zone)) as zone
    
from {{ source('planetkart_raw', 'regions') }}
where region_id is not null