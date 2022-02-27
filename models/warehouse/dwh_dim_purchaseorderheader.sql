WITH purchaseorderheader as (

    SELECT * FROM {{ ref ('dim_purchaseorderheader')}}
)

SELECT * FROM purchaseorderheader