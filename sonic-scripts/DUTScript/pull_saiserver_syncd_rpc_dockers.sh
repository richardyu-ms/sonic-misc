#!/bin/bash 
DIR=$(dirname $(readlink -f "$0")) # absolute path
. $DIR/Utils.sh
get_asic
get_os_version

while getopts ":v:" args; do
    case $args in
        v)
            SAI_VERSION=${OPTARG} 
            ;;
        *)
            echo -e "\t-v [v1|v2]: saiserver version, support v1 and v2"
        ;;
    esac
done

check_sai_versions

SONIC_REG=acs-repo.corp.microsoft.com:5001
docker pull ${SONIC_REG}/docker-saiserver${SAI_VERSION}-${ASIC}:${OS_VERSION}
docker tag  ${SONIC_REG}/docker-saiserver${SAI_VERSION}-${ASIC}:${OS_VERSION} docker-saiserver${SAI_VERSION}-${ASIC}
docker pull ${SONIC_REG}/docker-syncd-${ASIC}-rpc:${OS_VERSION}
docker tag ${SONIC_REG}/docker-syncd-${ASIC}-rpc:${OS_VERSION} docker-syncd-${ASIC}-rpc
