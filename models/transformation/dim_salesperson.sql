with salesperson as (

    select
        business_entity_id,
        territory_id,
        sales_quota,
        bonus,
        commission_pct,
        sales_ytd,
        sales_last_year,
        row_guid,
        last_update,
        load_date
    from {{ ref ('stg_salesperson') }}
)

select * from salesperson