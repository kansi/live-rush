# RushHour

To run the project browse to `rush_hour` directory and execute the following,

## Env

```
elixir 1.12.2-otp-23
erlang 23.1
```

## Setup asset deps

```sh
cd assets
npm install
```

## Setup database

```sh
docker-compose up -d
```

## Setup service

Setup the service with seed data

```sh
mix setup
mix assets.deploy
```


## Run service locally

```sh
mix phx.server
```


## Run tests

```sh
mix ecto.reset
mix test
```
