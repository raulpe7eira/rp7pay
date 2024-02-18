# RP7Pay API

This repository is the code corresponding to the [nlw#4 - trilha elixir](https://nextlevelweek.com/) lab by Rafael Camarda.

> The project simulates a banking API that allows to withdraw, deposit or transfer money between two accounts and uses Basic Auth as authentication in some resources.

## Previous installations

**Database**, we recommends install [PostgreSQL](https://www.postgresql.org/) with [Docker](https://hub.docker.com/_/postgres). After that, sets connection configuration at:

- `config/dev.exs`
- `config/test.exs`

## Gets dependencies, setups database, tests, coverages, reports and starts application

```bash
cd rp7pay
mix deps.get
mix ecto.setup
mix test
mix test --cover
mix coveralls.html
mix phx.server
```

## How to use?

```bash
# welcomes (
#   replaces curly braces:
#     {filename} : path for CSV file w/ the following sintax - `1,2,3,4,8,9,10`
# )
curl -X GET 'http://localhost:4000/api/{filename}'

# creates user
curl -X POST 'http://localhost:4000/api/users' \
-H 'Content-Type: application/json' \
-d '{
    "name": "Raul Pereira",
    "nickname": "raulpe7eira",
    "email": "mail@raulpe7eira.com",
    "age": 40,
    "password": "12345abcd"
}'

# does deposit (
#   replaces curly braces:
#     {id} : account identifier
#     {basic_auth} : username and password credentials
# )
curl -X POST 'http://localhost:4000/api/accounts/{id}/deposit' \
-H 'Authorization: {basic_auth}' \
-H 'Content-Type: application/json' \
-d '{
    "value": 50.00
}'

# does withdraw (
#   replaces curly braces:
#     {id} : account identifier
#     {basic_auth} : username and password credentials
# )
curl -X POST 'http://localhost:4000/api/accounts/{id}/withdraw' \
-H 'Authorization: {basic_auth}' \
-H 'Content-Type: application/json' \
-d '{
    "value": 1.00
}'

# does transaction (
#   replaces curly braces:
#     {from} : from account identifier
#     {to} : to account identifier
#     {basic_auth} : username and password credentials
# )
curl -X POST 'http://localhost:4000/api/accounts/transaction' \
-H 'Authorization: {basic_auth}' \
-H 'Content-Type: application/json' \
-d '{
    "from": "{from}",
    "to": "{to}",
    "value": 1.00
}'
```
