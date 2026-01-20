{% macro run_sql_file(path) %}
    {# 
        path: relative path from the project root,
        e.g. "sql/my_script.sql"
    #}

    {% set sql_text %}
        {{ read_file(path) }}
    {% endset %}

    {% do log("Executing SQL file: " ~ path, info=True) %}

    {% set results = run_query(sql_text) %}

    {{ return(results) }}
{% endmacro %}
