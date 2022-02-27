with vendor as (

    select
        business_entity_id,
        account_number,
        name,
        credit_rating,
        preferred_vendor_status,
        active_flag,
        purchasing_web_service_url,
        last_update,
        load_date
    from {{ ref ('stg_vendor') }}
)

select * from vendor