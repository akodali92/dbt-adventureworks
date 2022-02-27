WITH address as (

    SELECT * FROM {{ ref ('dim_address')}}
)

SELECT * FROM address