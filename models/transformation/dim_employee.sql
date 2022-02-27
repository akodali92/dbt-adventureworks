WITH employee AS (

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
    FROM {{ ref ('stg_employee') }}
),

person AS (

    SELECT
        business_entity_id,
        title,
        first_name,
        last_name
    FROM {{ ref('stg_person')}}
),

final AS (

    SELECT 
        p.title,
        p.first_name,
        p.last_name,
        e.business_entity_id,
        e.national_id_number,
        e.business_key,
        e.login_id,
        e.org_node,
        e.org_level,
        e.job_title,
        e.birthdate,
        e.marital_status,
        e.gender,
        e.hiredate,
        e.salaried_flag,
        e.vacation_hours,
        e.sick_leave_hours,
        e.row_guid,
        e.last_update,
        e.load_date,
        e.load_end_date
    FROM employee e
    LEFT JOIN person p ON p.business_entity_id = e.business_entity_id
)

SELECT * FROM final