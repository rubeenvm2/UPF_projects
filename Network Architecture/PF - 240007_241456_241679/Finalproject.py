#!/usr/bin/python                                                                            
                                                              
from mininet.topo import Topo
from mininet.net import Mininet
from mininet.cli import CLI
from mininet.log import setLogLevel, info
from scapy.all import Ether, ARP, srp, send, sniff, conf
from mininet.node import RemoteController, OVSSwitch
import sys
Sw = 1
								
def mySDNExample(cip):
    net = Mininet( controller=RemoteController, switch=OVSSwitch )
 
    info( "*** Creating controller, IP: %s\n" % cip)
    c0 = net.addController( name='c0', ip=cip, port=6633 )
 
    info( "*** Creating switches\n")
    switches = {}
    for s in range(Sw):
        key = "s%s" % s
        sw = net.addSwitch(name=key, cls=OVSSwitch)
        switches.setdefault(key, sw)
        info ("\t*** Created Switch: %s\n" % key)
 
    info( "*** Creating nodes\n" )
    nodes = {}
    
    for s in switches.keys():
        nodes.setdefault(s, [])
        victim1 = net.addHost(name='victim1', ip = '192.168.1.2/24', mac = '5a:a5:20:68:17:f4')
        nodes[s].append(victim1)
        victim2 = net.addHost(name='victim2', ip = '192.168.1.3/24', mac = '3a:c0:b7:d2:32:8d')
        nodes[s].append(victim2)
        attacker = net.addHost(name='attacker', ip = '192.168.1.4/24', mac = '46:bd:1c:46:ef:13')
        nodes[s].append(attacker)
         
    info( "*** Creating links between host a Switch\n")
    for ks,s in switches.items():
        for h in nodes[ks]:
            net.addLink(s, h)
            info( "\t*** Creating links: %s-%s\n" % (ks,h.name))
 
    info( "*** Starting network\n")
    net.build()
    c0.start()
    for k,v in switches.items():
        v.start([ c0 ])

    info( "*** Running CLI\n")
    CLI( net )
 
    info( "*** Stopping network\n")
    net.stop()
 

if __name__ == '__main__':
    # Tell mininet to print useful information
    setLogLevel('info')
    #simpleTest()
    Mininet.init()
    controller_ip = "127.0.0.1"
    mySDNExample(controller_ip)
    
    
