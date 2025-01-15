{{ config(
    snowflake_warehouse = get_warehouse('large')
   )
}}
select 1 as id