#!/bin/bash 
#show platform summary | grep "ASIC:" | awk -F'[:]' '{print $2}' | xargs
#sample="ASIC: broadcom"

get_asic() {
    ASIC_NAME=`show platform summary | grep "ASIC:" | awk -F'[:]' '{print $2}' | xargs`
    if [[ x"$ASIC_NAME" == x"broadcom" ]]; then
        ASIC="brcm"
    elif [[ x"$ASIC_NAME" == x"mellanox" ]]; then
        ASIC="mlnx"
    elif [[ x"$ASIC_NAME" == x"barefoot" ]]; then
        ASIC="bfn"
    else
        echo "ASIC: $ASIC_NAME does not currently support by saitest"
        exit 1
    fi

    echo "Current ASIC is $ASIC"
}

get_os_version() {
    OS_VERSION=`sonic-cfggen -y /etc/sonic/sonic_version.yml -v build_version`
}

