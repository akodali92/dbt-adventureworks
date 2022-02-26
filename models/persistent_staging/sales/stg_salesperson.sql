with salesperson as (

    select * from {{ source ('aw_sales', 'salesperson') }} 

), 

final as (

    select
        BUSINESSENTITYID as business_entity_id,
        TERRITORYID as territory_id,
        SALESQUOTA as sales_quota,
        BONUS as bonus,
        COMMISSIONPCT as commission_pct,
        SALESYTD as sales_ytd,
        SALESLASTYEAR as sales_last_year,
        ROWGUID as row_guid,
        modifieddate as last_update,
        CURRENT_TIMESTAMP() AS load_date
    from salesperson

)

select * from final