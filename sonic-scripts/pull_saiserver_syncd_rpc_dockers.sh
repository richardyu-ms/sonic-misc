#!/bin/bash -x
ASIC=brcm
OS_VERSION=20201231.25

docker pull acs-repo.corp.microsoft.com:5001/docker-saiserver-${ASIC}:${OS_VERSION}
docker tag docker-saiserver-${ASIC}:${OS_VERSION} docker-saiserver-${ASIC}
docker pull acs-repo.corp.microsoft.com:5001/docker-syncd-${ASIC}-rpc:${OS_VERSION}
docker tag docker-syncd-${ASIC}-rpc:${OS_VERSION} docker-syncd-${ASIC}-rpc
