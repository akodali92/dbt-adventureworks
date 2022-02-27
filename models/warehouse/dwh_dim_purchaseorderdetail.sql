WITH purchaseorderdetail as (

    SELECT * FROM {{ ref ('dim_purchaseorderdetail')}}
)

SELECT * FROM purchaseorderdetail