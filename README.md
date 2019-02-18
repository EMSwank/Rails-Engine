# Rails Engine

Rails Engine is a Rails API with a PostgresQL database project built in Turing School of Software and Design's Module 3 Backend course. This API allows the consuption of sales data of an Etsy-style store.

### Setup

Clone the repository

```
$ git clone https://github.com/EMSwank/Rails-Engine.git
```

Bundle the gems

```
$ bundle
$ bundle update
```

Next, run `rake get_data` to create, migrate, and seed the database.

```
$ rake get_data
```

To see the endpoints run the Rails server and visit the endpoints described below

```
$ rails s
```

To run the test suite

```
$ rspec
```

---

### Record Endpoints

Each record includes an `index` action that renders a JSON representation of all the appropriate records, a `show` action which renders a JSON object for the appropriate record, `single finders` and `multi-finders` for searching records by attributes which return a JSON object for any appropriate records, and a `random` action which returns a random JSON object.

#### Index Actions

```
/api/v1/merchants.json
/api/v1/invoices.json
/api/v1/items.json
/api/v1/invoice_items.json
/api/v1/customers.json
/api/v1/transactions.json
```

#### Show Actions

Replace `:id` with the id number of the record you wish to view.

```
/api/v1/merchants/:id.json
/api/v1/invoices/:id.json
/api/v1/items/:id.json
/api/v1/invoice_items/:id.json
/api/v1/customers/:id.json
/api/v1/transactions/:id.json
```

#### Find Actions

##### Single Finders

Finding a single record is easy by passing in query parameters that are associated with the parameters of the record.

```
/api/v1/merchants/find?
/api/v1/invoices/find?
/api/v1/items/find?
/api/v1/invoice_items/find?
/api/v1/customers/find?
/api/v1/transactions/find?
```

Example:
`GET /api/v1/merchants/find?name=Schroeder-Jerde`

##### Multi-Finders

Each category offers multi-find functionality. Use in the same way as single finder, except use `find_all` instead of `find`.

```
/api/v1/merchants/find_all?
/api/v1/invoices/find_all?
/api/v1/items/find_all?
/api/v1/invoice_items/find_all?
/api/v1/customers/find_all?
/api/v1/transactions/find_all?
```

Example:
`GET /api/v1/merchants/find_all?name=Schroeder-Jerde`
(In this case, it returns one record but in an array)

#### Random

To get a random record, visit these endpoints

```
api/v1/merchants/random.json
api/v1/invoices/random.json
api/v1/items/random.json
api/v1/invoice_items/random.json
api/v1/customers/random.json
api/v1/transactions/random.json
```

### Relationship Endpoints

Not only can you query against single resources, Rails Engine allows you to pull relationship data from the API. These resources are exposed through nested URLs.

#### Merchants

- `GET /api/v1/merchants/:id/items` returns a collection of items associated with that merchant.
- `GET /api/v1/merchants/:id/invoices` returns a collection of invoices associated with that merchant from their known orders.

#### Invoices

- `GET /api/v1/invoices/:id/transactions` returns a collection of associated transactions.
- `GET /api/v1/invoices/:id/invoice_items` returns a collection of associated invoice items.
- `GET /api/v1/invoices/:id/items` returns a collection of associated items.
- `GET /api/v1/invoices/:id/customer` returns the associated customer.
- `GET /api/v1/invoices/:id/merchant` returns the associated merchant.

#### Invoice Items

- `GET /api/v1/invoice_items/:id/invoice` returns the associated invoice.
- `GET /api/v1/invoice_items/:id/item` returns the associated item.

#### Items

- `GET /api/v1/items/:id/invoice_items` returns a collection of associated invoice items.
- `GET /api/v1/items/:id/merchant` returns the associated merchant.

#### Transactions

- `GET /api/v1/transactions/:id/invoice` returns the associated invoice.

#### Customers

- `GET /api/v1/customers/:id/invoices` returns a collection of associated invoices.
- `GET /api/v1/customers/:id/transactions` returns a collection of associated transactions.

### Business Intellegence Endpoints

Rails Engine also includes some business analysis on the data.

#### All Merchants

- `GET /api/v1/merchants/most_revenue?quantity=x` returns the top x merchants ranked by total revenue.
- `GET /api/v1/merchants/most_items?quantity=x` returns the top x merchants ranked by total number of items sold.
- `GET /api/v1/merchants/revenue?date=x` returns the total revenue for date x across all merchants.

#### Single Merchant

- `GET /api/v1/merchants/:id/revenue` returns the total revenue for that merchant across successful transactions.
- `GET /api/v1/merchants/:id/revenue?date=x` returns the total revenue for that merchant for a specific invoice date x.
- `GET /api/v1/merchants/:id/favorite_customer` returns the customer who has conducted the most total number of successful transactions.

#### Items

- `GET /api/v1/items/most_revenue?quantity=x` returns the top x items ranked by total revenue generated.
- `GET /api/v1/items/most_items?quantity=x` returns the top x item instances ranked by total number sold.
- `GET /api/v1/items/:id/best_day` returns the date with the most sales for the given item using the invoice date. If there are multiple days with equal number of sales, return the most recent day.

#### Customers

- `GET /api/v1/customers/:id/favorite_merchant` returns a merchant where the customer has conducted the most successful transactions.

---

### Software Versions

- Ruby 2.4.1
- Rails 5.2.1

---
