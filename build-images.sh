#!/bin/bash

# Pull latest images
docker pull jenkins/jenkins
docker pull jenkins/inbound-agent

# Build Jenkins images with matching docker GID with host's
DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)

docker build -f Dockerfile-master -t jenkins-master --build-arg DOCKER_GID=${DOCKER_GID} .
docker build -f Dockerfile-agent -t jenkins-agent --build-arg DOCKER_GID=${DOCKER_GID} .
