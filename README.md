# Phoenix Elm Starter

## RethinkDB

* How to Add: http://www.lambdacat.com/getting-started-using-rethinkdb-with-phoenix/
* Simple Exmample (see branch): http://www.lambdacat.com/getting-started-using-rethinkdb-with-phoenix/

RethingDB will use :binary_id so you will need to add this to Ecto models:

```
@primary_key {:id, :binary_id, autogenerate: true}
```

