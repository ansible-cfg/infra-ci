# Gitlab CI Dockerfile
Dockerfile to build a GitLab image for the Docker opensource container platform.

The Gitlab CI is based on [the sameersbn Gitlab CI docker image](https://github.com/sameersbn/docker-gitlab).

## Env variables

| Env Variable                                | Description        |
|---------------------------------------|-------------|
| REDIS_HOST                                   | The hostname of the redis server. Defaults to localhost |
| REDIS_PORT                                   | The connection port of the redis server. Defaults to 6379 |
| DB_ADAPTER                                   | The database type. Possible values: mysql2, postgresql. Defaults to postgresql |
| DB_HOST | The database server hostname. Defaults to localhost |
| DB_NAME | The database database name. Defaults to gitlabhq_production |
| DB_USER | The database database user. Defaults to root  |
| DB_PASS                                   | The database database password. Defaults to no password |
| GITLAB_SIGNUP_ENABLED | Enable or disable user signups (first run only). Default is true |
| GITLAB_HTTPS | Set to true to enable https support, disabled by default. |

## Inspiration and sources
* [Gitlab CI docker image sources](https://github.com/sameersbn/docker-gitlab)
* [Gitlab CI docker image](https://hub.docker.com/r/sameersbn/gitlab/)
* [PostgreSQL docker image sources](https://github.com/sameersbn/docker-postgresql)
* [PostgreSQL docker image](https://hub.docker.com/r/sameersbn/postgresql/~/dockerfile/)
* [Gitlab CI availabe configuration parameters](https://github.com/sameersbn/docker-gitlab#available-configuration-parameters)
