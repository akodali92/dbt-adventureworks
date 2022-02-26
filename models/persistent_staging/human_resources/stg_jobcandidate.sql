with jobcandidate as (

    select * from {{ ref ('snapshot_jobcandidate') }} 

), 

final as (

    select
        jobcandidateid as jobcandidate_id,
        BUSINESSENTITYID as employee_id,
        resume,
        modifieddate as last_update,
        dbt_valid_from AS load_date,
        dbt_valid_to AS load_end_date
    from jobcandidate

)

select * from final