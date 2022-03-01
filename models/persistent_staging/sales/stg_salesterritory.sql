with salesterritory as (

    select * from {{ source ('aw_sales', 'salesterritory') }} 

), 

final as (

    select
        TERRITORYID as territory_id,
        "NAME" as territory_name,
        COUNTRYREGIONCODE as country_region_code,
        "GROUP" as territory_group,
        SALESYTD as sales_ytd,
        SALESLASTYEAR as sales_last_year,
        ROWGUID as row_guid,
        modifieddate as last_update,
        CURRENT_TIMESTAMP() AS load_date
    from salesterritory
    where territory_id is not null

)

select * from final