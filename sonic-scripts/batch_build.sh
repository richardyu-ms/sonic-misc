#!/bin/bash -x

helpFunction()
{
   echo ""
   echo "Usage: $0 -p [platform] -r [true|false|f|t]"
   echo -e "\t-r [true|false] : If reset, need password when running"
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
   
   exit 1 # Exit script after printing help
}

while getopts ":r:p:" opt
do
   case "$opt" in
      p ) 
        platform=${OPTARG} 
        ;; 
      r ) 
        reset=${OPTARG} 
        ;;
      ? ) 
        helpFunction 
        ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$platform" ] && [ -z "$reset" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

# Begin script in case all parameters are correct
if [ ! -z "$reset" ]; then
    #echo make a configure reset: $reset
    make reset
fi

if [ ! -z "$platform" ]; then
    #echo make a configure on platform: $platform
    make PLATFORM=$platform configure
fi

#make target/docker-syncd-bfn.gz
#make target/docker-teamd.gz
make target/docker-saiserver-bfn.gz
