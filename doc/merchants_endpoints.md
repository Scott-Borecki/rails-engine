# Merchants Endpoints

HTTP Verb | Endpoint                   | Description                | Link
----------|----------------------------|----------------------------|---------------------------
GET       | `/merchants`               | Get the list of merchants. | [Link](#get-all-merchants)
GET       | `/merchants/{merchant_id}` | Get a single merchant.     | [Link](#get-one-merchant)

---

## Get All Merchants

Get the list of merchants.

```
GET /merchants
```

### Parameters

Name       | Type    | In    | Description
-----------|---------|-------|--------------
`per_page` | integer | query | Results per page.<br>Default: `20`
`page`     | integer | query | Page number of the results to fetch.<br>Default: `1`

### Example Request

```
GET https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants?page=1&per_page=3
```

### Example Response

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
        "name": "Schroeder-Jerde"
      }
    },
    {
      "id": "2",
      "type": "merchant",
      "attributes": {
        "name": "Klein, Rempel and Jones"
      }
      },
    {
      "id": "3",
      "type": "merchant",
      "attributes": {
        "name": "Willms and Sons"
      }
    }
  ]
}
```

---

## Get One Merchant

Returns a merchant and their attributes.

```
GET /merchants/{merchant_id}
```


### Parameters

Name          | Type    | In    | Description
--------------|---------|-------|-----------------------
`merchant_id` | integer | path  | The ID of the merchant.

### Example Request

```
GET https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants/42
```

### Example Response

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

### Resource Not Found

```
Status: 404 Not Found
```
