### coding-dojo-databricks-dbt
This is a minimal repository to use for an internal coding dojo on Databricks. 

### Setup
Warning, as of now there are problems with python>3.11 so ensure you get either 3.11, 3.10 or 3.9.

Add a ```.env``` file as
```bash
export DBT_DBX_TOKEN=xxx
export DBT_SQL_WAREHOUSE="xxx"
export DBT_DBX_HOST="xxx.cloud.databricks.com"
export DBT_CATALOG=xxx
export DBT_SCHEMA=xxx
```

Run ```make install``` and you should be ready to go. Try out the following command and see whats going on either in the _logs/_ or the _target_ folder : 
```
dbt debug
dbt run
dbt test
dbt build
dbt docs generate && dbt docs serve
...
```

