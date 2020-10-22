"""
    Guy Margalit
"""
import pickle


def get_composer_indexes(composer, amount=-1):
    with open("music.pk",  'rb') as file:
        data = pickle.loads(file.read())
    indexes = []
    for i in range(len(data)):
        if data[i]['composer'] == composer:
            indexes.append(i)
            if len(indexes) == amount:
                break
    return indexes


