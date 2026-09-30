{% macro generate_schema_name(custom_schema_name, node) -%}

    {% if target.type == 'snowflake' %}

        {{ custom_schema_name | trim }}

    {% else %}

        {% set default_schema = target.schema | trim %}

        {% if custom_schema_name is none %}
            {{ default_schema }}
        {% else %}
            {{ default_schema }}_{{ custom_schema_name | trim }}
        {% endif %}

    {% endif %}

{%- endmacro %}
