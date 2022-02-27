WITH salesperson as (

    SELECT * FROM {{ ref ('dim_salesperson')}}
)

SELECT * FROM salesperson