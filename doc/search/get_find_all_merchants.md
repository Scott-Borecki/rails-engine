# Find All Merchants

```
GET /merchants/find_all
```


## Parameters

Name         | Type    | In    | Description
-------------|---------|-------|--------------
`name`       | string  | query | Required


## Code Sample

From your local development web server:

```
http://localhost:3000/api/v1/merchants/find_all?name=ring
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
      "type": "merchant",
      "attributes": {
        "name": "Ring World"
      }
    },
    {
      "id": "1",
      "type": "merchant",
      "attributes": {
        "name": "Turing School"
      }
    }
  ]
}
```


## Resource Not Found

```
Status: 404 Not Found
```


## Validation Failed

```
Status: 422 Unprocessable Entity
```
