with shift as (

    select * from {{ ref ('snapshot_shift') }} 

), 

final as (

    select
        shiftid as shift_id,
        NAME as business_key,
        NAME as shift_name,
        STARTTIME as start_time,
        ENDTIME as end_time,
        modifieddate as last_update,
        dbt_valid_from AS load_date
    from shift

)

select * from final