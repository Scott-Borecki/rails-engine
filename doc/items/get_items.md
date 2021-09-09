# Get All Items

```
GET /items
```

## Parameters

Name       | Type    | In    | Description
-----------|---------|-------|--------------
`per_page` | integer | query | Results per page<br>Default: `20`
`page`     | integer | query | Page number of the results to fetch<br>Default: `1`


## Code Sample

From your local development web server:

```
http://localhost:3000/api/v1/items
```


## Default Response

```
Status: 200 OK
```

```
{
  "data": [
    {
      "id": "1",
      "type": "item",
      "attributes": {
        "name": "Super Widget",
        "description": "A most excellent widget of the finest crafting",
        "unit_price": 109.99
        }
    },
    {
      "id": "2",
      "type": "item",
      "attributes": {
        "name": "Super Widget",
        "description": "A most excellent widget of the finest crafting",
        "unit_price": 109.99
        }
    },
    {
      "id": "3",
      "type": "item",
      "attributes": {
        "name": "Super Widget",
        "description": "A most excellent widget of the finest crafting",
        "unit_price": 109.99
        }
    }
  ]
}
```
