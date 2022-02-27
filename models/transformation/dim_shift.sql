with shift as (

    select
        shift_id,
        business_key,
        shift_name,
        start_time,
        end_time,
        last_update,
        load_date
    from {{ ref ('stg_shift') }}
)

select * from shift