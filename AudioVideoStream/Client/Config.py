"""
    Guy Margalit
    Configuration and Utils File
"""
from pyaudio import paInt16
from select import select
from datetime import datetime
from cv2 import VideoCapture, imencode, imdecode, IMREAD_COLOR, waitKey, imshow
from numpy import frombuffer, uint8
from time import sleep
from socket import socket, AF_INET, SOCK_STREAM, SOCK_DGRAM
import PySimpleGUI as gui
from pygame import mixer
from threading import Thread
from pyaudio import PyAudio, paInt16


CHUNK_SIZE = 1024
LEN_SIZE = 5
LOGFILE = open('log.txt', 'a')
WAIT_TIME = 1 / 20
FORMAT = paInt16
CHANNELS = 1
MAIN_WINDOW_TIMEOUT = 3000
RATE = 60000
WIDTH = 2
TIMEOUT = 5
SELECT_TIMEOUT = 1
SERVER_IP = '127.0.0.1'
MY_NAME = 'guy'
CALL_MESSAGE_SIZE = 200
SERVER_PORT = 3333
SERVER_ADDRESS = (SERVER_IP, SERVER_PORT)
END_SEQUENCE = b"@#$@#$"


def read_socket(sock: socket) -> bytes:
    length = sock.recv(LEN_SIZE).decode()
    return sock.recv(int(length))


def write_socket(sock: socket, msg: str or bytes) -> None:
    if isinstance(msg, str):
        sock.send(str(len(msg.encode())).zfill(LEN_SIZE).encode() + msg.encode())
    else:
        sock.send(str(len(msg)).zfill(LEN_SIZE).encode() + msg)


def log(txt: str) -> None:
    print(datetime.today(), txt, "\n", file=LOGFILE)
