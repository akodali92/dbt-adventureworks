WITH department AS (

    SELECT 
        department_id,
        department_name,
        group_name,
        last_update,
        load_date,
        load_end_date
    FROM {{ ref ('stg_department') }}
)

SELECT * FROM department