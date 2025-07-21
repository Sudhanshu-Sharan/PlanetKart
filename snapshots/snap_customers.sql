{% snapshot snap_customers %}
{{
    config(
        target_schema='snapshots',
        unique_key='customer_id',
        strategy='check',
        check_cols=[
            'email',
            'region_id', 
            'customer_tier',
            'lifecycle_stage',
            'revenue_segment'
        ],
    )
}}

select
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.region_id,
    c.signup_date,
    
    case
        when dc.total_revenue >= 300 then 'Platinum'
        when dc.total_revenue >= 150 then 'Gold'
        when dc.total_revenue >= 50 then 'Silver'
        else 'Bronze'
    end as customer_tier,
    
    coalesce(dc.lifecycle_stage, 'New_Signup') as lifecycle_stage,
    coalesce(dc.revenue_segment, 'No_Purchase') as revenue_segment,
    coalesce(dc.total_orders, 0) as total_orders,
    coalesce(dc.total_revenue, 0) as total_revenue,
    
    current_timestamp() as snapshot_timestamp

from {{ source('planetkart_raw', 'customers') }} c
left join {{ ref('dim_customers') }} dc 
    on c.customer_id = dc.customer_id

{% endsnapshot %}
