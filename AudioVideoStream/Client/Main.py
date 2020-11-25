"""
    Guy Margalit
    Main File
"""
from Client.Config import *
from Client.CallUtils import open_call, has_call, start_call, send_call


layout = [
    [gui.Text("Contact")],
    [gui.InputText()],
    [gui.Checkbox("video")],
    [gui.Checkbox("audio")],
    [gui.Button("call"), gui.Button("cancel")]
]

mixer.init()
mixer.music.load("skype_ringtone.mp3")
sock = socket(AF_INET, SOCK_DGRAM)
sock.settimeout(10)
window = gui.Window("Dialer", layout)
call_sock = socket(AF_INET, SOCK_DGRAM)
call_sock.bind(("0.0.0.0", 4444))

while True:
    event, data = window.Read(timeout=MAIN_WINDOW_TIMEOUT)
    if event == gui.TIMEOUT_KEY:
        if has_call(call_sock):
            start_call(call_sock, window)
        continue
    if event in (None, "cancel"):
        log("Exiting...")
        break
    elif event == "call":
        contact, video, audio = data.values()
        log("Calling %s..." % contact)
        params = send_call(sock, contact, video, audio)
        if params is not None:
            open_call(window, *params)
