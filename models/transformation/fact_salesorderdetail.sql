WITH salesorderdetail AS (

	SELECT
	sales_order_id,
        sales_order_detail_id,
        carrier_tracking_number,
        order_qty,
        product_id,
        special_offer_id,
        unit_price,
        unit_price_discount,
        line_total,
        row_guid,
        last_update,
        load_date
	FROM {{ ref ('stg_salesorderdetail')}}
),

salesorderheader AS (

	SELECT
	sales_order_id,
        revision_number,
        order_date,
        due_date,
        ship_date,
        status,
        online_order_flag,
        sales_order_number,
        purchase_order_number,
        account_number,
        customer_id,
        sales_person_id,
        territory_id,
        bill_to_address_id,
        ship_to_address_id,
        ship_method_id,
        credit_card_id,
        credit_card_approval_code,
        currency_rate_id,
        sub_total,
        tax_amt,
        freight,
        total_due,
        comment,
        row_guid,
        last_update,
        load_date
	FROM {{ ref ('stg_salesorderheader')}}
),

customer AS (
	SELECT
		customer_id
	from {{ ref('stg_customer')}}
),

product AS (

	SELECT
		product_id,
		standard_cost,
		list_price,
		weight
	from {{ ref('stg_product') }}
),

salesterritory AS (

	SELECT	
		territory_id,
		sales_ytd,
		sales_last_year
	from {{ ref('stg_salesterritory') }}
),

salesperson AS (

	SELECT
		business_entity_id,
		sales_quota,
		bonus,
		commission_pct,
		sales_ytd,
		sales_last_year
	from {{ ref('stg_salesperson') }}
),

shipmethod AS (

	SELECT
		ship_method_id,
		ship_base,
		ship_rate
	from {{ ref('stg_shipmethod')}}
),

final AS (

	SELECT
		{{ dbt_utils.surrogate_key(['sd.sales_order_id', 'sd.sales_order_detail_id']) }} as sales_order_detail_sk,
		IFNULL(sh.customer_id, -1) as business_entity_id,
		sd.sales_order_detail_id,
		sh.sales_order_id,
		sd.product_id,
		sd.special_offer_id,
		sh.online_order_flag,
		sh.account_number,
		sh.customer_id,
		IFNULL(sh.sales_person_id, -1) AS sales_person_id,
		sh.territory_id,
		sh.bill_to_address_id,
		sh.ship_to_address_id,
		sh.ship_method_id,
		to_timestamp_ntz(sd.last_update) AS sales_order_detail_last_update,
		to_timestamp_ntz(sh.order_date) AS order_date,
		to_timestamp_ntz(sh.due_date) AS due_date,
		to_timestamp_ntz(sh.ship_date) AS ship_date,
		to_timestamp_ntz(sh.last_update) AS sales_order_header_last_update,
		sd.order_qty,
		sd.unit_price,
		sd.unit_price_discount,
		sd.line_total,
		sh.sub_total,
		sh.tax_amt,
		sh.freight,
		sh.total_due,
		p.standard_cost AS prod_standard_cost,
		p.list_price AS prod_list_price,
		p.weight AS prod_weight,
		st.sales_ytd AS st_sales_ytd,
		st.sales_last_year AS st_sales_last_year,
		sp.sales_quota AS sp_sales_quota,
		sp.bonus AS sp_bonus,
		sp.commission_pct AS sp_commission_pct,
		sp.sales_ytd AS sp_sales_ytd,
		sp.sales_last_year AS sp_sales_last_year,
		sm.ship_base as sm_ship_base,
		sm.ship_rate as sm_ship_rate,
		CURRENT_TIMESTAMP() AS last_update
	FROM salesorderdetail sd
	LEFT JOIN salesorderheader sh ON sd.sales_order_id = sh.sales_order_id
	LEFT JOIN product p ON p.product_id = sd.product_id
	LEFT JOIN salesterritory st ON st.territory_id = sh.territory_id
	LEFT JOIN salesperson sp ON sp.business_entity_id = sh.sales_person_id
	LEFT JOIN shipmethod sm ON sm.ship_method_id = sh.ship_method_id
	LEFT JOIN customer c ON sh.customer_id = c.customer_id

)

select * FROM final