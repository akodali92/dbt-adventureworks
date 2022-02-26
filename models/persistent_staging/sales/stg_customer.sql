with customer as (

    select * from {{ source ('aw_sales', 'customer') }} 

), 

final as (

    select
        CUSTOMERID as customer_id,
        PERSONID as person_id,
        STOREID as store_id,
        TERRITORYID as territory_id,
        ACCOUNTNUMBER as account_number,
        ROWGUID as row_guid,
        modifieddate as last_update,
        CURRENT_TIMESTAMP() AS load_date
    from customer

)

select * from final