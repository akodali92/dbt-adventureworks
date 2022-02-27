WITH shipmethod as (

    SELECT * FROM {{ ref ('dim_shipmethod')}}
)

SELECT * FROM shipmethod