with employeedepartmenthistory as (

select * from {{ ref('dwh_fact_employeedepartmenthistory')}}

)
,

dwh_dim_date as (

	select * from {{ ref('dwh_dim_date')}}
)
,

dwh_dim_employee as (

	select * from {{ ref('dwh_dim_employee')}}
)
,

dwh_dim_person as (

	select * from {{ ref('dwh_dim_person')}}
)
,

dwh_dim_department as (

	select * from {{ ref('dwh_dim_department')}}
)
,


dwh_dim_address as (

	select * from {{ ref('dwh_dim_address')}}
)
,


dwh_dim_shift as (

	select * from {{ ref('dwh_dim_shift')}}
)
,

final as (
	
	select
		edh.*,
		{{ dbt_utils.star(from=ref('dwh_dim_address'), relation_alias='a', except=["business_entity_id", "row_guid"]) }},
		{{ dbt_utils.star(from=ref('dwh_dim_employee'), relation_alias='e', except=["business_entity_id", "last_update", "load_date", "row_guid", "national_id_number", "org_node", "org_level", "vacation_hours", "sick_leave_hours"]) }},
		{{ dbt_utils.star(from=ref('dwh_dim_shift'), relation_alias='s', except=["shift_id", "last_update", "load_date", "start_time", "end_time", "business_key"]) }},
		{{ dbt_utils.star(from=ref('dwh_dim_department'), relation_alias='d', except=["business_entity_id", "last_update", "load_date", "load_end_date", "department_id"]) }},
		{{ dbt_utils.star(from=ref('dwh_dim_person'), relation_alias='p', except=["business_entity_id", "last_update", "load_date", "row_guid", "title", "first_name", "last_name"]) }}
	from employeedepartmenthistory edh
	 
	left join dwh_dim_address a
		on a.business_entity_id = edh.business_entity_id
	left join dwh_dim_employee e
		on e.business_entity_id = edh.business_entity_id
	left join dwh_dim_shift s 
		on s.shift_id = edh.shift_id
	left join dwh_dim_department d
		on d.department_id = edh.department_id
	left join dwh_dim_person p
		on p.business_entity_id = edh.business_entity_id
	
)

select * from final limit 10