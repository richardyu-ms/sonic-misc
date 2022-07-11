#!/bin/bash -x 
TESTBED_NAME="vms20-t1-dx010-6"

LOG_LEVEL=info

INVT_NAME="str2"

INVT="../ansible/${INVT_NAME},../ansible/veos"
#MPATH="../ansible/library/"
MPATH="../ansible"
TESTBED_FILE="../ansible/testbed.yaml"
export ANSIBLE_CONFIG=`pwd`/ansible

#cd ansible
echo $VAULT_PASSWORD > password.txt


export ANSIBLE_LIBRARY=`pwd`/ansible/library/
export ANSIBLE_CONNECTION_PLUGINS=/data/sonic-mgmt/ansible/plugins/connection/
export ANSIBLE_KEEP_REMOTE_FILES=1

#export PYTEST_ADDOPTS=' --pdb -vvv --allow_recover --disable_loganalyzer --skip_sanity --log-file logs/test.log --log-file-level debug'
export PYTEST_ADDOPTS='-vvvvv --pdb --allow_recover --skip_sanity --sai_test_dir=../SAI/test/sai_test --disable_loganalyzer '
#export PYTEST_ADDOPTS+='--sai_test_container=saiserver '
export PYTEST_ADDOPTS+=' --py_saithrift_url=http://100.127.20.23/pipelines/Networking-acs-buildimage-Official/broadcom/internal-202012/tagged/python-saithriftv2_0.9.4_amd64.deb'
export PYTEST_ADDOPTS+=' --sai_test_keep_test_env'
#export PYTEST_ADDOPTS+=' --enable_warmboot_test'
#export PYTEST_ADDOPTS+=' --enable_ptf_sai_test'
export PYTEST_ADDOPTS+=' --sai_port_config=dx010-port_config.ini'
export PYTEST_ADDOPTS+=' --enable_sai_test'
cd tests
rm -rf _cache

#pytest --collect-only --inventory $INVT --host-pattern all --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE 

#pytest sai_qualify/sai_infra.py::test_sai_from_ptf --inventory $INVT --host-pattern all --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='ptf'

pytest sai_qualify/test_brcm_t0.py::test_sai --inventory $INVT --host-pattern all --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='ptf'

#pytest sai_qualify/test_warm_reboot.py::test_sai --inventory $INVT --host-pattern all --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='ptf'

#pytest sai_qualify/test_sai_ptf.py::test_sai --inventory $INVT --host-pattern all --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='ptf'

#pytest sai_qualify/sai_infra.py::test_sai_from_ptf --inventory $INVT --host-pattern all --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='ptf'