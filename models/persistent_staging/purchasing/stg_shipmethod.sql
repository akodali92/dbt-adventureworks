with shipmethod as (

    select * from {{ source ('aw_purchasing', 'shipmethod') }} 

), 

final as (

    select
        SHIPMETHODID as ship_method_id,
        NAME,
        SHIPBASE as ship_base,
        SHIPRATE as ship_rate,
        ROWGUID as row_guid,
        modifieddate as last_update,
        CURRENT_TIMESTAMP() AS load_date
    from shipmethod
    where ship_method_id is not null

)

select * from final