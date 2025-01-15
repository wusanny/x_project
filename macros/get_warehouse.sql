{% macro get_warehouse(warehouse_size) %}

{# check if the input warehouse size is valid #}
    {% set valid_warehouse_sizes = ['xsmall', 'small', 'large'] %}

    {% if target.name.lower() in ['production', 'prod', 'production_ci'] %}
        {{ return('ANALYTICS') }}

    {% elif target.name.lower() in ['staging', 'staging_ci'] %}
        {{ return('TRANSFORMING') }}

    {# else, return None which will use the default warehouse #}
    {% else %}
        {{ return(None) }}

    {% endif %}

{% endmacro %}