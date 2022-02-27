with shipmethod as (

    select
        ship_method_id,
        name,
        ship_base,
        ship_rate,
        row_guid,
        last_update,
        load_date
    from {{ ref ('stg_shipmethod') }}
)

select * from shipmethod