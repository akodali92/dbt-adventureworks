with addresstype as (

    select 
        address_type_id,
        name,
        row_guid,
        last_update,
        load_date
    from {{ ref ('stg_addresstype') }}
)

select * from addresstype