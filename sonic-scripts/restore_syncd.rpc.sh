#!/bin/bash -x 

ASIC=brcm
OS_VERSION=20201231.25

docker stop syncd
docker rm syncd

docker tag docker-syncd-${ASIC}:${OS_VERSION} docker-syncd-${ASIC}:latest
config reload -y
