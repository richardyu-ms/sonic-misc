#!/bin/bash -x 
#DUT_NAME=str-7260cx3-acs-2
#DUT_NAME=str-s6100-acs-5
#DUT_NAME=str-7260cx3-acs-1
#DUT_NAME=str2-7050cx3-acs-01
#DUT_NAME=str-dx010-acs-4
#DUT_NAME=str2-7050cx3-acs-02
#DUT_NAME=str-s6000-acs-8
#DUT_NAME=str2-msn4600c-acs-01
#DUT_NAME=str-s6000-acs-13
#DUT_NAME=str2-7260cx3-acs-11
#DUT_NAME=str2-dx010-acs-6
#DUT_NAME=str-a7060cx-acs-10
#DUT_NAME=str2-7050cx3-acs-06
#DUT_NAME=str2-7050cx3-acs-08
#DUT_NAME=str2-7050cx3-acs-06,str2-7050cx3-acs-07
#DUT_NAME=str2-7050cx3-acs-08,str2-7050cx3-acs-09
#DUT_NAME=str2-7050cx3-acs-10,str2-7050cx3-acs-11
#DUT_NAME=str2-7060cx3-acs-11
#DUT_NAME=str2-dx010-acs-6
#DUT_NAME=str-msn4600c-acs-02
#DUT_NAME=str-msn2700-22
#DUT_NAME=str2-7050cx3-acs-03
#DUT_NAME=str2-sn3800-02
#TESTBED_NAME=vms7-t0-7260-2
#TESTBED_NAME=vms7-t1-s6100
#TESTBED_NAME=vms7-t0-7260-1
#TESTBED_NAME=vms20-t0-7050cx3-1
#TESTBED_NAME=vms7-t0-dx010-4
#TESTBED_NAME=vms20-t1-dx010-6
#TESTBED_NAME=vms6-t1-7060
#TESTBED_NAME=vms17-dual-t0-7050-1
#TESTBED_NAME=vms17-dual-t0-7050-2
#TESTBED_NAME=vms21-dual-t0-7050-3
#TESTBED_NAME=vms20-t1-dx010-6
#TESTBED_NAME=vms17-dual-t0-7050-1
#TESTBED_NAME=vms17-t0-7260-2
#TESTBED_NAME=vms20-t0-7050cx3-2
#TESTBED_NAME=vms12-t1-lag-1
#TESTBED_NAME=vms18-t1-msn4600c-acs-1
#TESTBED_NAME=vms21-dual-t0-7260
#TESTBED_NAME=vms2-4-t0-2700
#TESTBED_NAME=vms20-t1-7050cx3-3
#TESTBED_NAME=vms7-t0-4600c-2
#TESTBED_NAME=vms20-t0-sn3800-2
#TESTBED_NAME=vms12-t0-s6000-1
#TESTBED_NAME=vms13-t0-a7170
TESTBED_NAME=vms13-4-t0
#TESTBED_NAME=vms2-5-t0-7050-1


LOG_LEVEL=info

echo DUT: $DUT_NAME

JOB_NAME="pytest-${DUT_NAME}"
INVT="../ansible/str,../ansible/veos"
#MPATH="../ansible/library/"
MPATH="../ansible"
TESTBED_FILE="../ansible/testbed_sai.yaml"
export ANSIBLE_CONFIG=`pwd`/ansible

#cd ansible
echo $VAULT_PASSWORD > password.txt

# Download secrets.json from Azure Key Vault
#~/bin/az login --allow-no-subscriptions --service-principal -u $ApplicationID --password $ApplicationPassword --tenant 72f988bf-86f1-41af-91ab-2d7cd011db47
#~/bin/az keyvault secret download --vault-name 'SONiC' --name 'nm-secrets' --file ansible/group_vars/all/secrets.json
#md5sum ansible/group_vars/all/secrets.json
#ansible-vault view --vault-password-file=password.txt secrets.json > ansible/group_vars/all/secrets.json
#ansible-vault decrypt ansible/group_vars/all/secrets.json --vault-password-file=password.txt

export ANSIBLE_LIBRARY=`pwd`/ansible/library/
export export ANSIBLE_CONNECTION_PLUGINS=/data/sonic-mgmt/ansible/plugins/connection/
export ANSIBLE_KEEP_REMOTE_FILES=1
#export ANSIBLE_PIPELINING=False
#commong parameters (NO Longer needed after PR #1689:

#export PYTEST_ADDOPTS=' --pdb -vvv --allow_recover --disable_loganalyzer --skip_sanity --log-file logs/test.log --log-file-level debug'
export PYTEST_ADDOPTS='-vvvvv --pdb --allow_recover --skip_sanity --sai_test_dir=../SAI/test/saithrift/tests --sai_test_report_dir=./ --disable_loganalyzer '
export PYTEST_ADDOPTS+='--sai_test_container=syncd '
#export PYTEST_ADDOPTS+=' --py_saithrift_url=http://100.127.20.23/pipelines/Networking-acs-buildimage-Official/barefoot/internal/latest/target/debs/buster/python-saithrift_0.9.4_amd64.deb'
export PYTEST_ADDOPTS+=' --py_saithrift_url=http://100.127.20.23/pipelines/Networking-acs-buildimage-Official/broadcom/internal-202012/tagged/python-saithrift_0.9.4_amd64.deb'
cd tests
rm -rf _cache


#pytest saitests/test_sai_infra.py::test_ptf_setup --inventory ../ansible/str,../ansible/veos --host-pattern all --module-path ../ansible --testbed vms12-t0-s6000-1 --testbed_file ../ansible/testbed_sai.yaml --junit-xml=tr.xml --log-cli-level info --collect_techsupport=False --topology=ptf
#pytest saitests/test_sai_infra.py::test_ptf_setup --inventory ../ansible/str,../ansible/veos --host-pattern all --module-path ../ansible --testbed vms12-t0-s6000-1 --testbed_file ../ansible/testbed_sai.yaml --junit-xml=tr.xml --log-cli-level info --collect_techsupport=False --topology=ptf
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot"   pfcwd/test_pfcwd_warm_reboot.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='util'  -k "not test_fast_reboot" -m "posttest" test_posttest.py::test_recover_rsyslog_rate_limit
pytest sai_qualify/sai_infra.py::test_sai_from_ptf --inventory $INVT --host-pattern all --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='ptf'
#./run_tests.sh -n vms-kvm-t0 -d all -c saitests/test_sai_infra.py::test_ptf_setup -f testbed.csv -i str
#./run_tests.sh -n vms13-4-t0 -d vlab-01 -c bgp/test_bgp_fact.py -f vtestbed.csv -i veos_vtb
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  platform_tests/link_flap/test_link_flap.py::test_link_flap
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' dualtor/test_server_failure.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' drop_packets/test_drop_counters.py::test_equal_smac_dmac_drop
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" show_techsupport/test_techsupport.py::test_techsupport
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" iface_namingmode/test_iface_namingmode.py::TestShowQueue::test_show_queue_counters
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" show_techsupport/test_techsupport.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' crm/test_crm.py::test_crm_nexthop
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' pc/test_po_update.py::test_po_update
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' test_features.py::test_show_features
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' dualtor/test_standby_tor_upstream_mux_toggle.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' dualtor/test_standby_tor_downstream.py::test_standby_tor_downstream_loopback_route_removed
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' test_pretest.py::test_inject_y_cable_simulator_client
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' test_pretest.py::test_block_rsyslog_server
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' test_posttest.py::test_unblock_rsyslog_server
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  platform_tests/link_flap/test_link_flap.py::test_link_flap
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  pc/test_lag_2.py::test_lag
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' test_demo.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  dualtor/test_ipinip.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" dualtor/test_demo.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" dualtor/test_demo.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" fib/test_fib.py::test_basic_fib
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' fib
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" drop_packets
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" fib/test_fib.py::test_hash
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' decap/test_decap.py
#py.test -vvvvv --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' test_announce_routes.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' pc/test_po_cleanup.py::test_po_cleanup
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" nat/test_dynamic_nat.py::TestDynamicNat::test_nat_clear_statistics_dynamic
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  pc/test_lag_2.py::test_lag
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' platform_tests/cli/test_show_platform.py::test_show_platform_psustatus
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" test_demo.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" fib/test_fib.py::test_basic_fib
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t1,any,util'  -k "not test_fast_reboot" pfcwd/test_pfcwd_all_port_storm.py::TestPfcwdAllPortStorm::test_all_port_storm_restore
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  pc/test_lag_2.py::test_lag
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" sub_port_interfaces/test_sub_port_interfaces.py::TestSubPorts::test_packet_routed_with_invalid_vlan
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" vlan/test_vlan.py::test_vlan_tc2_send_tagged
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' test_pretest.py::test_update_testbed_metadata
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' crm/test_crm.py::test_crm_fdb_entry
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" bgp/test_bgp_speaker.py::test_bgp_speaker_announce_routes
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" autorestart/test_container_autorestart.py::test_containers_autorestart 
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  fdb/test_fdb.py
exit 0
#py.test -vvvvv --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' test_announce_routes.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  platform_tests/link_flap/test_link_flap.py::test_link_flap
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  pc/test_lag_2.py::test_lag
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' -m "pretest" test_pretest.py::test_update_testbed_metadata
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' acl/test_acl.py::TestAclWithPortToggle
while true
do
py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' vxlan/test_vxlan_decap.py
if [ $? -ne 0 ]
then
break
fi
done
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t1,any,util' platform_tests/api/test_fan_drawer_fans.py::TestFanDrawerFans::test_get_name
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t1,any,util' bgp/test_traffic_shift.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' -m "pretest" test_pretest.py::test_update_testbed_metadata
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' lldp/test_lldp.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' snmp/test_snmp_lldp.py::test_snmp_lldp
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' bgp/test_bgpmon.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' bgp/test_bgp_speaker.py::test_bgp_speaker_bgp_sessions
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" autorestart/test_container_autorestart.py::test_containers_autorestart 
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' qos/test_pfc_pause.py::test_no_pfc 
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' bgp/test_bgp_speaker.py::test_bgp_speaker_announce_routes
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" lldp/test_lldp.py::test_lldp_neighbor
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' platform_tests/cli/test_show_platform.py::test_show_platform_summary
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" iface_namingmode/test_iface_namingmode.py::TestShowInterfaces::test_show_interfaces_portchannel
exit 0
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' platform_tests/test_advanced_reboot.py::test_fast_reboot
#exit 0
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' bgp/test_bgp_speaker.py::test_bgp_speaker_announce_routes
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' route/test_route_perf.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='util'  -k "not test_fast_reboot" -m "pretest" test_pretest.py::test_disable_rsyslog_rate_limit
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='util'  -k "not test_fast_reboot" -m "posttest" test_posttest.py::test_recover_rsyslog_rate_limit
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" vlan/test_vlan.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" drop_packets/test_configurable_drop_counters.py::test_neighbor_link_down
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' arp/test_wr_arp.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' snmp/test_snmp_lldp.py::test_snmp_lldp

#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' platform_tests/test_advanced_reboot.py::test_warm_reboot_multi_sad_inboot
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' platform_tests/test_cont_warm_reboot.py::test_continuous_reboot
while true
do
py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' pc/test_po_update.py::test_po_update
if [ $? -ne 0 ]
then
break
fi
done
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' test_features.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' snmp/test_snmp_psu.py::test_snmp_psu_status
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' decap/test_decap.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' iface_namingmode/test_iface_namingmode.py::TestShowVlan::test_show_vlan_config
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' platform_tests/test_advanced_reboot.py::test_fast_reboot
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' platform_tests/test_advanced_reboot.py::test_warm_reboot
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' platform_tests/test_reboot.py::test_cold_reboot
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' platform_tests/test_advanced_reboot.py::test_warm_reboot
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' iface_namingmode/test_iface_namingmode.py::TestShowVlan::test_show_vlan_config
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' test_demo.py
#py.test -vvvvv --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' platform_tests/mellanox
#py.test -vvvvv --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' test_announce_routes.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' crm/test_crm.py::test_crm_route
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' crm/test_crm.py::test_acl_entry 
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' crm/test_crm.py::test_acl_entry crm/test_crm.py::test_acl_counter
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  platform_tests/test_link_flap.py::test_link_flap
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" vxlan/test_vxlan_decap.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" fib/test_fib.py::test_basic_fib
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" show_techsupport/test_techsupport.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" drop_packets/test_drop_counters.py
#py.test -vvv --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  arp/test_wr_arp.py
#sleep 10s
#py.test  --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util' bgp/test_bgp_speaker.py::test_bgp_speaker_announce_routes_v6
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE  --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'   iface_namingmode/test_iface_namingmode.py::TestShowLLDP::test_show_lldp_neighbor
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" testbed_setup/test_populate_fdb.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" test_interfaces.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --collect_techsupport=False --topology='t0,any,util'  -k "not test_fast_reboot" fib/test_fib.py
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL}   -k "not test_fast_reboot" test_bgp_speaker.py
#py.test upgrade_path/test_upgrade_path.py --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --base_image_list="http://100.127.20.23/installer/sonic/broadcom/internal-201811/sonic-aboot-broadcom-20181130.51.swi" --target_image_list="http://100.127.20.23/installer/sonic/broadcom/internal-201811/sonic-aboot-broadcom.swi" --restore_to_image="http://100.127.20.23/installer/sonic/broadcom/internal-201911/sonic-aboot-broadcom.swi"
#py.test upgrade_path/test_upgrade_path.py --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --base_image_list="http://100.127.20.23/installer/sonic/broadcom/internal-201811/sonic-aboot-broadcom-20181130.51.swi,http://100.127.20.23/installer/sonic/broadcom/internal-201811/sonic-aboot-broadcom-20181130.70.swi" --target_image_list="http://100.127.20.23/installer/sonic/broadcom/internal-201811/sonic-aboot-broadcom.swi" --restore_to_image="http://100.127.20.23/installer/sonic/broadcom/internal-201911/sonic-aboot-broadcom.swi"
#py.test  --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --base_image_list="http://100.127.20.23/installer/sonic/broadcom/internal-201811/sonic-aboot-broadcom-20181130.51.swi" -k "not test_restart_syncd"  upgrade_path/test_upgrade_path.py
#py.test  --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --base_image_list="http://100.127.20.23/installer/sonic/broadcom/internal-201811/sonic-aboot-broadcom-20181130.51.swi" --target_image_list="http://100.127.20.23/installer/sonic/broadcom/internal-201811/sonic-aboot-broadcom-20181130.70.swi,http://100.127.20.23/installer/sonic/broadcom/internal-201911/sonic-aboot-broadcom.swi" -k "not test_restart_syncd"  upgrade_path/test_upgrade_path.py

#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL}  -k "not test_restart_syncd" --topology t0,any --show-capture=no  platform_tests/broadcom
#py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL}  -k "not test_restart_syncd" --topology t0,any --show-capture=no  pfcwd/test_pfc_config.py
#/py.test --inventory $INVT --host-pattern $DUT_NAME --module-path $MPATH --testbed $TESTBED_NAME --testbed_file $TESTBED_FILE --junit-xml=tr.xml --log-cli-level ${LOG_LEVEL} --log-file-level=debug --log-file=logs/test.log  -k "not test_restart_syncd" --topology any --show-capture=no arp/test_neighbor_mac_noptf.py
