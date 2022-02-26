with address as (

    select * from {{ source ('aw_person', 'address') }} 

), 

final as (

    select
        ADDRESSID as address_id,
        ADDRESSLINE1 as address_line_1,
        ADDRESSLINE2 as address_line_2,
        CITY as city,
        STATEPROVINCEID as state_province_id,
        POSTALCODE as postal_code,
        SPATIALLOCATION as spatial_location,
        ROWGUID as row_guid,
        modifieddate as last_update,
        CURRENT_TIMESTAMP() AS load_date
    from address

)

select * from final