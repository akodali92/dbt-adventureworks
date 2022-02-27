WITH product as (

    SELECT * FROM {{ ref ('dim_product')}}
)

SELECT * FROM product