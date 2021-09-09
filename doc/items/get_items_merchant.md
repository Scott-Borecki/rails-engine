# Get a Item's Merchant

Returns the Merchant that sells the Item.

```
GET /items/{item_id}/merchant
```


## Parameters

Name            | Type    | In    | Description
----------------|---------|-------|--------------
`item_id`       | integer | path  |


## Code Sample

From your local development web server:

```
http://localhost:3000/api/v1/items/209/merchant
```


## Response

```
Status: 200 OK
```

```
{
  "data": {
    "id": "11",
    "type": "merchant",
    "attributes": {
      "name": "Pollich and Sons"
    }
  }
}
```


## Resource Not Found
```
Status: 404 Not Found
```
