{{ config(materialized='view') }}

select
    customer_id,
    trim(first_name || ' ' || last_name) as customer_name,
    lower(trim(email)) as email,
    region_id,
    signup_date::timestamp as signup_date,
    datediff('day', signup_date, current_date()) as days_since_signup,
    case 
        when datediff('day', signup_date, current_date()) <= 30 then 'New'
        when datediff('day', signup_date, current_date()) <= 90 then 'Recent'
        else 'Established'
    end as customer_tenure,
    case when email like '%@%.%' then 'Valid' else 'Invalid' end as email_status
from {{ source('planetkart_raw', 'customers') }}
where customer_id is not null