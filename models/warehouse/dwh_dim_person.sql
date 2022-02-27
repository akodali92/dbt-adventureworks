WITH person as (

    SELECT * FROM {{ ref ('dim_person')}}
)

SELECT * FROM person