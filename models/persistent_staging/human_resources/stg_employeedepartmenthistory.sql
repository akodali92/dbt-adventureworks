with employeedepartmenthistory as (

    select * from {{ ref ('snapshot_employeedepartmenthistory') }} 

), 

final as (

    select
        BUSINESSENTITYID || '~' || DEPARTMENTID as employee_department_history_sk,
        BUSINESSENTITYID as business_entity_id,
        DEPARTMENTID as department_id,
        SHIFTID AS shift_id,
        STARTDATE AS start_date,
        ENDDATE AS end_date,
        modifieddate as last_update,
        dbt_valid_from AS load_date,
        dbt_valid_to AS load_end_date
    from employeedepartmenthistory
    where 
            business_entity_id is not null
        and department_id is not null

)

select * from final