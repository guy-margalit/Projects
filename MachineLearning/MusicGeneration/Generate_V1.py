"""
    Guy Margalit
"""
from music import *

all_notes, notes = read_data()
num_notes = len(set(notes))
pitch = sorted(set(item for item in notes))
X, y = prep(all_notes, notes)
X = np.reshape(X, (len(X), 128, 1))
X = X / float(num_notes)
model = load_model("music_model_V2.h5")
done = False
while not done:
    count = int(input("How many?\n"))
    for _ in range(count):
        generate(X, model, pitch, num_notes)
    done = int(input("Stop?\n"))
