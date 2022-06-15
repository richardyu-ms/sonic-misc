#!/usr/bin/python

from ptf import testutils
import ptf.packet as scapy

import pdb

MAC_06 = 'd4:af:f7:4d:a4:44'
MAC_07 = 'd4:af:f7:4d:af:18'
MAC_08 = 'd4:af:f7:4d:a5:4c'
IP_06 = IP_08 = '10.1.0.32'

MAC_09 = 'd4:af:f7:4d:a8:64'
IP_07 = IP_09 = '10.1.0.33'

IP_SERVER = '192.168.0.2'
IP_SERVER_V6 = 'fc02:1000::2'

IP_DUMMY = '1.1.1.1'
IP_DUMMY_V6 = 'fcc1:1000::1'

MAC_DUMMY = '00:06:07:08:09:0a'

inner_pkt=testutils.simple_ip_only_packet(ip_dst=IP_SERVER, ip_src=IP_DUMMY, ip_ttl=63, ip_dscp=3, ip_tos=1)
inner_pkt_v6 = testutils.simple_tcpv6_packet(ipv6_dst=IP_SERVER_V6, ipv6_src=IP_DUMMY_V6, ipv6_dscp=3).getlayer(scapy.IPv6)
pkt_tunnel=testutils.simple_ipv4ip_packet(eth_dst=MAC_08, eth_src=MAC_DUMMY, ip_src=IP_09, ip_dst=IP_08, ip_dscp=2, ip_tos=1, ip_ttl=63, inner_frame=inner_pkt)

pkt = testutils.simple_tcp_packet(eth_dst=MAC_06, eth_src=MAC_DUMMY, ip_src=IP_DUMMY, ip_dst=IP_SERVER)
pdb.set_trace()

#Encap on standby tor
#Run the following script and check the result
#If 09 is the standby 08 is active
#dec=32 0x20 -> 20  active: eth 100->0 tos 0x20
pkt = testutils.simple_tcp_packet(eth_dst=MAC_08, eth_src=MAC_DUMMY, ip_src=IP_DUMMY, ip_dst=IP_SERVER, ip_tos=32)
#dec=0 0x0 -> 0 active: eth 100->0 tos 0x0
pkt = testutils.simple_tcp_packet(eth_dst=MAC_08, eth_src=MAC_DUMMY, ip_src=IP_DUMMY, ip_dst=IP_SERVER, ip_tos=0)
#dec=132 0x84 -> 84 active: eth 100->0 tos 0x84
pkt = testutils.simple_tcp_packet(eth_dst=MAC_08, eth_src=MAC_DUMMY, ip_src=IP_DUMMY, ip_dst=IP_SERVER, ip_tos=132)
#dec=12 0xc -> 0xc active: eth 100->0 tos 0xc
pkt = testutils.simple_tcp_packet(eth_dst=MAC_08, eth_src=MAC_DUMMY, ip_src=IP_DUMMY, ip_dst=IP_SERVER, ip_tos=12)
#dec=16 0x10 -> 0x10 active: eth 100->0 tos 0x10
pkt = testutils.simple_tcp_packet(eth_dst=MAC_08, eth_src=MAC_DUMMY, ip_src=IP_DUMMY, ip_dst=IP_SERVER, ip_tos=16)
#dec=184 0xb8 -> 0xb8 active: eth 100->0 tos 0xb8
pkt = testutils.simple_tcp_packet(eth_dst=MAC_08, eth_src=MAC_DUMMY, ip_src=IP_DUMMY, ip_dst=IP_SERVER, ip_tos=184)
#dec=192 0xc0 -> 0c0 active: eth 100->0 tos 0xc0
pkt = testutils.simple_tcp_packet(eth_dst=MAC_08, eth_src=MAC_DUMMY, ip_src=IP_DUMMY, ip_dst=IP_SERVER, ip_tos=192)

#Send packet 
sendp(pkt, iface='eth58', count=1000)
#Check the port forwarding
#clear at first
#portstat -c 
#portstat
#For standby go to the PTF server and capture the packet
sendp(pkt, iface='eth58', count=10)

sendp(pkt, iface='eth60', count=10)

pkt = testutils.simple_tcp_packet(eth_dst=MAC_08, eth_src=MAC_DUMMY, ip_src=IP_DUMMY, ip_dst=IP_SERVER, ip_dscp=2, ip_ecn=1)

inner_pkt=testutils.simple_ip_only_packet(ip_dst=IP_SERVER, ip_src=IP_DUMMY, ip_ttl=63, ip_tos=13)
pkt_tunnel=testutils.simple_ipv4ip_packet(eth_dst=MAC_08, eth_src=MAC_DUMMY, ip_src=IP_08, ip_dst=IP_09, ip_tos=32, ip_ttl=63, inner_frame=inner_pkt)
sendp(pkt_tunnel, iface='eth60', count=10)

pkt = testutils.simple_tcp_packet(eth_dst=MAC_08, eth_src=MAC_DUMMY, ip_dst=IP_SERVER, ip_src=IP_DUMMY, ip_dscp=3, ip_ecn=1, ip_ttl=63)