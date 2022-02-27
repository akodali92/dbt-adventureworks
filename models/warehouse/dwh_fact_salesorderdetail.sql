WITH salesorderdetail as (

    SELECT * FROM {{ ref ('fact_salesorderdetail')}}
)

SELECT * FROM salesorderdetail