# Gitlab PostgreSQL Dockerfile
This repository contains Dockerfile of Gitlab PostgreSQL.

The Gitlab PostgreSQL is based on [the sameersbn docker image](https://github.com/sameersbn/docker-postgresql).

## Env variables

| Env Variable                                | Description        |
|---------------------------------------|-------------|
| DB_NAME | A new PostgreSQL database can be created by specifying the DB_NAME variable while starting the container |
| DB_USER | If the DB_USER and DB_PASS variables are specified along with the DB_NAME variable, then the user specified in DB_USER will be granted access to all the databases listed in DB_NAME. |
| DB_PASS | If the DB_USER and DB_PASS variables are specified along with the DB_NAME variable, then the user specified in DB_USER will be granted access to all the databases listed in DB_NAME. |
| DB_EXTENSION | Add db extensions to the environment of the PostgreSQL container. A comma separated list of modules can be specified using the DB_EXTENSION parameter. |

## Inspiration and sources
* [PostgreSQL docker image sources](https://github.com/sameersbn/docker-postgresql)
* [PostgreSQL docker image](https://hub.docker.com/r/sameersbn/postgresql/~/dockerfile/)
* [Gitlab CI docker image sources](https://github.com/sameersbn/docker-gitlab)
* [Gitlab CI docker image](https://hub.docker.com/r/sameersbn/gitlab/)