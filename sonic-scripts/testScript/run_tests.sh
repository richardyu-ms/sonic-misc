#!/bin/bash -x 

DUT_NAME=[dutName]
TESTBED_NAME=[testbedName]

LOG_LEVEL=info

echo DUT: $DUT_NAME

JOB_NAME="pytest-${DUT_NAME}"
INVT="../ansible/str2,../ansible/veos"
#MPATH="../ansible/library/"
MPATH="../ansible"
TESTBED_FILE="../ansible/testbed.csv"
export ANSIBLE_CONFIG=`pwd`/ansible

#cd ansible
echo $VAULT_PASSWORD > password.txt


export ANSIBLE_LIBRARY=`pwd`/ansible/library/
export export ANSIBLE_CONNECTION_PLUGINS=/data/sonic-mgmt/ansible/plugins/connection/
export ANSIBLE_KEEP_REMOTE_FILES=1
#export ANSIBLE_PIPELINING=False

#export PYTEST_ADDOPTS=' --pdb -vvv --allow_recover --disable_loganalyzer --skip_sanity --log-file logs/test.log --log-file-level debug'
export PYTEST_ADDOPTS='-vvvvv --pdb --allow_recover --skip_sanity'
cd tests
rm -rf _cache

py.test saitests/test_sai_infra.py::test_ptf_setup --inventory $INVT --host-pattern all --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  pc/test_lag_2.py::test_lag
