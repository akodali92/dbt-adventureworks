with department as (

    select * from {{ ref ('snapshot_department') }} 

), 

final as (

    select
        departmentid as department_id,
        name as department_name,
        groupname as group_name,
        modifieddate as last_update,
        dbt_valid_from AS load_date,
        dbt_valid_to AS load_end_date
    from department

)

select * from final