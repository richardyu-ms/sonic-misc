# DUT Script

## pull_saiserver_syncd_rpc_dockers.sh

This script will pull the saiserver and syncd_rpc docker to your local docker registry.
After the pull, it will tag the image as a local image, for example for broadcom platform they will be
docker-saiserver-brcm
docker-syncd-brcm-rpc
the origin one can be in format like
acs-repo.corp.microsoft.com:5001/docker-saiserver-brcm:master.39085-dirty-20210923.145659

*Please note, the pull process will depends on the OS version and shorten ASIC name, that means the docker with the OS version number and the asic name must be published to docker registry at first. It they are not publish, you need to pull them down manually.*

