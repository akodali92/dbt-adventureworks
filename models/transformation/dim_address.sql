WITH address AS (

    SELECT 
        address_id,
        address_line_1,
        address_line_2,
        city,
        state_province_id,
        postal_code,
        spatial_location,
        row_guid,
        last_update,
        load_date
    FROM {{ ref ('stg_address') }} 

),

businessentityaddress as (

    SELECT 
        business_entity_id,
        address_id,
        address_type_id
    FROM {{ ref ('stg_businessentityaddress') }}
),

addresstype as (

    SELECT  
        address_type_id,
        name
    FROM {{ ref ('stg_addresstype')}}
),

stateprovince as (

    SELECT 
        state_province_id,
        state_province_abbv,
        country_region_abbv,
        state_province,
        territory_id,
        row_guid,
        last_update,
        load_date
    FROM {{ ref ('stg_stateprovince')}}
),

together AS (

    SELECT
        b.business_entity_id,
        b.address_type_id,
        a_t.name as address_type,
        a.address_id,
        a.address_line_1,
        a.address_line_2,
        a.city,
        sp.state_province,
        sp.state_province_abbv,
        a.postal_code,
        sp.country_region_abbv,
        a.spatial_location,
        a.row_guid,
        a.last_update,
        a.load_date
    FROM address a
    LEFT JOIN businessentityaddress b ON b.address_id = a.address_id
    LEFT JOIN addresstype a_t ON a_t.address_type_id = b.address_type_id
    LEFT JOIN stateprovince sp ON sp.state_province_id = a.state_province_id

)

select * from together