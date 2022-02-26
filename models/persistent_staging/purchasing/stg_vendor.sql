with vendor as (

    select * from {{ source ('aw_purchasing', 'vendor') }} 

), 

final as (

    select
        BUSINESSENTITYID as business_entity_id,
        ACCOUNTNUMBER as account_number,
        NAME as name,
        CREDITRATING as credit_rating,
        PREFERREDVENDORSTATUS as preferred_vendor_status,
        ACTIVEFLAG as active_flag,
        PURCHASINGWEBSERVICEURL as purchasing_web_service_url,
        modifieddate as last_update,
        CURRENT_TIMESTAMP() AS load_date
    from vendor

)

select * from final