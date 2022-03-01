{% snapshot snapshot_employeedepartmenthistory %}

{{
    config(
      target_schema='snapshots',
      unique_key='businessentityid||departmentid',

      strategy='timestamp',
      updated_at='modifieddate'
    )
}}

select *  from {{ source('aw_humanresources', 'employeedepartmenthistory') }}

{% endsnapshot %}