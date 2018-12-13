#!/bin/bash
#You should start this script on host machine
COUNT=2
RUNNERS_CONFIG_PREFIX='/srv/auto-runner'
GITLAB_URL='http://35.205.233.159/'
GITLAB_REGISTRATION_TOKEN='GRbQoqopFnyeY8pBkqK8'
#kill and remove old containers
docker rm --force $(docker ps -a -q --filter="name=auto-runner")
#delete old config volumes
for ((i=1; i<=$COUNT; i++))
  do
    echo $RUNNERS_CONFIG_PREFIX/$i
    if [ -d "$RUNNERS_CONFIG_PREFIX/$i" ]; then
      sudo rm -rf $RUNNERS_CONFIG_PREFIX/$i
    fi
  done
#create new config volumes
for ((i=1; i<=$COUNT; i++))
  do
    sudo mkdir $RUNNERS_CONFIG_PREFIX/$i
  done
#create new runners
for ((i=1; i<=$COUNT; i++))
  do
    docker run --rm -t -i -v $RUNNERS_CONFIG_PREFIX/$i:/etc/gitlab-runner --name auto-runner$i gitlab/gitlab-runner register \
      --non-interactive \
      --executor "docker" \
      --docker-image alpine:3 \
      --url "$GITLAB_URL" \
      --registration-token "$GITLAB_REGISTRATION_TOKEN" \
      --description "auto-runner$i" \
      --tag-list "linux,xenial,ubuntu,docker" \
      --run-untagged \
      --locked="false"
    docker run -d --name auto-runner$i --restart always -v $RUNNERS_CONFIG_PREFIX/$i:/etc/gitlab-runner -v /var/run/docker.sock:/var/run/docker.sock gitlab/gitlab-runner:latest
  done

