with salesterritoryhistory as (

    select * from {{ source ('aw_sales', 'salesterritoryhistory') }} 

), 

final as (

    select
        -- showing another way to make a SK
        BUSINESSENTITYID || '~' || TERRITORYID as sales_territory_history_sk,
        BUSINESSENTITYID as business_entity_id,
        TERRITORYID as territory_id,
        to_timestamp_ntz(STARTDATE) as start_date,
        to_timestamp_ntz(ENDDATE) as end_date,
        ROWGUID as row_guid,
        modifieddate as last_update,
        CURRENT_TIMESTAMP() AS load_date
    from salesterritoryhistory

)

select * from final