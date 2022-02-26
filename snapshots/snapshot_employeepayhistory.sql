{% snapshot snapshot_employeepayhistory %}

{{
    config(
      target_schema='snapshots',
      unique_key='businessentityid||"-"||ratechangedate',

      strategy='timestamp',
      updated_at='modifieddate'
    )
}}

select * from {{ source('aw_humanresources', 'employeepayhistory') }}

{% endsnapshot %}