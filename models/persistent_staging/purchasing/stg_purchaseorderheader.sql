with purchaseorderheader as (

    select * from {{ source ('aw_purchasing', 'purchaseorderheader') }} 

), 

final as (

    select
        PURCHASEORDERID as purchase_order_id,
        REVISIONNUMBER as revision_number,
        STATUS as status_id,
        EMPLOYEEID as employee_id,
        VENDORID as vendor_id,
        SHIPMETHODID as ship_method_id,
        to_timestamp_ntz(ORDERDATE) as order_date,
        to_timestamp_ntz(SHIPDATE) as ship_date,
        SUBTOTAL as sub_total,
        TAXAMT as tax_amt,
        FREIGHT,
        TOTALDUE as total_due,
        modifieddate as last_update,
        CURRENT_TIMESTAMP() AS load_date
    from purchaseorderheader

)

select * from final