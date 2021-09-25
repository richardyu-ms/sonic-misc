#!/bin/bash 
. ./Utils.sh
get_asic
get_os_version

SONIC_REG=acs-repo.corp.microsoft.com:5001
docker pull ${SONIC_REG}/docker-saiserver-${ASIC}:${OS_VERSION}
docker tag  ${SONIC_REG}/docker-saiserver-${ASIC}:${OS_VERSION} docker-saiserver-${ASIC}
docker pull ${SONIC_REG}/docker-syncd-${ASIC}-rpc:${OS_VERSION}
docker tag ${SONIC_REG}/docker-syncd-${ASIC}-rpc:${OS_VERSION} docker-syncd-${ASIC}-rpc
