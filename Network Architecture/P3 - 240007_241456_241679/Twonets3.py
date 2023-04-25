#!/usr/bin/python

from mininet.net import Mininet
from mininet.node import Controller, RemoteController, OVSController
from mininet.node import CPULimitedHost, Host, Node
from mininet.node import OVSKernelSwitch, UserSwitch
from mininet.node import IVSSwitch
from mininet.cli import CLI
from mininet.log import setLogLevel, info
from mininet.link import TCLink, Intf
from subprocess import call

def myNetwork():

    net = Mininet( topo=None,
                   build=False,
                   ipBase='10.0.0.0/8')

    info( '*** Adding controller\n' )
    info( '*** Add switches\n')
    s4 = net.addSwitch('s4', cls=OVSKernelSwitch, failMode='standalone')
    s2 = net.addSwitch('s2', cls=OVSKernelSwitch, failMode='standalone')
    r1 = net.addHost('r1', cls=Node, ip='0.0.0.0')
    r1.cmd('sysctl -w net.ipv4.ip_forward=1')
    r3 = net.addHost('r3', cls=Node, ip='0.0.0.0')
    r3.cmd('sysctl -w net.ipv4.ip_forward=1')

    info( '*** Add hosts\n')
    h2 = net.addHost('h2', cls=Host, ip='192.168.1.3/24', defaultRoute='via 192.168.1.1')
    h6 = net.addHost('h6', cls=Host, ip='192.168.2.4/24', defaultRoute='via 192.168.2.1')
    h3 = net.addHost('h3', cls=Host, ip='192.168.1.4/24', defaultRoute='via 192.168.1.1')
    h5 = net.addHost('h5', cls=Host, ip='192.168.2.3/24', defaultRoute='via 192.168.2.1')
    h4 = net.addHost('h4', cls=Host, ip='192.168.2.2/24', defaultRoute='via 192.168.2.1')
    h1 = net.addHost('h1', cls=Host, ip='192.168.1.2/24', defaultRoute='via 192.168.1.1')

    info( '*** Add links\n')
    net.addLink(r1, s2)
    net.addLink(r1, r3)
    net.addLink(r3, s4)
    net.addLink(s4, h6)
    net.addLink(s4, h5)
    net.addLink(s4, h4)
    net.addLink(s2, h3)
    net.addLink(s2, h2)
    net.addLink(s2, h1)

    info( '*** Starting network\n')
    net.build()
    info( '*** Starting controllers\n')
    for controller in net.controllers:
        controller.start()

    info( '*** Starting switches\n')
    net.get('s4').start([])
    net.get('s2').start([])

    info( '*** Post configure switches and hosts\n')
    net.get('r1').cmd('ifconfig r1-eth0 192.168.1.1 netmask 255.255.255.0')
    net.get('r1').cmd('ifconfig r1-eth1 10.10.10.1 netmask 255.255.255.252')
    net.get('r3').cmd('ifconfig r3-eth0 10.10.10.2 netmask 255.255.255.252')
    net.get('r3').cmd('ifconfig r3-eth1 192.168.2.1 netmask 255.255.255.0')
    net.pingAll()
    CLI(net)
    net.stop()

if __name__ == '__main__':
    setLogLevel( 'info' )
    myNetwork()

