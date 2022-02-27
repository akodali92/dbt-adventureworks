with final as (
    select * from {{ ref('date_details_source') }}
)
select * from final