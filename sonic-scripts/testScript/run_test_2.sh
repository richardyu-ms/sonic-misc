#!/bin/bash -x 
TESTBED_NAME="vms24-t0-7260-2"

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
export export ANSIBLE_CONNECTION_PLUGINS=/data/sonic-mgmt/ansible/plugins/connection/
export ANSIBLE_KEEP_REMOTE_FILES=1
#export ANSIBLE_PIPELINING=False

#export PYTEST_ADDOPTS=' --pdb -vvv --allow_recover --disable_loganalyzer --skip_sanity --log-file logs/test.log --log-file-level debug'
export PYTEST_ADDOPTS='-vvvvv --allow_recover --skip_sanity'
cd tests
rm -rf _cache

#pytest fib/test_fib.py --inventory $INVT --host-pattern all --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' 

#pytest vxlan/test_vxlan_decap.py --inventory $INVT --host-pattern all --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' 

#pytest fdb/test_fdb.py --inventory $INVT --host-pattern all --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' 

pytest decap/test_decap.py --inventory $INVT --host-pattern all --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' 

#pytest pfcwd/test_pfcwd_all_port_storm.py --inventory $INVT --host-pattern all --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' 

#pytest drop_packets/test_configurable_drop_counters.py --inventory $INVT --host-pattern all --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' 

#pytest ipfwd/test_dip_sip.py --inventory $INVT --host-pattern all --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' 

#pytest ipfwd/test_dir_bcast.py --inventory $INVT --host-pattern all --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' 

#pytest vlan/test_vlan.py --inventory $INVT --host-pattern all --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' 

#pytest platform_tests/test_reboot.py --inventory $INVT --host-pattern all --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' 

# pytest sai_qualify/sai_infra.py::test_warm_boot_from_ptf --inventory $INVT --host-pattern all --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='ptf'

#py.test saitests/test_sai_infra.py::test_ptf_setup --inventory $INVT --host-pattern all --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  pc/test_lag_2.py::test_lag

#py.test upgrade_path/test_upgrade_path.py::test_upgrade_path --inventory $INVT --host-pattern all --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' --base_image_list=http://100.127.20.23/installer/sonic/broadcom/internal-201811/sonic-broadcom-20181130.95.bin --target_image_list=http://100.127.20.23/installer/sonic/yinxi/warmboot/sonic-broadcom.bin

#py.test upgrade_path/test_upgrade_path.py::test_upgrade_path --inventory "../ansible/str,../ansible/veos" --host-pattern all --module-path "../ansible" --testbed vms7-t0-s6100 --testbed_file "../ansible/testbed.csv" --junit-xml=tr.xml --log-cli-level info --collect_techsupport=False --topology='t0,any,util' --base_image_list=http://100.127.20.23/installer/sonic/broadcom/internal-201811/sonic-broadcom-20181130.95.bin --target_image_list=http://100.127.20.23/installer/sonic/yinxi/warmboot/sonic-broadcom.bin

#py.test metadata-scripts/test_metadata_upgrade_path.py::test_upgrade_path --inventory $INVT --host-pattern all --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' --base_image_list=http://100.127.20.23/installer/sonic/broadcom/internal-201811/sonic-broadcom-20181130.95.bin --target_image_list=http://100.127.20.23/installer/sonic/yinxi/warmboot/sonic-broadcom.bin --upgrade_type=warm --metadata_process --tcam_hole

#./run_tests.sh -n ${DUT_NAME} -i $INVT -m individual -l ${LOG_LEVEL} -e '--showlocals --assert plain -rav --upgrade_type=warm --skip_sanity --base_image_list=http://100.127.20.23/installer/sonic/broadcom/internal-201811/sonic-broadcom-20181130.95.bin --target_image_list=http://100.127.20.23/installer/sonic/yinxi/warmboot/sonic-broadcom.bin --metadata_process --tcam_hole' -u -c metadata-scripts/test_metadata_upgrade_path.py::test_upgrade_path

#./run_tests.sh -n $TESTBED_NAME -i $INVT -m individual -l ${LOG_LEVEL} -e '--showlocals --assert plain -rav --upgrade_type=warm --skip_sanity --base_image_list=http://100.127.20.23/pipelines/Networking-acs-buildimage-Official/broadcom/internal-201811/sonic-broadcom.bin --target_image_list=http://100.127.20.23/pipelines/Networking-acs-buildimage-Official/broadcom/internal-202012/sonic-broadcom-dbg.bin --metadata_process  --tcam_hole' -u -c metadata-scripts/test_metadata_upgrade_path.py::test_upgrade_path

#./run_tests.sh -n $TESTBED_NAME -i $INVT -m individual -l ${LOG_LEVEL} -e '--showlocals --assert plain -rav --upgrade_type=warm --skip_sanity --base_image_list=http://100.127.20.23/pipelines/Networking-acs-buildimage-Official/broadcom/internal-202012/sonic-broadcom.bin --target_image_list=http://100.127.20.23/pipelines/Networking-acs-buildimage-Official/broadcom/internal-202012/sonic-broadcom-dbg.bin --metadata_process' -u -c metadata-scripts/test_metadata_upgrade_path.py::test_upgrade_path
