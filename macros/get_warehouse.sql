{% macro get_warehouse(warehouse_size) %}

    {# check if the input warehouse size is valid #}
    {% set valid_warehouse_sizes = ['xsmall', 'small', 'large'] %}
    {% set warehouse_prefix = 'DBT_CLOUD' %}

    {% if warehouse_size not in valid_warehouse_sizes %}
        {{ exceptions.raise_compiler_error("Warehouse size not one of " ~ valid_warehouse_sizes) }}
    {% endif %}

    {# only production runs will use bigger warehouses #}
    {% if target.name.lower() in ['production', 'prod', 'production_ci'] %}
        {{ return('ANALYTICS') }}

    {% elif target.name.lower() in ['staging', 'staging_ci'] %}
        {{ return('TRANSFORMING') }}

    {% elif target.name.lower() in ['dev', 'default'] %}
        {{ return('WH_SMALL') }}

    {# else, return None which will use the default warehouse #}
    {% else %}
        {{ return(None) }}

    {% endif %}

{% endmacro %}