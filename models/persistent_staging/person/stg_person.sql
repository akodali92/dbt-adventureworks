with person as (

    select * from {{ source ('aw_person', 'person') }} 

), 

final as (

    select
        BUSINESSENTITYID as business_entity_id,
        PERSONTYPE as person_type,
        NAMESTYLE as name_style,
        TITLE,
        FIRSTNAME as first_name,
        MIDDLENAME as middle_name,
        LASTNAME as last_name,
        SUFFIX,
        EMAILPROMOTION as email_promotion,
        ADDITIONALCONTACTINFO as additional_contact_info,
        DEMOGRAPHICS,
        ROWGUID as row_guid,
        modifieddate as last_update,
        CURRENT_TIMESTAMP() AS load_date
    from person
    where business_entity_id is not null

)

select * from final