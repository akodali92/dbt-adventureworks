WITH date as (

    SELECT * FROM {{ ref ('dim_date')}}
)

SELECT * FROM date