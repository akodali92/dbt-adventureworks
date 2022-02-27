WITH purchaseorderdetail AS (

    SELECT * FROM {{ ref('stg_purchaseorderdetail')}}

),

purchaseorderheader AS (

    SELECT * FROM {{ ref('stg_purchaseorderheader')}}

),

shipmethod AS (

    SELECT * FROM {{ ref('stg_shipmethod')}}

),

final AS (

    SELECT 
        pd.purchase_order_id || '~' || pd.purchase_order_detail_id AS purchase_order_sk,
        pd.purchase_order_id,
        pd.purchase_order_detail_id,
        pd.due_date,
        pd.order_qty,
        pd.product_id,
        pd.unit_price,
        pd.line_total,
        pd.received_qty,
        pd.rejected_qty,
        pd.stocked_qty,
        ph.revision_number,
        ph.status_id,
        ph.employee_id,
        ph.vendor_id,
        ph.ship_method_id,
        ph.ship_date,
        ph.sub_total,
        ph.tax_amt,
        ph.freight,
        ph.total_due,
        sm.ship_base,
        sm.ship_rate
    FROM purchaseorderdetail pd 
    LEFT JOIN purchaseorderheader ph ON ph.purchase_order_id = pd.purchase_order_id
    LEFT JOIN shipmethod sm ON sm.ship_method_id = ph.ship_method_id

)

SELECT * FROM FINAL