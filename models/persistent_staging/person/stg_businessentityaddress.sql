with businessentityaddress as (

    select * from {{ source ('aw_person', 'businessentityaddress') }} 

), 

final as (

    select
        BUSINESSENTITYID as business_entity_id,
        ADDRESSID as address_id,
        ADDRESSTYPEID as address_type_id,
        ROWGUID as row_guid,
        modifieddate as last_update,
        CURRENT_TIMESTAMP() AS load_date
    from businessentityaddress

)

select * from final