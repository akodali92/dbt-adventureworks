with addresstype as (

    select * from {{ source ('aw_person', 'addresstype') }} 

), 

final as (

    select
        ADDRESSTYPEID as address_type_id,
        "NAME" as name,
        ROWGUID as row_guid,
        modifieddate as last_update,
        CURRENT_TIMESTAMP() AS load_date
    from addresstype

)

select * from final