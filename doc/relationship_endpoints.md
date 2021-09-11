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

Name                | Type    | In    | Description
--------------------|---------|-------|--------------
`merchant_id`       | integer | path  | The ID of the merchant.

## Example Request

```
GET https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants/99/items
```

## Example Response

```
Status: 200 OK
```

```
{
  "data": [
    {
      "id": "2425",
      "type": "item",
      "attributes": {
        "name": "Item Excepturi Rem",
        "description": "Perferendis reprehenderit fugiat sit eos. Corporis ipsum ut. Natus molestiae quia rerum fugit quis. A cumque doloremque magni.",
        "unit_price": 476.82,
        "merchant_id": 99
      }
    },
    {
      "id": "2427",
      "type": "item",
      "attributes": {
        "name": "Item Illum Minus",
        "description": "Aut voluptatem aut officiis minima cum at. Est ea sed est quia repudiandae. Eum omnis rerum in adipisci aut. Deleniti sunt voluptatibus rerum aut quo omnis.",
        "unit_price": 98.07,
        "merchant_id": 99
      }
    },
    {
      "id": "2426",
      "type": "item",
      "attributes": {
        "name": "Item Repellendus Cum",
        "description": "Odio vitae asperiores sint ut labore. Tenetur perspiciatis facere quos cum. Optio modi consequatur.",
        "unit_price": 612.11,
        "merchant_id": 99
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

Name            | Type    | In    | Description
----------------|---------|-------|--------------
`item_id`       | integer | path  | The ID of the item.

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
