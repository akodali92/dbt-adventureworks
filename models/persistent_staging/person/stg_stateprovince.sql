with stateprovince as (

    select * from {{ source ('aw_person', 'stateprovince') }} 

), 

final as (

    select
        STATEPROVINCEID as state_province_id,
        STATEPROVINCECODE as state_province_abbv,
        COUNTRYREGIONCODE as country_region_abbv,
        NAME as state_province,
        TERRITORYID as territory_id,
        ROWGUID as row_guid,
        modifieddate as last_update,
        CURRENT_TIMESTAMP() AS load_date
    from stateprovince
    where state_province_id is not null

)

select * from final