WITH employee as (

    SELECT * FROM {{ ref ('dim_employee')}}
)

SELECT * FROM employee