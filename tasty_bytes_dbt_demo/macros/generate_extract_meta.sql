-- macros/generate_merge.sql
{% macro generate_merge(source_sql_path, target_relation) %}
    {# Read the SQL file that defines the source data #}
    {% set source_query %}
        {{ read_file(source_sql_path) }}
    {% endset %}

    {# Define columns #}
    {% set pk_cols = ['A', 'B'] %}
    {% set update_cols = ['C', 'D', 'E'] %}
    {% set all_cols = pk_cols + update_cols %}

    {# Build ON clause for composite primary key #}
    {% set on_conditions = [] %}
    {% for col in pk_cols %}
        {% do on_conditions.append('t.' ~ col ~ ' = s.' ~ col) %}
    {% endfor %}
    {% set on_clause = on_conditions | join(' AND ') %}

    {# Build UPDATE SET clause #}
    {% set set_expressions = [] %}
    {% for col in update_cols %}
        {% do set_expressions.append('t.' ~ col ~ ' = s.' ~ col) %}
    {% endfor %}
    {% set set_clause = set_expressions | join(', ') %}

    {# Build INSERT column list and values #}
    {% set insert_cols = all_cols | join(', ') %}
    {% set insert_values = all_cols | map('string') | map('trim') %}
    {% set insert_values = all_cols | map('trim') %}
    {% set insert_values = all_cols | map('regex_replace', '^(.*)$', 's.\\1') | join(', ') %}

    MERGE INTO {{ target_relation }} AS t
    USING (
        {{ source_query }}
    ) AS s
    ON {{ on_clause }}

    WHEN MATCHED THEN
        UPDATE SET
            {{ set_clause }}

    WHEN NOT MATCHED THEN
        INSERT ({{ insert_cols }})
        VALUES ({{ insert_values }})

    WHEN NOT MATCHED BY SOURCE THEN
        DELETE
    ;
{% endmacro %}
