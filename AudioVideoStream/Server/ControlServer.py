"""
    Guy Margalit
    Control Server Class
"""
from Server.ServerConfig import *


sock = socket(AF_INET, SOCK_DGRAM)
sock.bind(MY_ADDRESS)
while True:
    data, address = sock.recvfrom(CHUNK_SIZE)
    sock.sendto(CLIENTS[str(data)[2:-1]].encode(), address)
