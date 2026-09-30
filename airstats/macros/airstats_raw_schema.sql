{% macro airstats_raw_schema() %}

    {% if target.type == 'snowflake' %}
        raw
    {% else %}
        {{ target.schema }}_raw
    {% endif %}

{% endmacro %}
