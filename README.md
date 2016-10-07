# Phoenix Elm Starter

## Building

```
make build
```

## Running

```
make server
```

## RethinkDB

* How to Add: http://www.lambdacat.com/getting-started-using-rethinkdb-with-phoenix/
* Simple Exmample (see branch): http://www.lambdacat.com/getting-started-using-rethinkdb-with-phoenix/

RethingDB will use :binary_id so you will need to add this to Ecto models:

```
@primary_key {:id, :binary_id, autogenerate: true}
```

## Elm

Setting up:

* https://medium.com/@diamondgfx/writing-a-full-site-in-phoenix-and-elm-a100804c9499#.3zqis46mr
* https://medium.com/@diamondgfx/writing-a-full-site-in-phoenix-and-elm-a4622c5130f5#.7eknel5gj
