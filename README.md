# Store-API

## Start

1. `docker-compose up`
1. Create ENV files: `.env.development` and/or `.env.test`
1. Documentation `docs/swagger.yaml`.

## ENV

* RAILS_ENV

`/config/database.yml`

* DATABASE_NAME
* DATABASE_HOST
* DATABASE_PORT
* DATABASE_USERNAME
* DATABASE_PASSWORD
* DATABASE_URL

`/config/redis.yml`

* REDIS_HOST
* REDIS_PORT
* REDIS_DB

* SESSION_REDIS_HOST
* SESSION_REDIS_PORT
* SESSION_PREFIX
* SESSION_REDIS_DB
* SESSION_REDIS_EXPIRE
