#!/usr/bin/env bash

set -e

GIT_ROOT=$( git rev-parse --show-toplevel )

echo "Starting docket daemon"
systemctl start docker

echo "Docker daemon running. Building latest image"
docker build -t rockets_cli:latest ${GIT_ROOT}

echo "Bring up container"
docker run --name rocketTest -d rockets_cli:latest
echo ""

#Wait for the container to be instantiated
sleep 5

echo "Running default cli command against container: docker exec -it rocketTest rockets"
docker exec -it rocketTest rockets
