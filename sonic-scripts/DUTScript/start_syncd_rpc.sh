#!/bin/bash

. ./Utils.sh
get_asic
get_os_version

docker stop syncd
docker rm syncd
#replace syncd with syncd-rpc
echo "Tag [docker-syncd-rpc-${ASIC}:${OS_VERSION}]  To [docker-syncd-rpc-${ASIC}]"
docker tag docker-syncd-rpc-${ASIC}:${OS_VERSION} docker-syncd-rpc-${ASIC}
echo "Tag [docker-syncd-rpc-${ASIC}] to  [docker-syncd-${ASIC}:latest]"
docker tag docker-syncd-rpc-${ASIC} docker-syncd-${ASIC}:latest
/usr/bin/syncd.sh start
