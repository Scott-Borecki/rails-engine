# Business Intelligence Endpoints

HTTP Verb | Endpoint                         | Description                              | Link
----------|----------------------------------|------------------------------------------|---------------------------
GET       | `/revenue/items` | Get the list of items with the most revenue. | [Link](#get-items-with-most-revenue)
GET       | `/revenue/merchants`      | Get the list of merchants with the most revenue. | [Link](#get-merchants-with-most-revenue)
GET       | `/merchants/most_items`      | Get the list of merchants with the most items sold. | [Link](#get-merchants-with-most-items-sold)
GET       | `/revenue/merchants/{merchant_id}`      | Get the total revenue for a merchant.        | [Link](#get-total-revenue-for-a-merchant)

---

## Get Items with Most Revenue

Get the list of items with the most revenue.

```
GET /revenue/items
```

### Parameters

Name       | Type    | In    | Description
-----------|---------|-------|--------------
`quantity` | integer | query | Quantity of items returned.<br>Default: `10`

### Example Request

```
GET https://rails-engine-scott-borecki.herokuapp.com/api/v1/revenue/items?quantity=3
```

### Example Response

```
Status: 200 OK
```

```
{
  "data": [
    {
      "id": "227",
      "type": "item_revenue",
      "attributes": {
        "name": "Item Dicta Autem",
        "description": "Fugiat est ut eum impedit vel et. Deleniti quia debitis similique. Sint atque explicabo similique est. Iste fugit quis voluptas. Rerum ut harum sed fugiat eveniet ullam ut.",
        "unit_price": 853.19,
        "merchant_id": 14,
        "revenue": 1148393.7399999984
      }
    },
    {
      "id": "2174",
      "type": "item_revenue",
      "attributes": {
        "name": "Item Nam Magnam",
        "description": "Eligendi quibusdam eveniet temporibus sed ratione ut magnam. Sit alias et. Laborum dignissimos quos impedit excepturi molestiae.",
        "unit_price": 788.08,
        "merchant_id": 89,
        "revenue": 695086.5599999998
      }
    },
    {
      "id": "1119",
      "type": "item_revenue",
      "attributes": {
        "name": "Item Aut Vero",
        "description": "Et molestiae commodi facilis maxime alias ut. Iusto possimus et earum et. Ipsum et iure laudantium eum est ratione et. Est iste soluta. Rerum iste quas.",
        "unit_price": 943.78,
        "merchant_id": 51,
        "revenue": 517191.4400000003
      }
    }
  ]
}
```

---

## Get Merchants with Most Revenue

Get the list of merchants with the most revenue.

```
GET /revenue/merchants
```

### Parameters

Name       | Type    | In    | Description
-----------|---------|-------|--------------
`quantity` | integer | query | Quantity of merchants returned.<br>Quantity must be provided


### Example Request

```
GET https://rails-engine-scott-borecki.herokuapp.com/api/v1/revenue/merchants?quantity=3
```

### Example Response

```
Status: 200 OK
```

```
{
  "data": [
    {
      "id": "14",
      "type": "merchant_name_revenue",
      "attributes": {
        "name": "Dicki-Bednar",
        "revenue": 1148393.7399999984
      }
    },
    {
      "id": "89",
      "type": "merchant_name_revenue",
      "attributes": {
        "name": "Kassulke, O'Hara and Quitzon",
        "revenue": 1015275.1500000001
      }
    },
    {
      "id": "98",
      "type": "merchant_name_revenue",
      "attributes": {
        "name": "Okuneva, Prohaska and Rolfson",
        "revenue": 917424.8599999995
      }
    }
  ]
}
```

---

## Get Merchants with Most Items Sold

Get the list of merchants with the most items sold.

```
GET /merchants/most_items
```

### Parameters

Name       | Type    | In    | Description
-----------|---------|-------|--------------
`quantity` | integer | query | Quantity of merchants returned.<br>Quantity must be provided


### Example Request

```
GET https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants/most_items?quantity=3
```

### Example Response

```
Status: 200 OK
```

```
{
  "data": [
    {
      "id": "89",
      "type": "items_sold",
      "attributes": {
        "name": "Kassulke, O'Hara and Quitzon",
        "count": 1653
      }
    },
    {
      "id": "12",
      "type": "items_sold",
      "attributes": {
        "name": "Kozey Group",
        "count": 1585
      }
    },
    {
      "id": "22",
      "type": "items_sold",
      "attributes": {
        "name": "Thiel Inc",
        "count": 1529
      }
    }
  ]
}
```

---

## Get Total Revenue for a Merchant

Get the total revenue for a merchant.

```
GET /revenue/merchants/{merchant_id}
```

### Parameters

Name       | Type    | In    | Description
-----------|---------|-------|--------------
`merchant_id` | integer | path | The ID of the merchant.

### Example Request

```
GET https://rails-engine-scott-borecki.herokuapp.com/api/v1/revenue/merchants/42
```

### Example Response

```
Status: 200 OK
```

```
{
  "data": {
    "id": "42",
    "type": "merchant_revenue",
    "attributes": {
      "revenue": 532613.9800000001
    }
  }
}
```
