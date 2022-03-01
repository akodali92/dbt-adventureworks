with product as (

    select * from {{ source ('aw_production', 'product') }} 

), 

final as (

    select 
        ROW_NUMBER() OVER (PARTITION BY PRODUCTID ORDER BY MODIFIEDDATE DESC) AS ROW_NUM,
        PRODUCTID as product_id,
        NAME,
        PRODUCTNUMBER as product_number,
        MAKEFLAG as make_flag,
        FINISHEDGOODSFLAG as finished_goods_flag,
        COLOR as color,
        SAFETYSTOCKLEVEL as safety_stock_level,
        REORDERPOINT as reorder_point,
        STANDARDCOST as standard_cost,
        LISTPRICE as list_price,
        SIZE as size,
        SIZEUNITMEASURECODE as size_unit_measure_code,
        WEIGHTUNITMEASURECODE as weight_unit_measure_code,
        WEIGHT as weight,
        DAYSTOMANUFACTURE as days_to_manufacture,
        PRODUCTLINE as product_line,
        CLASS as class,
        STYLE as style,
        PRODUCTSUBCATEGORYID as product_sub_category_id,
        PRODUCTMODELID as product_model_id,
        to_timestamp_ntz(SELLSTARTDATE) as sell_start_date,
        to_timestamp_ntz(SELLENDDATE) as sell_end_date,
        to_timestamp_ntz(DISCONTINUEDDATE) as discontinued_date,
        ROWGUID as row_guid,
        modifieddate as last_update,
        CURRENT_TIMESTAMP() AS load_date
    from product
    where product_id is not null

)

select * from final
WHERE ROW_NUM = 1