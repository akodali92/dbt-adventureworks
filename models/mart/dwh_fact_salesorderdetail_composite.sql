with salesorderdetail as (

  select * from {{ ref( 'dwh_fact_salesorderdetail') }}
),

dwh_dim_date as (

  select * from {{ ref('dwh_dim_date') }}
),

dwh_dim_address as (
  
  select * from {{ ref('dwh_dim_address') }}
),

dwh_dim_addresstype as (

  select * from {{ ref('dwh_dim_addresstype') }}
),

dwh_dim_customer as (

  select * from {{ ref('dwh_dim_customer') }} 
),

dwh_dim_salesperson as (

  select * from {{ ref('dwh_dim_salesperson') }}
),

dwh_dim_shipmethod as (

  select * from {{ ref('dwh_dim_shipmethod') }}
),

dwh_dim_product as (
  
  select * from {{ ref('dwh_dim_product') }}
),

dwh_dim_salesterritory as (

  select * from {{ ref('dwh_dim_salesterritory') }}
),

dwh_dim_person as (

  select * from {{ ref('dwh_dim_person') }}
),

dwh_dim_vendor as (

  select * from {{ ref('dwh_dim_vendor') }}
),

final as (

  select
    sod.*,
    {{ dbt_utils.star(from=ref('dwh_dim_address'), relation_alias='a', except=["business_entity_id"]) }},
    {{ dbt_utils.star(from=ref('dwh_dim_addresstype'), relation_alias='at', except=["business_entity_id"]) }},
    {{ dbt_utils.star(from=ref('dwh_dim_customer'), relation_alias='c', except=["business_entity_id"]) }},
    {{ dbt_utils.star(from=ref('dwh_dim_date'), relation_alias='d') }},
    {{ dbt_utils.star(from=ref('dwh_dim_person'), relation_alias='p', except=["business_entity_id"]) }},
    {{ dbt_utils.star(from=ref('dwh_dim_product'), relation_alias='pr', except=["product_id", "weight", "list_price", "standard_cost"]) }},
    {{ dbt_utils.star(from=ref('dwh_dim_salesperson'), relation_alias='sp', except=["business_entity_id", "territory_id", "sales_quota", "bonus", "sp_sales_last_year", "sp_sales_ytd", "commission_pct"]) }},
    {{ dbt_utils.star(from=ref('dwh_dim_salesterritory'), relation_alias='st', except=["territory_id"]) }},
    {{ dbt_utils.star(from=ref('dwh_dim_shipmethod'), relation_alias='sm', except=["ship_method_id"]) }},
    {{ dbt_utils.star(from=ref('dwh_dim_vendor'), relation_alias='v', except=["business_entity_id", "account_number"]) }},
    d.date_day as order_date_day,
    d.last_day_of_week as order_last_day_of_week
    
  from salesorderdetail sod
  
  left join dwh_dim_address a 
    on a.business_entity_id = sod.business_entity_id
  left join dwh_dim_addresstype at
    on a.address_type_id = at.address_type_id
  left join dwh_dim_customer c
    on c.business_entity_id = sod.business_entity_id
  left join dwh_dim_vendor v
    on c.business_entity_id = v.business_entity_id
  left join dwh_dim_date d
    on d.date_day = sod.order_date
  left join dwh_dim_product pr
    on pr.product_id = sod.product_id
  left join dwh_dim_person p
    on p.business_entity_id = sod.business_entity_id
  left join dwh_dim_salesperson sp
    on sp.business_entity_id = sod.business_entity_id
  left join dwh_dim_salesterritory st
    on st.territory_id = sod.territory_id
  left join dwh_dim_shipmethod sm
    on sm.ship_method_id = sod.ship_method_id
)

select * from final
    