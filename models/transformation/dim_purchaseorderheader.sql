with purchaseorderheader as (

    select
        purchase_order_id,
        revision_number,
        status_id,
        employee_id,
        vendor_id,
        ship_method_id,
        order_date,
        ship_date,
        sub_total,
        tax_amt,
        freight,
        total_due,
        last_update,
        load_date,
        CASE WHEN status_id = 1 THEN 'Pending'
        WHEN status_id = 2 THEN 'Approved'
        WHEN status_id = 3 THEN 'Rejected'
        ELSE 'Complete' END AS order_status
    from {{ ref ('stg_purchaseorderheader') }} 
)

select * from purchaseorderheader