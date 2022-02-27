WITH vendor as (

    SELECT * FROM {{ ref ('dim_vendor')}}
)

SELECT * FROM vendor