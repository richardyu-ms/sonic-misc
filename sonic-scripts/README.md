# sonic-script
In this folder, there are kinds of scripts

- buildscript

    some script for building, it can help make the target in the sonic-buildimage repo, the shell can be used as a short cut to run the make command with some parameters. Also can be used as a place to get know what's the parameters can be used.

- DUTScript

    Script can be used in DUT, like stop, start all the service and listeners. Pull the saiserver or syncd-rpc docker base on the OS version and asic type. start the docker and restore the environment.

- testScript
    
    some scripts which can be used in the sonic-mgmt repo, help run the pytest cases with some common env parameters.
