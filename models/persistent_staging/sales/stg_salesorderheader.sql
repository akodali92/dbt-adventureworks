with salesorderheader as (

    select * from {{ source ('aw_sales', 'salesorderheader') }} 

), 

final as (

    select
        SALESORDERID as sales_order_id,
        REVISIONNUMBER as revision_number,
        to_timestamp_ntz(ORDERDATE) as order_date,
        to_timestamp_ntz(DUEDATE) as due_date,
        to_timestamp_ntz(SHIPDATE) as ship_date,
        STATUS as status,
        ONLINEORDERFLAG as online_order_flag,
        SALESORDERNUMBER as sales_order_number,
        PURCHASEORDERNUMBER as purchase_order_number,
        ACCOUNTNUMBER as account_number,
        CUSTOMERID as customer_id,
        SALESPERSONID as sales_person_id,
        TERRITORYID as territory_id,
        BILLTOADDRESSID as bill_to_address_id,
        SHIPTOADDRESSID as ship_to_address_id,
        SHIPMETHODID as ship_method_id,
        CREDITCARDID as credit_card_id,
        CREDITCARDAPPROVALCODE as credit_card_approval_code,
        CURRENCYRATEID as currency_rate_id,
        SUBTOTAL as sub_total,
        TAXAMT as tax_amt,
        FREIGHT as freight,
        TOTALDUE as total_due,
        COMMENT as comment,
        ROWGUID as row_guid,
        modifieddate as last_update,
        CURRENT_TIMESTAMP() AS load_date
    from salesorderheader

)

select * from final