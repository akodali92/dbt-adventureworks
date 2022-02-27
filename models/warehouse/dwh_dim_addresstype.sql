WITH addresstype as (

    SELECT * FROM {{ ref ('dim_addresstype')}}
)

SELECT * FROM addresstype