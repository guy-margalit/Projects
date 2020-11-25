"""
    Guy Margalit
    Audio Input Handler Class
"""
from Client.Config import *
from Client.State import State


class AudioInputHandler(Thread):
    def __init__(self, server_address: (str, int)) -> None:
        super().__init__()
        self.p = PyAudio()
        self.mic = self.p.open(format=self.p.get_format_from_width(WIDTH),
                               channels=CHANNELS,
                               rate=RATE,
                               output=True,
                               frames_per_buffer=CHUNK_SIZE)
        self.my_sock = socket(AF_INET, SOCK_STREAM)
        self.my_sock.bind(server_address)
        self.my_sock.listen(1)
        self.server_address = server_address
        self.sock = None
        self.state = State(False)

    def __del__(self) -> None:
        self.mic.stop_stream()
        self.mic.close()
        self.p.terminate()
        if self.state:
            self.stop()

    def can_read(self) -> bool:
        return self.sock in select([self.sock], [], [])[0]

    def stream(self) -> None:
        try:
            while self.state:
                if self.can_read() and self.state:
                    data = self.sock.recv(CHUNK_SIZE)
                    if self.state:
                        self.mic.write(data)
        except Exception as e:
            log("Error: " + str(e))

    def run(self) -> None:
        self.sock = self.my_sock.accept()[0]
        log("Starting Audio Input Stream...")
        self.state(True)
        self.stream()

    def stop(self) -> None:
        if self.state:
            log("Stopping Audio Input Stream...")
            self.state(False)
            self.sock.close()
        self.__del__()
