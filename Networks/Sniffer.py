"""
    Guy Margalit
    Sniffer Thread Class
"""
from scapy.all import *


class Sniffer(Thread):
    def __init__(self, filter_func, print_func):
        super().__init__()
        self.print_func = print_func
        self.filter_func = filter_func

    def run(self):
        sniff(lfilter=self.filter_func, prn=self.print_func)
