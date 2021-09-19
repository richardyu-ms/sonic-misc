#!/bin/bash

./op_all_containers.sh -o start

cp ./saiserver.sh /usr/bin/
chmod +x /usr/bin/saiserver.sh
/usr/bin/saiserver.sh start
