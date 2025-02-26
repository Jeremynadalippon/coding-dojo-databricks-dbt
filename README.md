### coding-dojo-databricks-dbt
This is a minimal repository to use for an internal coding dojo on Databricks. 

### Setup
Warning, as of now there are problems with python>3.11 so ensure you get either 3.11, 3.10 or 3.9.

Add a ```.env``` file as
```bash
export DBT_ACCESS_TOKEN=xxx
export DBT_SQL_WAREHOUSE="xxx"
export DBT_HOST="xxx.cloud.databricks.com"
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

### In order to deploy dbt jobs with [DAB](https://docs.databricks.com/aws/en/dev-tools/bundles/)
Make sure you have [Databrick CLI](https://docs.databricks.com/aws/en/dev-tools/cli/install) installed.
Add something similar to a ```~/.databrickscfg``` file.
```
[ippon]
host = https://dbc-4c604411-29e7.cloud.databricks.com
token = xxx
```

Validate your bundle :

```bash
databricks bundle validate --profile ippon -t prod
```

Then deploy it : 

```bash
databricks bundle deploy --profile ippon -t prod
```