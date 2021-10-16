#!/bin/bash

./all_service.sh -o stop

cp ./saiserver.sh /usr/bin/
chmod +x /usr/bin/saiserver.sh
/usr/bin/saiserver.sh start

echo "Start sai server with:"
echo -e "\t/usr/bin/start.sh"
echo -e "\t/usr/sbin/saiserver -p /usr/share/sonic/hwsku/sai.profile -f /usr/share/sonic/hwsku/port_config.ini"
