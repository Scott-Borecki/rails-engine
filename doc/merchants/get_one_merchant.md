# Get One Merchant

Returns a Merchant and their attributes.

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
http://localhost:3000/api/v1/merchants/42
```


## Response

```
Status: 200 OK
```

```
{
  "data": {
    "id": "42",
    "type": "merchant",
    "attributes": {
      "name": "Glover Inc"
    }
  }
}
```


## Resource Not Found

```
Status: 404 Not Found
```
