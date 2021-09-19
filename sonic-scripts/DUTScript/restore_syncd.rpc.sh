#!/bin/bash 

. ./Utils.sh
get_asic
get_os_version

docker stop syncd
docker rm syncd

docker tag docker-syncd-${ASIC}:${OS_VERSION} docker-syncd-${ASIC}:latest
config reload -y
