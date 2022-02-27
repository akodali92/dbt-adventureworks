WITH salesterritory as (

    SELECT * FROM {{ ref ('dim_salesterritory')}}
)

SELECT * FROM salesterritory