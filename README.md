# Rails Engine API

![Version][version-badge]
[![Ruby Style Guide][rubocop-badge]][rubocop-url]
[![Contributors][contributors-badge]][contributors-url]
[![Forks][forks-badge]][forks-url]
[![Stargazers][stars-badge]][stars-url]
[![Issues][issues-badge]][issues-url]

Rails Engine is an API to access resources from an Ecommerce database.  This API uses both RESTful and non-RESTful endpoints.

## Table of Contents

- [Getting Started](#getting-started)
- [Endpoints & Documentation](#endpoints-&-documentation)
  - [Merchants](#merchants)
  - [Items](#items)
  - [Relationships](#relationships)
  - [Search](#search)
  - [Business Intelligence](#business-intelligence)
- [Contributors](#contributors)

**Author**: [Scott Borecki](https://github.com/scott-borecki)

## Getting Started

1. Fork this repository.

2. Clone your forked repository.

  `$ git clone` and the copied URL.

3. Install dependencies.

  Navigate into the project directory and run `$ bundle install`.

4. Setup and migrate the database

  From the project directory, run `$ rails db:{drop,create,migrate,seed}`.

  Then run `$ rails db:schema:dump`.

5. Start the Rails Server.

  From the project directory, run `$ rails s`.

6. Fire up your favorite API client.

  For `GET` requests, you can simply send the endpoint requests through your internet browser.  

  For any other requests (i.e. `POST`, `PATCH`, `DELETE`), you will need to use an API client such as [Postman][postman-url].

  The `base path` of each endpoint is:

  ```
  http://localhost:3000/api/v1
  ```

## Endpoints & Documentation

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

<!-- Top Level Badges and Links -->
[rubocop-badge]: https://img.shields.io/badge/code_style-rubocop-brightgreen.svg?style=flat-square
[rubocop-url]: https://github.com/rubocop/rubocop
[version-badge]: https://img.shields.io/badge/API_version-V1-or.svg?&style=flat-square&logoColor=white
[contributors-badge]: https://img.shields.io/github/contributors/scott-borecki/rails-engine.svg?style=flat-square
[contributors-url]: https://github.com/scott-borecki/rails-engine/graphs/contributors
[forks-badge]: https://img.shields.io/github/forks/scott-borecki/rails-engine.svg?style=flat-square
[forks-url]: https://github.com/scott-borecki/rails-engine/network/members
[stars-badge]: https://img.shields.io/github/stars/scott-borecki/rails-engine.svg?style=flat-square
[stars-url]: https://github.com/scott-borecki/rails-engine/stargazers
[issues-badge]: https://img.shields.io/github/issues/scott-borecki/rails-engine.svg?style=flat-square
[issues-url]: https://github.com/scott-borecki/rails-engine/issues

<!-- Links -->
[Repository]: https://github.com/Scott-Borecki/rails-engine
[GitHub]: https://github.com/scott-borecki
[gmail]: mailto:scottborecki@gmail.com
[LinkedIn]: https://www.linkedin.com/in/scott-borecki/
[postman-url]: https://www.postman.com/

<!-- Badges -->
[github-follow-badge]: https://img.shields.io/github/followers/scott-borecki?label=follow&style=social
[gmail-badge]: https://img.shields.io/badge/gmail-scottborecki@gmail.com-green?style=flat&logo=gmail&logoColor=white&color=white&labelColor=EA4335
[linkedin-badge]: https://img.shields.io/badge/Scott--Borecki-%23OpenToWork-green?style=flat&logo=Linkedin&logoColor=white&color=success&labelColor=0A66C2

<!-- Images -->
[github-avatar]: https://avatars.githubusercontent.com/u/79381792?s=100
