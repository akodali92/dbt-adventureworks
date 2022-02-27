WITH employeedepartmenthistory as (

    SELECT * FROM {{ ref ('fact_employeedepartmenthistory')}}
)

SELECT * FROM employeedepartmenthistory