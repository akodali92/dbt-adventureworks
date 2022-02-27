WITH shift as (

    SELECT * FROM {{ ref ('dim_shift')}}
)

SELECT * FROM shift