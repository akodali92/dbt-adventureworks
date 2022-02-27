WITH customer as (

    SELECT * FROM {{ ref ('dim_customer')}}
)

SELECT * FROM customer