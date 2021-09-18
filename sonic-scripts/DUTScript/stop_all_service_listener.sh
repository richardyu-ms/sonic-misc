#!/bin/bash -x 

docker exec swss supervisorctl stop supervisor-proc-exit-listener
docker exec syncd supervisorctl stop supervisor-proc-exit-listener
docker exec radv supervisorctl stop supervisor-proc-exit-listener
docker exec lldp supervisorctl stop supervisor-proc-exit-listener
docker exec dhcp_relay supervisorctl stop supervisor-proc-exit-listener
docker exec teamd supervisorctl stop supervisor-proc-exit-listener
docker exec bgp supervisorctl stop supervisor-proc-exit-listener
docker exec pmon supervisorctl stop supervisor-proc-exit-listener
docker exec telemetry supervisorctl stop supervisor-proc-exit-listener
docker exec acms supervisorctl stop supervisor-proc-exit-listener
docker exec snmp supervisorctl stop supervisor-proc-exit-listener
docker exec radv supervisorctl stop supervisor-proc-exit-listener

