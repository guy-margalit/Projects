"""
    Guy Margalit
    Audio Transmission Testing
"""
from Client.AudioOutputHandler import AudioOutputHandler
from Client.AudioInputHandler import AudioInputHandler


print("Creating audio input stream...")
audio_in = AudioInputHandler(("0.0.0.0", 2222))
print("Starting input...")
audio_in.start()
print("Creating audio output stream...")
audio_out = AudioOutputHandler(("127.0.0.1", 2222))
print("Starting output...")
audio_out.start()
