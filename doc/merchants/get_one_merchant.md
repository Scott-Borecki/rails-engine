# Get One Merchant

```
GET /merchants/{id}
```


## Parameters

Name       | Type    | In    | Description
-----------|---------|-------|--------------
`id`       | integer | path  |


## Code Sample

From your local development web server:

```
http://localhost:3000/api/v1/merchants/1
```


## Response

```
Status: 200 OK
```

```
{
  "data": {
    "id": "1",
    "type": "merchant",
    "attributes": {
      "name": "Super Merchant"
    }
  }
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
