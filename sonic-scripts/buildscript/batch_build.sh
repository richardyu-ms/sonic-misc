#!/bin/bash
. ../Utils.sh

helpFunction()
{
   echo ""
   echo "Usage: $0 -p [platform] -r [true|false|f|t]"
   echo -e "\t-t [target] : Actual target name you want to build, omit the [target] folder string"
   echo -e "\t-p [Platform], If set, will make a configure, it can be:
         \t barefoot
         \t broadcom
         \t marvell
         \t mellanox
         \t cavium
         \t centec
         \t nephos
         \t innovium
         \t p4
         \t vs"
   echo -e "\t-k [enable_keep_slave], If set, will keep the slave after build"
   echo -e "\t-c [enable_rpc], If set, will enable_rpc build"
   echo -e "\t-d [enable_docker_build], If set, will enable_rpc build"
   echo -e "\t-r [reset] : If reset platform. if set, then need password when running"
   exit 1 # Exit script after printing help
}

while getopts "t:p:rkcd" opt
do
   case "$opt" in
      p ) 
        platform=${OPTARG} 
        ;; 
      t )
        target=${OPTARG} 
        ;; 
      r )
        reset="true"
        ;;
      k ) 
        keep="true"
        ;;
      c ) 
        rpc="true" 
        ;;
      d ) 
        docker="true" 
        ;;
      ? ) 
        helpFunction 
        ;; # Print helpFunction in case parameter is non-existent
   esac
done

env_param="NOSTRETCH=y NOJESSIE=y "
build_param=""

# Print helpFunction in case parameters are empty
if [ -z "$target" ] || [ -z "$platform" ]
then
   echo "Targe and platform must be set.";
   helpFunction
fi

#Construct the env_param
if [ ! -z "$keep" ]; then
    echo keep slave build: $keep
    env_param+="KEEP_SLAVE_ON=y "
fi

if [ ! -z "$rpc" ]; then
    echo ENABLE_SYNCD_RPC: $rpc
    env_param+="ENABLE_SYNCD_RPC=y "
fi

#Construct the build_param
if [ ! -z "$platform" ]; then
    echo make a configure on platform: $platform
    get_asic_from_std "$platform"
    echo platform shorten name: $ASIC
    #make PLATFORM=$platform configure
fi

if [ ! -z "$docker" ]; then
    echo keep slave build: $keep
    build_param+="target/docker-$target-$ASIC"
    if [ "$target" == "syncd" ] && [ ! -z "$rpc" ]; then
        build_param+="-rpc"
    fi
    build_param+=".gz"
else
   build_param=$target
fi

echo 

#sart build process
if [ ! -z x"$reset" ]; then
    echo make a configure reset: $reset
    #make reset
fi

echo $env_param make $build_param
$env_param make $build_param
#make target/docker-syncd-bfn-rpc.gz
#make target/docker-syncd-bfn.gz
#make target/docker-teamd.gz
#ENABLE_SYNCD_RPC=y NOSTRETCH=y KEEP_SLAVE_ON=yes make target/docker-saiserver-brcm.gz
