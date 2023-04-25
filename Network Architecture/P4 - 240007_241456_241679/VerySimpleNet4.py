from mininet.net import Mininet
from mininet.node import RemoteController, OVSSwitch
from mininet.cli import CLI
from mininet.log import setLogLevel, info
import sys
 
Sw = 1 # number of switches
Nps = 3 # number of nodes per switch
 
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
    node_counter = 0
    for s in switches.keys():
        nodes.setdefault(s, [])
        for n in range(Nps):
            key = "h%s" % (node_counter)
            node = net.addHost(name=key)
            nodes[s].append(node)
            info ("\t*** Created Node: %s\n" % key)
            node_counter += 1
 
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
 
    info( "*** Testing network\n")
    net.pingAll()
 
    info( "*** Running CLI\n")
    CLI( net )
 
    info( "*** Stopping network\n")
    net.stop()
 
if __name__ == '__main__':
    setLogLevel( 'info' )  # for CLI output
    Mininet.init()
    controller_ip = "127.0.0.1"
    mySDNExample(controller_ip)
