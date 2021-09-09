# Rails Engine API


## Table of Contents

- [Overview](#overview)
- [Getting Started](#getting-started)
- [Endpoints](#endpoints)
  - [Merchants](#endpoints)
  - [Items](#endpoints)
  - [Relationships](#relationships)
  - [Search](#search)
  - [Business Intelligence](#business-intelligence)
- [Contributors](#contributors)

**Author**: [Scott Borecki](https://github.com/scott-borecki)

## Overview
This is an API that provides a means to access resources from an Ecommerce database.  This API uses both RESTful and non-RESTful endpoints.

## Endpoints

The base path of each endpoint request is:

```
http://localhost:3000/api/v1
```

### [Merchants](/doc/merchants_endpoints.md)

- [Get All Merchants](/doc/merchants_endpoints.md#get-all-merchants)
- [Get One Merchant](/doc/merchants_endpoints.md#get-one-merchant)

### [Items](/doc/items_endpoints.md)

- [Get All Items](/doc/items_endpoints.md#get-all-items)
- [Get One Item](/doc/items_endpoints.md#get-one-item)
- [Create an Item](/doc/items_endpoints.md#create-an-item)
- [Update an Item](/doc/items_endpoints.md#update-an-item)
- [Destroy an Item](/doc/items_endpoints.md#delete-an-item)

### [Relationships](/doc/relationship_endpoints.md)

- [Get a Merchant's Items](/doc/relationship_endpoints.md#get-a-merchants-items)
- [Get an Item's Merchant](/doc/relationship_endpoints.md#get-an-items-merchant)

### [Search](/doc/search_endpoints.md)

- [Find All Items](/doc/search_endpoints.md#find-all-items)
- [Find One Item](/doc/search_endpoints.md#find-one-item)
- [Find All Merchants](/doc/search_endpoints.md#find-all-merchants)
- [Find One Merchant](/doc/search_endpoints.md#find-one-merchant)

### [Business Intelligence](/doc/business_intelligence_endpoints.md)

- [Items by Most Revenue](/doc/business_intelligence_endpoints.md#get-items-with-most-revenue)
- [Merchants with Most Revenue](/doc/business_intelligence_endpoints.md#get-merchants-with-most-revenue)
- [Merchants with Most Items Sold](/doc/business_intelligence_endpoints.md#get-merchants-with-most-items-sold)
- [Total Revenue for a Given Merchant](/doc/business_intelligence_endpoints.md#get-total-revenue-for-a-merchant)

## Error Conditions

## Getting Started

## License

## Acknowledgements
