# Get One Item

Returns an Item and its attributes.

```
GET /items/{id}
```


## Parameters

Name       | Type    | In    | Description
-----------|---------|-------|--------------
`id`       | integer | path  |


## Code Sample

From your local development web server:

```
http://localhost:3000/api/v1/items/179
```


## Response

```
Status: 200 OK
```

```
{
  "data": {
    "id": "179",
    "type": "item",
    "attributes": {
      "name": "Item Qui Veritatis",
      "description": "Totam labore quia harum dicta eum consequatur qui. Corporis inventore consequatur. Illum facilis tempora nihil placeat rerum sint est. Placeat ut aut. Eligendi perspiciatis unde eum sapiente velit.",
      "unit_price": 906.17,
      "merchant_id": 9
    }
  }
}
```

## Resource Not Found

```
Status: 404 Not Found
```
