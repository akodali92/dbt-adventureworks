with purchaseorderdetail as (

    select * from {{ source ('aw_purchasing', 'purchaseorderdetail') }} 

), 

final as (

    select
        PRODUCTID as product_id,
        PURCHASEORDERID as purchase_order_id,
        PURCHASEORDERDETAILID as purchase_order_detail_id, 
        DUEDATE as due_date,
        ORDERQTY as order_qty,
        UNITPRICE as unit_price,
        LINETOTAL as line_total,
        RECEIVEDQTY as received_qty,
        REJECTEDQTY as rejected_qty,
        STOCKEDQTY as stocked_qty,
        modifieddate as last_update,
        CURRENT_TIMESTAMP() AS load_date
    from purchaseorderdetail

)

select * from final