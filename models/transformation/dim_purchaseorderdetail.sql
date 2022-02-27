with purchaseorderdetail as (

    select
        product_id,
        purchase_order_id,
        purchase_order_detail_id, 
        due_date,
        order_qty,
        unit_price,
        line_total,
        received_qty,
        rejected_qty,
        stocked_qty,
        last_update,
        load_date
    from {{ ref ('stg_purchaseorderdetail') }}
)

select * from purchaseorderdetail