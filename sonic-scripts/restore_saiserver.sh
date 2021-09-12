#!/bin/bash -x 

docker stop saiserver
docker rm saiserver
config reload -y
