{% snapshot snap_customers %}

{{
    config(
      target_schema='snapshots',
      unique_key='customer_id',
      strategy='timestamp',
      updated_at='signup_date',
    )
}}

select 
    customer_id,
    first_name,
    last_name,
    email,
    region_id,
    signup_date
from {{ source('planetkart_raw', 'customers') }}

{% endsnapshot %}