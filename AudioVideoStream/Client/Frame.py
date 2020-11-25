"""
    Guy Margalit
"""
from Client.Config import *


class Frame:
    def __init__(self, data: bytes = b'') -> None:
        self.data = data
        self.original_length = len(data)
        self.leftover_length = len(data)
        self.position = 0

    def __len__(self) -> int:
        return self.leftover_length

    def set_position(self, new_position: int) -> None:
        self.position = new_position

    def move_position(self, shift: int, op: str) -> None:
        self.position = eval("%d %s %d" % (self.position, op, shift))

    def read(self, amount: int) -> bytes:
        to_return = self.data[self.position:self.position + amount]
        self.position += amount
        self.leftover_length -= amount
        return to_return

    def write(self, new_data: bytes) -> None:
        self.data += new_data
        self.original_length += len(new_data)
        self.leftover_length += len(new_data)

    def is_done(self) -> bool:
        return self.leftover_length < 0

    def show(self, frame_name: str = "Video") -> None:
        arr = frombuffer(self.data, uint8)
        frame = imdecode(arr, IMREAD_COLOR)
        imshow(frame_name, frame)
