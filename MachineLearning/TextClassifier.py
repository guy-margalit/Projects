"""
Guy Margalit
"""
from tensorflow import keras


def remove_signs(text):
    signs = (" ", "\n", "\t", "\'")
    word = [i for i in text if i.isalpha() or i in signs]
    return "".join(word).strip("\'")


def process_data(data, word_index):
    return keras.preprocessing.sequence.pad_sequences([review_encode(d, word_index) for d in data], value=word_index["<PAD>"], padding="post", maxlen=250)


def review_encode(s, word_index):
    encoded = [1] + [word_index.get(word.lower(), 2) for word in s.split()]
    return encoded


def decode_review(text, reverse_word_index):
    return " ".join([reverse_word_index.get(i, "?") for i in text])


def train_and_save_model():
    data = keras.datasets.imdb
    (train_data, train_labels) = data.load_data(num_words=88000)[0]
    word_index = data.get_word_index()
    word_index = {k: (v + 3) for k, v in word_index.items()}
    word_index["<PAD>"] = 0
    word_index["<START>"] = 1
    word_index["<UNK>"] = 2
    word_index["<UNUSED>"] = 3

    train_data = keras.preprocessing.sequence.pad_sequences(train_data, value=word_index["<PAD>"], padding="post", maxlen=250)

    model = keras.Sequential()
    model.add(keras.layers.Embedding(88000, 16))
    model.add(keras.layers.GlobalAveragePooling1D())
    model.add(keras.layers.Dense(16, activation="relu"))
    model.add(keras.layers.Dense(1, activation="sigmoid"))

    x_val = train_data[:10000]
    x_train = train_data[10000:]
    y_val = train_labels[:10000]
    y_train = train_labels[10000:]

    model.compile(optimizer="adam", loss="binary_crossentropy", metrics=["accuracy"])
    model.fit(x_train, y_train, epochs=40, batch_size=512, validation_data=(x_val, y_val), verbose=1)
    model.save("sentiment_model.h5")


def load_model():
    model = keras.models.load_model("sentiment_model.h5")
    data = keras.datasets.imdb
    word_index = data.get_word_index()
    word_index = {k: (v + 3) for k, v in word_index.items()}
    word_index["<PAD>"] = 0
    word_index["<START>"] = 1
    word_index["<UNK>"] = 2
    word_index["<UNUSED>"] = 3
    return model, word_index


def convert(prediction):
    return "Positive" if round(prediction) else "Negative"


def predict(model, data):
    predictions = model.predict(data)
    return predictions
