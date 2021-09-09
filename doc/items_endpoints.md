# Items Endpoints

HTTP Verb | Endpoint                   | Description                | Link
----------|----------------------------|----------------------------|-------------------------
GET       | `/items`                   | Get the list of items.     | [Link](#get-all-items)
GET       | `/items/{item_id}`         | Get a single item.         | [Link](#get-one-item)
POST      | `/items/`                  | Create an item.            | [Link](#create-an-item)
PATCH     | `/items/{item_id}`         | Update an item.            | [Link](#update-an-item)
DELETE    | `/items/{item_id}`         | Delete an item.            | [Link](#delete-an-item)

## Get All Items

Returns a list of all the Items and their attributes.

```
GET /items
```

### Parameters

Name       | Type    | In    | Description
-----------|---------|-------|----------------------------------------------------
`per_page` | integer | query | Results per page<br>Default: `20`
`page`     | integer | query | Page number of the results to fetch<br>Default: `1`


### Example Request

```
GET http://localhost:3000/api/v1/items
```


### Example Response

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

## Get One Item

Returns an Item and its attributes.

```
GET /items/{item_id}
```


### Parameters

Name       | Type    | In    | Description
-----------|---------|-------|--------------
`item_id`  | integer | path  | The ID of the item.


### Example Request

```
GET http://localhost:3000/api/v1/items/179
```


### Example Response

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

### Resource Not Found

```
Status: 404 Not Found
```

## Create an Item

Creates a new Item with the given attributes.

```
POST /items
```


### Parameters

Name       | Type    | In    | Description
-----------|---------|-------|--------------


### Request Body

Attribute Name | Type | Description
---------------|------|-------------
`name` | string | The item's name.
`description` | string | The item's description.
`unit_price` | float | The item's unit price.
`merchant_id` | integer | The ID of the merchant associated with the item.


### Example Request

```
POST http://localhost:3000/api/v1/items
```

With the following example request body:

```
{
  "name": "Shiny Itemy Item",
  "description": "It does a lot of things real good.",
  "unit_price": 123.45,
  "merchant_id": 43
}
```


### Example Response

```
Status: 201 Created
```

```
{
  "data": {
    "id": "2546",
    "type": "item",
    "attributes": {
      "name": "Shiny Itemy Item",
      "description": "It does a lot of things real good.",
      "unit_price": 123.45,
      "merchant_id": 43
    }
  }
}
```


## Update an Item

Updates an Item with the given attributes.

```
PATCH /items/{id}
```


### Parameters

Name       | Type    | In    | Description
-----------|---------|-------|--------------
`id`       | integer | path  |


### Request Body

Attribute Name | Type | Description
---------------|------|-------------
`name` | string | The item's name.
`description` | string | The item's description.
`unit_price` | float | The item's unit price.
`merchant_id` | integer | The ID of the merchant associated with the item.


### Example Request

```
PATCH http://localhost:3000/api/v1/items/1
```

With the following example request body:

```
{
  "name": "Shiny Itemy Item",
  "description": "It does a lot of things real good.",
  "unit_price": 123.45,
  "merchant_id": 43
}
```


### Example Response

```
Status: 200 OK
```

```
{
  "data": {
    "id": "179",
    "type": "item",
    "attributes": {
      "name": "Shiny Itemy Item, New and Improved",
      "description": "It does a lot of things even more good than before!",
      "unit_price": 65.23,
      "merchant_id": 56
    }
  }
}
```


### Resource Not Found

```
Status: 404 Not Found
```


## Delete an Item

Destroys an Item.

```
DELETE /items/{item_id}
```


### Parameters

Name       | Type    | In    | Description
-----------|---------|-------|--------------
`item_id`  | integer | path  | The ID of the item.


### Example Request

```
DELETE http://localhost:3000/api/v1/items/179
```

### Example Response

```
Status: 200 OK
```

```
{
  "data": {
    "id": "179",
    "type": "item",
    "attributes": {
      "name": "Shiny Itemy Item, New and Improved",
      "description": "It does a lot of things even more good than before!",
      "unit_price": 65.23,
      "merchant_id": 56
    }
  }
}
```


### Resource Not Found

```
Status: 404 Not Found
```
