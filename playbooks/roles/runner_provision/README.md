# Auto Register Gitlab Runner Dockerfile
This repository contains Dockerfile of Gitlab Runner that auto register on Gitlab CI.
Gitlab Runner is used to fetch and run pipeline jobs with GitLab CI.

The Auto Register Gitlab Runner is based on [the official Gitlab runner docker image](https://hub.docker.com/r/gitlab/gitlab-runner).

## Build the docker image

`docker build --tag comutitres/gitlab-runner-java-maven .`

# Run the docker image

## Using the shared runner registration token
```bash
docker run -d \
	   --restart=always \
           --name gitlab-runner-java-maven \
           -e "CI_SERVER_URL=http://gitlab-ci" \
           -e "REGISTRATION_TOKEN=f47KqYaN9XMguFcJSyaz" \
           -e "RUNNER_NAME=ci-multi-runner" \
           -e "RUNNER_EXECUTOR=shell" \
           -e "REGISTER_RUN_UNTAGGED=true" \
           comutitres/gitlab-runner-java-maven
```

## Getting the shared runner token from the Gitlab-CI
```bash
docker run -d \
	   --restart=always \
           --name gitlab-runner-java-maven \
           -e "CI_SERVER_URL=http://gitlab-ci" \
           -e "USERNAME=admin_user_name" \
           -e "PASSWORD=admin_password" \
           -e "RUNNER_NAME=ci-multi-runner" \
           -e "REGISTER_RUN_UNTAGGED=true" \
           -e "RUNNER_EXECUTOR=shell" \
           comutitres/gitlab-runner-java-maven
```

## Environment variables

| Env Variable                                | Description        |
|---------------------------------------|-------------|
| CI_SERVER_URL                                   | The URL of the GitLab instance to connect to, e.g. http://gitlab.mycompany.com. |
| USERNAME                                   | Gitlab-CI admin user name. USERNAME parameter is **optional**, It will be used to get the shared runner token from the Gitlab-CI. Either this environment variable with `PASSWORD`  or `REGISTRATION_TOKEN` are **mandatory**.  |
| PASSWORD                                   | Gitlab-CI admin password. PASSWORD parameter is **optional**, It will be used to get the shared runner token from the Gitlab-CI. Either this environment variable with `USERNAME`  or `REGISTRATION_TOKEN` are **mandatory**. |
| REGISTRATION_TOKEN                                   | The registration token to use with the GitLab instance. The token can be viewed in the admin area runners section. Either this environment variable or `USERNAME` and `PASSWORD` are **mandatory**. |
| RUNNER_NAME                                   | Gitlab runner name. |
| RUNNER_EXECUTOR                                   | Gitlab runner executor. GitLab runner implements a number of [executors](https://docs.gitlab.com/runner/executors/) that can be used to run builds in different scenarios|
| REGISTER_RUN_UNTAGGED                                   | Indicates whether this runner can pick jobs without tags |

## Inspiration and sources
* [Gitlab Runner docker image sources](https://github.com/ayufan/gitlab-ci-multi-runner)
* [Gitlab Runner docker image](https://hub.docker.com/r/gitlab/gitlab-runner/)
* [DumbInit sources](https://github.com/Yelp/dumb-init)
* [Gitlab Runner Auto Register Inspiration](https://github.com/pcodk/gitlab-runner-auto-register)
* [Gitlab documentation for registering runners](https://docs.gitlab.com/runner/register/)
* [Gitlab Runner Executors](https://docs.gitlab.com/runner/executors/)