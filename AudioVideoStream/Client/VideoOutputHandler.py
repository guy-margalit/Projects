"""
    Guy Margalit
    Video Output Handler Class
    23/02/2020
"""
from Client.Config import *
from Client.State import State
from Client.Frame import Frame


class VideoOutputHandler(Thread):
    def __init__(self, server_address: (str, int), camera: int = 0) -> None:
        super().__init__()
        self.server_address = server_address
        self.camera = camera
        self.capture = VideoCapture(camera)
        self.sock = socket(AF_INET, SOCK_STREAM)
        self.sock.connect(server_address)
        self.state = State(False)

    def __del__(self) -> None:
        if self.state:
            self.stop()
        if self.capture.isOpened():
            self.capture.release()

    """def __add__(self, other) -> None:
        super().__init__()
        self.server_address = other.server_address
        self.camera = other.camera
        del other
        self.capture = VideoCapture(self.camera)
        self.sock = socket(AF_INET, SOCK_STREAM)
        self.sock.connect(self.server_address)
        self.state = State(False)"""

    def can_write(self) -> bool:
        return self.sock in select([], [self.sock], [])[1]

    def get_frame_data(self) -> bytes:
        ret, frame = self.capture.read()
        return imencode(".jpg", frame)[1].tobytes()

    def send_frame(self, frame: Frame) -> None:
        while not frame.is_done():
            if self.state and self.can_write():
                write_socket(self.sock, frame.read(CHUNK_SIZE))
            elif not self.state:
                break
        if self.state and self.can_write():
            write_socket(self.sock, END_SEQUENCE)

    def stream(self) -> None:
        #try:
        while self.state:
            self.send_frame(Frame(self.get_frame_data()))
            sleep(WAIT_TIME)
        """except Exception as e:
            log("Error: " + str(e))"""

    def run(self) -> None:
        log("Starting Video Output Stream...")
        self.state(True)
        self.stream()

    def stop(self) -> None:
        if self.state:
            log("Stopping Video Output Stream...")
            self.sock.close()
            self.state(False)
        self.__del__()
