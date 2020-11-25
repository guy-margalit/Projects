"""
    Guy Margalit
    Audio Output Handler Class
"""
from Client.Config import *
from Client.State import State


class AudioOutputHandler(Thread):
    def __init__(self, server_address: (str, int)) -> None:
        super().__init__()
        self.p = PyAudio()
        self.mic = self.p.open(format=self.p.get_format_from_width(WIDTH),
                               channels=CHANNELS,
                               rate=RATE,
                               input=True,
                               frames_per_buffer=CHUNK_SIZE)
        self.server_address = server_address
        self.sock = socket(AF_INET, SOCK_STREAM)
        self.sock.connect(server_address)
        self.state = State(False)

    def __del__(self) -> None:
        self.mic.stop_stream()
        self.mic.close()
        self.p.terminate()
        if self.state:
            self.stop()

    def can_write(self) -> bool:
        return self.sock in select([], [self.sock], [])[1]

    def stream(self) -> None:
        try:
            while self.state:
                if self.state:
                    data = self.mic.read(CHUNK_SIZE)
                    if self.state and self.can_write():
                        self.sock.send(data)
        except Exception as e:
            log("Error: " + str(e))

    def run(self) -> None:
        log("Starting Audio Output Stream...")
        self.state(True)
        self.stream()

    def stop(self) -> None:
        if self.state:
            log("Stopping Audio Output Stream...")
            self.sock.close()
            self.state(False)
        self.__del__()
