#!/usr/bin/python                                                                            
                                                                                             
from mininet.topo import Topo
from mininet.net import Mininet
from mininet.util import dumpNodeConnections
from mininet.log import setLogLevel
from mininet.link import TCLink
from time import sleep

class SingleSwitchTopo(Topo):
    "Single switch connected to n hosts."
    def build(self, n=2):
		switch = self.addSwitch('s1')
		# Python's range(N) generates 0..N-1
		host1 = self.addHost('host1', ip = '192.168.1.1/24')
		self.addLink(host1, switch, bw = 10)            
		host2 = self.addHost('host2', ip = '192.168.1.2/24')
		self.addLink(host2, switch, bw = 1)            
		host3 = self.addHost('host3', ip = '192.168.1.3/24')                
		self.addLink(host3, switch, bw = 100)

def simpleTest():
    "Create and test a simple network"
    topo = SingleSwitchTopo(n=4)
    net = Mininet(topo, link = TCLink)
    net.start()
    print( "Dumping host connections" )
    dumpNodeConnections(net.hosts)
    print( "Testing network connectivity" )
    net.pingAll()
    print("Ejercicio 5 resultados")
    h1,h2 = net.get('host1', 'host2')
    h1,h3 = net.get('host1', 'host3')
    h2,h1 = net.get('host2', 'host1')
    net.iperf(hosts = (h1, h2))
    net.iperf(hosts = (h1, h3))
    net.iperf(hosts = (h2, h1))
    net.stop()

if __name__ == '__main__':
    # Tell mininet to print useful information
    setLogLevel('info')
    simpleTest()
