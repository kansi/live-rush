# RushHour

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
