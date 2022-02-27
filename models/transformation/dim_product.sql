with product as (

    select
        ROW_NUM,
        product_id,
        name,
        product_number,
        make_flag,
        finished_goods_flag,
        color,
        safety_stock_level,
        reorder_point,
        standard_cost,
        list_price,
        size,
        size_unit_measure_code,
        weight_unit_measure_code,
        weight,
        days_to_manufacture,
        product_line,
        class,
        style,
        product_sub_category_id,
        product_model_id,
        sell_start_date,
        sell_end_date,
        discontinued_date,
        row_guid,
        last_update,
        load_date
    from {{ ref ('stg_product') }}
)

select * from product