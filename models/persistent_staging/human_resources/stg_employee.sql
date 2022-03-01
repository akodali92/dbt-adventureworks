with employee as (

      select * from {{ ref ('snapshot_employee') }} 

), 

final as (

    select
        BUSINESSENTITYID AS business_entity_id,
        NATIONALIDNUMBER AS national_id_number,
        LOGINID AS business_key,
        LOGINID AS login_id,
        ORGANIZATIONNODE AS org_node,
        ORGANIZATIONLEVEL AS org_level,
        JOBTITLE AS job_title,
        BIRTHDATE as birthdate,
        MARITALSTATUS AS marital_status,
        GENDER as gender,
        HIREDATE as hiredate,
        SALARIEDFLAG AS salaried_flag,
        VACATIONHOURS AS vacation_hours,
        SICKLEAVEHOURS AS sick_leave_hours,
        ROWGUID as row_guid,
        modifieddate as last_update,
        dbt_valid_from AS load_date,
        dbt_valid_to AS load_end_date
    from employee
    where business_entity_id is not null

)

select * from final