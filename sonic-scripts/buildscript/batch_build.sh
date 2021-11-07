#!/bin/bash
. ./Utils.sh

helpFunction()
{
   echo ""
   echo "Usage: $0 -p [platform] -r [true|false|f|t]"
   echo -e "\t-t : Actual target name you want to build, omit the [target] folder string, for docker target, like [target/docker-saiserver-brcm.gz], when it enable the docker build with parameter -d, the target can be [saiserver], if other target, it same as the target in buildimage"
   echo -e "\t-p , If set, will make a configure, it can be:
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
   echo -e "\t-k : If set, will keep the slave after build"
   echo -e "\t-c : If set, will enable_rpc build"
   echo -e "\t-d : If set, will enable_rpc build"
   echo -e "\t-r : If reset platform. if set, then need password when running"
   echo -e "\t-f : If config platform."
   exit 1 # Exit script after printing help
}

while getopts "t:p:rkcdf" opt
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
      f ) 
        config="true" 
        ;;
      ? ) 
        helpFunction 
        ;; # Print helpFunction in case parameter is non-existent
   esac
done

env_param="NOSTRETCH=y NOJESSIE=y "
export NOSTRETCH=y
export NOJESSIE=y
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
    env_param+="KEEP_SLAVE_ON=yes "
    export KEEP_SLAVE_ON=yes
fi

if [ ! -z "$rpc" ]; then
    echo ENABLE_SYNCD_RPC: $rpc
    env_param+="ENABLE_SYNCD_RPC=y "
    export ENABLE_SYNCD_RPC=y
fi

#Construct the build_param
if [ ! -z "$platform" ]; then
    echo make a configure on platform: $platform
    get_asic_from_std "$platform"
    echo platform shorten name: $ASIC
fi

if [ ! -z "$docker" ]; then
    echo docker build: $docker
    build_param+="target/docker-$target-$ASIC"
    if [ "$target" == "syncd" ] && [ ! -z "$rpc" ]; then
        build_param+="-rpc"
    fi
    build_param+=".gz"
else
   build_param=$target
fi

echo $env_param make $build_param

#sart build process
if [ ! -z "$reset" ]; then
    echo make a reset: $reset
    make reset
    make init
    make PLATFORM=$platform configure
fi

if [ ! -z "$config" ]; then
    echo make configure: $config
    make PLATFORM=$platform configure
fi

make $build_param
#make target/docker-syncd-bfn-rpc.gz
#make target/docker-syncd-bfn.gz
#make target/docker-teamd.gz
#ENABLE_SYNCD_RPC=y NOSTRETCH=y KEEP_SLAVE_ON=yes make target/docker-saiserver-brcm.gz
