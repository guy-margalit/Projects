"""
    Guy Margalit
    State Class
"""


class State:
    def __init__(self, begin_state: bool = False) -> None:
        self.state = begin_state

    def __bool__(self) -> bool:
        return self.state

    def __call__(self, state: bool) -> None:
        self.state = state
