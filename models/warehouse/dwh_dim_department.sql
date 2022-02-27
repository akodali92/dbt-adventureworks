WITH department as (

    SELECT * FROM {{ ref ('dim_department')}}
)

SELECT * FROM department