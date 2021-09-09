# Get All Merchants

```
GET /merchants
```


## Parameters

Name       | Type    | In    | Description
-----------|---------|-------|--------------
`per_page` | integer | query | Results per page<br>Default: `20`
`page`     | integer | query | Page number of the results to fetch<br>Default: `1`


## Code Sample

From your local development web server:

```
http://localhost:3000/api/v1/merchants
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
        "type": "merchant",
        "attributes": {
          "name": "Mike's Awesome Store",
        }
    },
    {
      "id": "2",
      "type": "merchant",
      "attributes": {
        "name": "Store of Fate",
      }
    },
    {
      "id": "3",
      "type": "merchant",
      "attributes": {
        "name": "This is the limit of my creativity",
      }
    }
  ]
}
```
