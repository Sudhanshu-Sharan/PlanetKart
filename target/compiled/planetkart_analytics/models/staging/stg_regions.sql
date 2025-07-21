

select
    region_id,
    upper(trim(planet)) as planet,
    upper(trim(zone)) as zone
    
from planetkart.planetkart_raw.regions
where region_id is not null