# Relationship Endpoints

HTTP Verb | Endpoint                         | Description                              | Link
----------|----------------------------------|------------------------------------------|---------------------------
GET       | `/merchants/{merchant_id}/items` | Get the list of items from the merchant. | [Link](#get-a-merchants-items)
GET       | `/items/{item_id}/merchant`      | Get the merchant of the item.            | [Link](#get-an-items-merchant)

---

# Get a Merchant's Items

Returns a list of items that belong to merchant.

```
GET /merchants/{merchant_id}/items
```

## Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`merchant_id` | Integer | Path | Required | The ID of the merchant.

## Example Request

```
GET https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants/33/items
```

## Example Response

```
Status: 200 OK
```

```
{
  "data": [
    {
      "id": "685",
      "type": "item",
      "attributes": {
        "name": "Item Et Incidunt",
        "description": "In repellat assumenda. Pariatur earum ut. Eum cupiditate rerum modi qui consectetur fugiat nihil.",
        "unit_price": 952.47,
        "merchant_id": 33
      }
    },
    {
      "id": "679",
      "type": "item",
      "attributes": {
        "name": "Item Perspiciatis Excepturi",
        "description": "Id odit nesciunt est et veritatis sapiente. Aut quod explicabo blanditiis odio fugit ullam totam. Cumque dolorem exercitationem et et.",
        "unit_price": 304.02,
        "merchant_id": 33
      }
    },
    {
      "id": "680",
      "type": "item",
      "attributes": {
        "name": "Item Est Praesentium",
        "description": "Eius facilis ut et explicabo et et. Et inventore at occaecati veritatis possimus. Est quae id voluptas et laboriosam impedit in. Nam adipisci iure. Voluptatem qui vel sit.",
        "unit_price": 422.03,
        "merchant_id": 33
      }
    }
  ]
}
```

## Resource Not Found
```
Status: 404 Not Found
```

---

# Get an Item's Merchant

Returns the merchant that sells the item.

```
GET /items/{item_id}/merchant
```

## Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`item_id` | Integer | Path | Required | The ID of the item.

## Example Request

```
GET https://rails-engine-scott-borecki.herokuapp.com/api/v1/items/209/merchant
```

## Example Response

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
