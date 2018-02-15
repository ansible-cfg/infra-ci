#!/bin/sh

set -e 

date

# Delete all non-running containers (trying to delete a container in the 2nd command will print an error otherwise) :
docker ps -aq -f status=exited | xargs -r docker rm -v

# Delete all images which name contains "none" :
docker images | grep "<none>" | awk '{print $3}' | xargs -r docker rmi -f

# Delete all unused anymore volumes :
docker volume ls -qf dangling=true | xargs -r docker volume rm

echo "cleanup complete"
