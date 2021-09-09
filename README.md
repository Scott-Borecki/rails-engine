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

## Getting Started



## Endpoints

Assuming you are accessing the API through your local server, the `base path` of each endpoint request should be:

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

## Contributors

| ![GitHub Avatar: Scott Borecki][github-avatar] | Scott Borecki<br><br>[![GitHub: Scott-Borecki][github-follow-badge]][GitHub]<br>[![Email: scottborecki@gmail.com][gmail-badge]][gmail]<br>[![LinkedIn: scott-borecki][linkedin-badge]][LinkedIn]<br> |
|-|-|

<!-- Links -->
[GitHub]: https://github.com/scott-borecki
[gmail]: mailto:scottborecki@gmail.com
[LinkedIn]: https://www.linkedin.com/in/scott-borecki/

<!-- Badges -->
[github-follow-badge]: https://img.shields.io/github/followers/scott-borecki?label=follow&style=social
[gmail-badge]: https://img.shields.io/badge/gmail-scottborecki@gmail.com-green?style=flat&logo=gmail&logoColor=white&color=white&labelColor=EA4335
[linkedin-badge]: https://img.shields.io/badge/Scott--Borecki-%23OpenToWork-green?style=flat&logo=Linkedin&logoColor=white&color=success&labelColor=0A66C2

<!-- Images -->
[github-avatar]: https://avatars.githubusercontent.com/u/79381792?s=100
