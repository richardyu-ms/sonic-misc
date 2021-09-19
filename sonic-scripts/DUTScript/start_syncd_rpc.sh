#!/bin/bash

. ./Utils.sh
get_asic
get_os_version

docker stop syncd
docker rm syncd
#replace syncd with syncd-rpc
docker tag docker-syncd-${ASIC}-rpc docker-syncd-${ASIC}:latest
/usr/bin/syncd.sh start
