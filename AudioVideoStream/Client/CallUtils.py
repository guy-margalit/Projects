"""
    Guy Margalit
    Call Utils
"""
from Client.Config import *
from Client.AudioOutputHandler import AudioOutputHandler
from Client.AudioInputHandler import AudioInputHandler
from Client.VideoInputHandler import VideoInputHandler
from Client.VideoOutputHandler import VideoOutputHandler


CONTACT_ADDRESS = ""


def parse_call(contact_name: str, is_video: bool, is_audio: bool) -> str:
    return ("call{'contact': '%s', 'audio': %s, 'video': %s, 'caller': '%s'}" % (contact_name,
                                                                                 is_audio,
                                                                                 is_video,
                                                                                 MY_NAME)
            ).zfill(CALL_MESSAGE_SIZE)


def get_address(sock: socket, contact: str) -> str:
    global CONTACT_ADDRESS
    sock.sendto(contact.encode(), SERVER_ADDRESS)
    data, address = sock.recvfrom(CHUNK_SIZE)
    CONTACT_ADDRESS = (data.decode(), 4444)
    return CONTACT_ADDRESS[0]


def end_call(sock: socket) -> None:
    global CONTACT_ADDRESS
    sock.sendto(END_SEQUENCE, CONTACT_ADDRESS)
    sock.close()


def call(sock: socket, parsed_call: str) -> bool:
    global CONTACT_ADDRESS
    sock.sendto(parsed_call.encode(), CONTACT_ADDRESS)
    try:
        data, address = sock.recvfrom(CHUNK_SIZE)
        return eval(data)
    except Exception as e:
        print(1)
        log("Error: " + str(e))
        return False


def open_call(old_window: gui.Window, name: str, address: str, is_video: bool, is_audio: bool) -> None:
    old_window.Hide()
    layout = [
        [gui.Text(name)],
        [gui.Button("Hang Up!")]
    ]
    handlers = []
    if is_audio:
        audio_in = AudioInputHandler(("0.0.0.0", 2222))
        audio_in.start()
        audio_out = AudioOutputHandler((address, 2222))
        audio_out.start()
        handlers.append(audio_in)
        handlers.append(audio_out)
    if is_video:
        video_in = VideoInputHandler(("0.0.0.0", 1111))
        video_in.start()
        video_out = VideoOutputHandler((address, 1111))
        video_out.start()
        handlers.append(video_in)
        handlers.append(video_out)
    window = gui.Window("Call", layout)
    while True:
        event, data = window.Read()
        if event in (None, "Hang Up!"):
            for handler in handlers:
                handler.stop()
                window.Hide()
            break
    old_window.UnHide()


def ask_user(caller: str, call_params: (bool, bool)) -> bool:
    mixer.music.play(-1)
    video = "video" if call_params[1] else ""
    audio = "audio" if call_params[0] else ""
    if audio and video:
        audio += ", "
    layout = [
        [gui.Text("%s is calling you... (%s%s)" % (caller, audio, video))],
        [gui.Button("Accept"), gui.Button("Reject")]
    ]
    window = gui.Window("Call", layout)
    event, data = window.Read()
    mixer.music.stop()
    window.Hide()
    return event == "Accept"


def has_call(sock: socket) -> bool:
    return sock in select([sock], [], [], SELECT_TIMEOUT)[0]


def start_call(sock: socket, window: gui.Window) -> None:
    data, address = sock.recvfrom(CALL_MESSAGE_SIZE)
    params = eval(b'{' + data.split(b"call{")[-1])
    window.Hide()
    picked_up = ask_user(params['caller'], (params["audio"], params['video']))
    sock.sendto(str(picked_up).encode(), address)
    if picked_up:
        open_call(window, params['caller'], address[0], params['video'], params['audio'])
    window.UnHide()


def send_call(sock: socket, contact: str, is_video: bool, is_audio: bool) -> (str, str, bool, bool) or None:
    address = get_address(sock, contact)
    answered = call(sock, parse_call(contact, is_video, is_audio))
    if answered:
        log("Answered")
        return contact, address, is_video, is_audio
    else:
        log("Didn't answer")
        return None
