"""
    Guy Margalit
    Video Input Handler Class
    23/02/2020
"""
from Client.Config import *
from Client.Frame import Frame
from Client.State import State


class VideoInputHandler(Thread):
    def __init__(self, server_address: (str, int)) -> None:
        super().__init__()
        self.server_address = server_address
        self.my_sock = socket(AF_INET, SOCK_STREAM)
        self.my_sock.bind(server_address)
        self.my_sock.listen(1)
        self.sock = None
        self.state = State(False)

    def __del__(self) -> None:
        if self.state:
            self.stop()

    def can_read(self) -> bool:
        return self.sock in select([self.sock], [], [])[0]

    def get_frame(self) -> Frame or None:
        while True:
            if self.state and self.can_read():
                data = read_socket(self.sock)
                break
            elif not self.state:
                return None
        frame = Frame()
        while data != END_SEQUENCE:
            frame.write(data)
            if self.state:
                data = read_socket(self.sock)
            else:
                return None
        return frame

    def stream(self) -> None:
        #try:
        while self.state:
            frame = self.get_frame()
            if frame is not None:
                frame.show()
            waitKey(1)
        sleep(WAIT_TIME)
        """except Exception as e:
            log("Error: " + str(e))"""

    def run(self) -> None:
        self.sock = self.my_sock.accept()[0]
        log("Starting Video Input Stream...")
        self.state(True)
        self.stream()

    def stop(self) -> None:
        if self.state:
            log("Stopping Video Input Stream...")
            self.sock.close()
            self.state(False)
        self.__del__()
