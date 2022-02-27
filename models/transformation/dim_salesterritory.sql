with salesterritory as (

    select
        territory_id,
        territory_name,
        country_region_code,
        territory_group,
        sales_ytd,
        sales_last_year,
        row_guid,
        last_update,
        load_date
    from {{ ref ('stg_salesterritory') }}
)

select * from salesterritory