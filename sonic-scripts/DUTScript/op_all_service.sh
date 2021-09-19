#!/bin/bash

#Services can be started, they must be in order
services=("swss" "syncd" "radv" "lldp" "dhcp_relay" "teamd" "bgp" "pmon" "telemetry" "acms" "snmp")
op_service(){
    for serv in ${services[*]}; do
        if [[ x"$skip" =~ x"$serv" ]]; then
            echo "Skip [$op] for service [$serv]."
        else
            echo "systemctl $op $serv"
        fi
    done
}

check_ops() {
    # Print helpFunction in case parameters are empty
    if [ -z "$op" ]; then
        echo "Some or all of the parameters are empty";
        helpFunction
    fi

    if [[ x"$op" != x"start" && x"$op" != x"stop" ]]; then
        echo ""
        echo "Error: Operation perameters is not right, it only can be [stop|start].";
        helpFunction
    fi
}


helpFunction()
{
   echo ""
   echo "Use to operation on services list:"
   echo  ${services[*]}
   echo -e "\t-o|-operation [start|stop] : start or stop"
   echo -e "\t-s|-skip [service name] : the service names in the services list. It can be like [swss;syncd]"
   
   exit 1 # Exit script after printing help
}

while getopts ":o:operation:s:skip" args; do
    case $args in
        o|operation)
            op=${OPTARG} 
            ;;
        s|skip)
            skip=${OPTARG} 
            ;;
        *)
            helpFunction
        ;;
    esac
done

check_ops
op_service 