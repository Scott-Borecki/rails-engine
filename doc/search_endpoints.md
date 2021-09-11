# Search Endpoints

HTTP Verb | Endpoint              | Description                              | Link
----------|-----------------------|------------------------------------------|---------------------------
GET       | `/items/find_all`     | Get the list of items matching the search.  The results are sorted by case-sensitive alphabetical order. | [Link](#find-all-items)
GET       | `/items/find`         | Get the first item matching the search, by case-sensitive alphabetical order. | [Link](#find-one-item)
GET       | `/merchants/find_all` | Get the list of merchants matching the search.  The results are sorted by case-sensitive alphabetical order. | [Link](#find-all-merchants)
GET       | `/merchants/find`     | Get the first merchant matching the search, by case-sensitive alphabetical order.        | [Link](#find-one-merchant)

---

# Find All Items

Get the list of items matching the search.  The results are sorted by case-sensitive alphabetical order.

```
GET /items/find_all
```

## Parameters

Name         | Type    | In    | Description
-------------|---------|-------|--------------
`name`       | string  | query | The item name.
`min_price`  | integer | query | Minimum price of the results to fetch.<br>Must be greater than `0`.
`max_price`  | integer | query | Maximum price of the results to fetch.<br>Must be greater than `0`.

- At least one query parameter must be provided.
- The `name` must be queried on its own and cannot be queried with either `min_price` or `max_price`.
- `min_price` and `max_price` can be queried together to find by price range.

## Example Requests

```
Example 1 - Find with Name:
GET https://rails-engine-scott-borecki.herokuapp.com/api/v1/items/find_all?name=hArU

Example 2 - Find with Minimum Price:
GET https://rails-engine-scott-borecki.herokuapp.com/api/v1/items/find_all?min_price=5.50

Example 3 - Find with Maximum Price:
GET https://rails-engine-scott-borecki.herokuapp.com/api/v1/items/find_all?max_price=99.99

Example 4 - Find with Price Range:
GET https://rails-engine-scott-borecki.herokuapp.com/api/v1/items/find_all?min_price=5.50&max_price=99.99

```

## Example Response

```
Status: 200 OK
```

```
Example 1:

{
  "data": [
    {
      "id": "1209",
      "type": "item",
      "attributes": {
        "name": "Item At Harum",
        "description": "Fuga et aut libero veniam tenetur. Ex eligendi modi libero aut numquam at. Velit dolores non ut cupiditate aut consequatur. Maiores quas vel qui aut et voluptatum. Qui consequatur illo.",
        "unit_price": 841.97,
        "merchant_id": 55
      }
    },
    {
      "id": "1344",
      "type": "item",
      "attributes": {
        "name": "Item Aut Harum",
        "description": "Illum ducimus officia possimus est. Rerum sed quia omnis necessitatibus. A sed cupiditate blanditiis ut minus sed.",
        "unit_price": 513.97,
        "merchant_id": 59
      }
    },
    {
      "id": "682",
      "type": "item",
      "attributes": {
        "name": "Item Cum Harum",
        "description": "Libero est magnam dolores officiis velit. Porro ut laboriosam inventore consequatur ratione quae. Aut natus voluptatem saepe excepturi harum dolores.",
        "unit_price": 59.44,
        "merchant_id": 33
      }
    }
  ]
}
```

## Bad Request

```
Status: 400 Bad Request
```

## Resource Not Found

```
Status: 404 Not Found
```


## Validation Failed

```
Status: 422 Unprocessable Entity
```

---

# Find One Item

Get the first item matching the search, by case-sensitive alphabetical order.

```
GET /items/find
```

## Parameters

Name         | Type    | In    | Description
-------------|---------|-------|--------------
`name`       | string  | query | The item name.
`min_price`  | integer | query | Minimum price of the results to fetch.<br>Must be greater than `0`.
`max_price`  | integer | query | Maximum price of the results to fetch.<br>Must be greater than `0`.

- At least one query parameter must be provided.
- The `name` must be queried on its own and cannot be queried with either `min_price` or `max_price`.
- `min_price` and `max_price` can be queried together to find by price range.

## Example Requests

```
Example 1 - Find by Name:
GET https://rails-engine-scott-borecki.herokuapp.com/api/v1/items/find?name=hArU

Example 2 - Find by Minimum Price:
GET https://rails-engine-scott-borecki.herokuapp.com/api/v1/items/find?min_price=5.50

Example 3 - Find by Maximum Price:
GET https://rails-engine-scott-borecki.herokuapp.com/api/v1/items/find?max_price=99.99

Example 4 - Find by Price Range:
GET https://rails-engine-scott-borecki.herokuapp.com/api/v1/items/find?min_price=5.50&max_price=99.99

```

## Example Response

```
Status: 200 OK
```

```
Example 1:
{
  "data": {
    "id": "1209",
    "type": "item",
    "attributes": {
      "name": "Item At Harum",
      "description": "Fuga et aut libero veniam tenetur. Ex eligendi modi libero aut numquam at. Velit dolores non ut cupiditate aut consequatur. Maiores quas vel qui aut et voluptatum. Qui consequatur illo.",
      "unit_price": 841.97,
      "merchant_id": 55
    }
  }
}
```

## Bad Request

```
Status: 400 Bad Request
```

## Resource Not Found

```
Status: 404 Not Found
```


## Validation Failed

```
Status: 422 Unprocessable Entity
```

---

# Find All Merchants

Get the list of merchants matching the search.  The results are sorted by case-sensitive alphabetical order.

```
GET /merchants/find_all
```

## Parameters

Name         | Type    | In    | Description
-------------|---------|-------|--------------
`name`       | string  | query | The merchant name (required).

## Example Request

```
GET https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants/find_all?name=ILL
```

## Example Response

```
Status: 200 OK
```

```
{
  "data": [
    {
      "id": "28",
      "type": "merchant",
      "attributes": {
        "name": "Schiller, Barrows and Parker"
      }
    },
    {
      "id": "13",
      "type": "merchant",
      "attributes": {
        "name": "Tillman Group"
      }
    },
    {
      "id": "5",
      "type": "merchant",
      "attributes": {
        "name": "Williamson Group"
      }
    }
  ]
}
```

## Bad Request

```
Status: 400 Bad Request
```

## Resource Not Found

```
Status: 404 Not Found
```

## Validation Failed

```
Status: 422 Unprocessable Entity
```

---

# Find One Merchant

Get the first merchant matching the search, by case-sensitive alphabetical order.

```
GET /merchants/find
```

## Parameters

Name         | Type    | In    | Description
-------------|---------|-------|--------------
`name`       | string  | query | The merchant name (required).

## Example Request

```
GET https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants/find?name=iLl
```

## Example Response

```
Status: 200 OK
```

```
{
  "data": {
    "id": "28",
    "type": "merchant",
    "attributes": {
      "name": "Schiller, Barrows and Parker"
    }
  }
}
```

## Bad Request

```
Status: 400 Bad Request
```

## Resource Not Found

```
Status: 404 Not Found
```

## Validation Failed

```
Status: 422 Unprocessable Entity
```
