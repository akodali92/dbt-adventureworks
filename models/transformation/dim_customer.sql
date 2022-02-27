with customer as (

    select 
        customer_id,
        person_id,
        store_id,
        territory_id,
        account_number,
        row_guid,
        last_update,
        load_date
    from {{ ref ('stg_customer') }}
),

person as (

    SELECT 
        business_entity_id,
        title,
        first_name,
        last_name
    FROM {{ ref ('stg_person')}}
),

businessentityaddress as (

    SELECT 
        business_entity_id,
        address_id,
        address_type_id
    FROM {{ ref('stg_businessentityaddress')}} 
),

addresstype as (

    SELECT 
        address_type_id,
        name as address_type
    FROM {{ ref('stg_addresstype')}}
),

address as (

    SELECT 
        address_id,
        address_line_1,
        city,
        state_province_id,
        postal_code
    FROM {{ ref('stg_address')}}
),

salesterritory as (

    SELECT
        territory_id,
        territory_name
    FROM {{ ref('stg_salesterritory')}}
),

stateprovince as (

    SELECT 
        state_province_id,
        state_province,
        country_region_abbv
    FROM {{ ref('stg_stateprovince')}}
),

final as (

    SELECT
        p.business_entity_id,
        p.business_entity_id || '~' || a_t.address_type_id AS customer_address_type_sk,
        a.address_id,
        p.title,
        p.first_name,
        p.last_name,
        a_t.address_type,
        a.address_line_1,
        a.city,
        sp.state_province,
        a.postal_code,
        sp.country_region_abbv,
        st.territory_name
    FROM customer c
    LEFT JOIN businessentityaddress bea ON bea.business_entity_id = c.customer_id
    LEFT JOIN address a ON a.address_id = bea.address_id
    LEFT JOIN person p ON p.business_entity_id = c.customer_id
    LEFT JOIN addresstype a_t ON a_t.address_type_id = bea.address_type_id
    LEFT JOIN salesterritory st ON st.territory_id = c.territory_id
    LEFT JOIN stateprovince sp ON sp.state_province_id = a.state_province_id
)

select * from final