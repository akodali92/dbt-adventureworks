WITH purchaseorder as (

    SELECT * FROM {{ ref ('fact_purchaseorder')}}
)

SELECT * FROM purchaseorder