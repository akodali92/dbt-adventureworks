{% snapshot snapshot_employeepayhistory %}

{{
    config(
      target_schema='snapshots',
      unique_key='businessentityid',

      strategy='timestamp',
      updated_at='modifieddate'
    )
}}

select * from {{ source('aw_humanresources', 'employeepayhistory') }}

{% endsnapshot %}