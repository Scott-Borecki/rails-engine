# Find All Items

```
GET /items/find_all
```


## Parameters

Name         | Type    | In    | Description
-------------|---------|-------|--------------
`name`       | string  | query |
`min_price`  | integer | query | Minimum price of the results to fetch<br>Must be greater than 0
`max_price`  | integer | query | Maximum price of the results to fetch<br>Must be greater than 0

- At least one query parameter must be provided.
- The `name` must be queried on its own and cannot be queried with either `min_price` or `max_price`.
- `min_price` and `max_price` can be queried together to find by price range.
- Results are sorted by case-sensitive alphabetical order


## Code Sample

From your local development web server:

```
Example 1 - Find by Name:
http://localhost:3000/api/v1/items/find_all?name=ring

Example 2 - Find by Minimum Price:
http://localhost:3000/api/v1/items/find_all?min_price=5.50

Example 3 - Find by Maximum Price:
http://localhost:3000/api/v1/items/find_all?max_price=99.99

Example 4 - Find by Price Range:
http://localhost:3000/api/v1/items/find_all?min_price=5.50&max_price=99.99

```


## Response

```
Status: 200 OK
```

```
ENTER DATA RESPONSE
```


## Resource Not Found

```
Status: 404 Not Found
```


## Validation Failed

```
Status: 422 Unprocessable Entity
```
