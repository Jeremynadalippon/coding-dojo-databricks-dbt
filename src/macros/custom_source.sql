{% macro custom_source(source_name, table_name) %}
    {% set source_node = get_graph_object(object_name=table_name) %}

    {% if is_external_source(source_node) %}
        {% set prefix = get_external_type(source_node) %}
        `{{prefix}}`.`{{ get_external_location(source_node) }}`
    {% else %}
        {{ source(source_name, table_name) }}
    {% endif %}

{% endmacro %}

{% macro get_external_type(source_node) %}
    {% if source_node["external"].get("table_format", none) == "delta" or source_node["external"].get("using", none) == "delta" %}
        {{ return("delta") }}
    {% elif source_node["external"].get("file_format", none) == "parquet" or source_node["external"].get("using") == "parquet" %}
        {{ return("parquet") }}
    {% else %}
        {{ log("get_external_type is not implemented for source node " ~ source_node, error=true) }}
    {% endif %}
{% endmacro %}

{% macro get_external_location(source_node) %}
    {% if "external" in source_node and "location" in source_node["external"] %}
        {{ return(source_node["external"]["location"]) }}
    {% else %}
        {{ return(none) }}
    {% endif %}
{% endmacro %}

{% macro is_external_source(source_node) %}
    {% if source_node is none %}
        {{ return(false) }}
    {% endif %}

    {% if "external" in source_node and "location" in source_node["external"] %}
        {{ return(true) }}
    {% else %}
        {{ return(false) }}
    {% endif %}
{% endmacro %}

{% macro get_graph_object(object_name, object_type="sources") %}
    {% if object_type not in graph.keys() %}
        {{ log("object type "~ object_type ~" not in graph keys", info=false) }}
        {{ return(none) }}
    {% endif %}

    {% set project_name = context['project_name'] %}

    {% if object_type == "sources" %}
        {% set object_key = "source."~project_name~".sources."~object_name %}
    {% elif object_type == "nodes" %}
        {% set object_key = "source."~project_name~object_name %}
    {% else %}
        {{ log("get_graph_object is not implemented for object type "~object_type, error=true) }}
    {% endif %}

    {{ return(graph[object_type].get(object_key, none)) }}

{% endmacro %}
