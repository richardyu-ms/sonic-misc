#!/bin/bash -x 

systemctl stop swss
systemctl stop syncd
systemctl stop radv
systemctl stop lldp
systemctl stop dhcp_relay
systemctl stop teamd
systemctl stop bgp
systemctl stop pmon
systemctl stop telemetry
systemctl stop acms

cp ./saiserver.sh /usr/bin/
chmod +x /usr/bin/saiserver.sh
/usr/bin/saiserver.sh start
