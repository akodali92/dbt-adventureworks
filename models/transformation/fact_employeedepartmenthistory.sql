WITH employeedepartmenthistory AS (

    SELECT
        employee_department_history_sk,
        business_entity_id,
        department_id,
        shift_id,
        start_date,
        end_date,
        last_update,
        load_date,
        load_end_date
    FROM {{ ref('stg_employeedepartmenthistory')}}
),

employee AS (

    SELECT
        business_entity_id,
        national_id_number,
        business_key,
        login_id,
        org_node,
        org_level,
        job_title,
        birthdate,
        marital_status,
        gender,
        hiredate,
        salaried_flag,
        vacation_hours,
        sick_leave_hours,
        row_guid,
        last_update,
        load_date,
        load_end_date
    FROM {{ ref ('stg_employee')}}
),

shift AS (

    SELECT
        shift_id,
        business_key,
        shift_name,
        start_time,
        end_time,
        last_update,
        load_date
    FROM {{ ref ('stg_shift')}}
),

final AS (

    SELECT
        {{ dbt_utils.surrogate_key(['ed.business_entity_id', 'ed.department_id']) }} as employee_department_sk,
        ed.business_entity_id,
        e.national_id_number,
        ed.department_id,
        ed.shift_id,
        ed.start_date,
        ed.end_date,
        e.org_node,
        e.org_level,
        e.vacation_hours,
        e.sick_leave_hours,
        s.start_time as shift_start_time,
        s.end_time as shift_end_time
    FROM employeedepartmenthistory ed
    LEFT JOIN employee e ON e.business_entity_id = ed.business_entity_id
    LEFT JOIN shift s ON s.shift_id = ed.shift_id
)

SELECT * FROM final