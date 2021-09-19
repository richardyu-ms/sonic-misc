#!/bin/bash


save_docker() {
    docker commit $docker_name $target_docker_name

    docker create --privileged -p $port:22 --user root -v /code:/data -w /data --name=$docker_instance -it $target_docker_name bash
    docker start $docker_instance

    docker exec $docker_instance sudo apt install openssh-server
    docker exec $docker_instance sudo adduser $user
    docker exec $docker_instance sudo usermod -aG sudo $user
    docker exec $docker_instance sudo mkdir /home/$user
    docker exec $docker_instance sudo mkdir /home/$user/.ssh
    docker exec $docker_instance sudo usermod --shell /bin/bash --home /home/$user $user
    docker exec $docker_instance sudo chown -R $user:$user /home/$user
    docker exec $docker_instance sudo cp -r /etc/skel/.* /home/$user/
    docker exec $docker_instance sudo mkdir /home/$user/.ssh
    docker cp ~/.ssh/authorized_keys $docker_instance:/home/$user/.ssh/
    docker exec $docker_instance sudo service ssh start
    echo "Login to docker to set password:"
    echo "\tdocker exec -it $docker_instance bash"
    echo "\tpasswd $user"
}

check_ops() {
    # Print helpFunction in case parameters are empty
    if [ -z "$docker_name" ] && [ -z "$target_docker_name" ] && [ -z "$docker_instance" ] && [ -z "$user" ] && [ -z "$port" ]; then
        echo "Some or all of the parameters are empty";
        helpFunction
    fi
}


helpFunction()
{
   echo ""
   echo "Use the store the build container to a local container."
   echo "Include:"
   echo "\t1.Store Target docker."
   echo "\t2.Install openssh."
   echo "\t3.Create user (need to input password)."
   echo  ${containers[*]}
   echo -e "\t-b\t: Name of the builder container, it is the running container from the buildimage repo."
   echo -e "\t\t\t  You can always get it with parameters like:"
   echo -e "\t\t\t  KEEP_SLAVE_ON=yes"
   echo -e "\t\t\t  For build the saithrift, You can use: "
   echo -e "\t\t\t  ENABLE_SYNCD_RPC=y NOSTRETCH=y KEEP_SLAVE_ON=yes make target/debs/buster/libsaithrift-dev_0.9.4_amd64.deb"
   echo -e "\t-t\t: The target container name you want to set."
   echo -e "\t-i\t: The container instance name."
   echo -e "\t-u\t: User for ssh."
   echo -e "\t-p\t: Port for ssh."
   
   exit 1 # Exit script after printing help
}

while getopts "b:t:i:u:p:" opt; do
   case $opt in
      b) 
      echo "b ${OPTARG}"
        docker_name=${OPTARG} 
        ;; 
      t) 
      echo "t ${OPTARG}"
        target_docker_name=${OPTARG} 
        ;;
      i) 
        echo "i ${OPTARG}"
        docker_instance=${OPTARG} 
        ;;
      u) 
      echo "u ${OPTARG}"
        user=${OPTARG} 
        ;;
      p) 
      echo "p ${OPTARG}"
        port=${OPTARG} 
        ;;
      *) 
        helpFunction 
        ;; # Print helpFunction in case parameter is non-existent
   esac
done

check_ops
save_docker