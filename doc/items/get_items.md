# Get All Items

Returns a list of all the Items and their attributes.

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


## Response

```
Status: 200 OK
```

```
{
  "data": [
    {
      "id": "4",
      "type": "item",
      "attributes": {
        "name": "Item Nemo Facere",
        "description": "Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.",
        "unit_price": 42.91,
        "merchant_id": 1
      }
    },
    {
      "id": "5",
      "type": "item",
      "attributes": {
        "name": "Item Expedita Aliquam",
        "description": "Voluptate aut labore qui illum tempore eius. Corrupti cum et rerum. Enim illum labore voluptatem dicta consequatur. Consequatur sunt consequuntur ut officiis.",
        "unit_price": 687.23,
        "merchant_id": 1
      }
    },
    {
      "id": "6",
      "type": "item",
      "attributes": {
        "name": "Item Provident At",
        "description": "Numquam officiis reprehenderit eum ratione neque tenetur. Officia aut repudiandae eum at ipsum doloribus. Iure minus itaque similique. Ratione dicta alias asperiores minima ducimus nesciunt at.",
        "unit_price": 159.25,
        "merchant_id": 1
      }
    }
  ]
}
```
