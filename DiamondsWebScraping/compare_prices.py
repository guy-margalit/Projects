"""
    Guy Margalit
"""
import csv


COLUMNS = [
    'Carat',
    'Color',
    'Clarity',
    'Cut',
    'Our Prices',
    'Blue Nile Prices'
]


def sort_river(data):
    sorted_data = {}
    for row in data[1:]:
        if row[1] != "Round":
            continue
        if 1.0 > float(row[2]) or float(row[2]) > 1.12:
            continue
        id_str = str(round(float(row[2]), 2)) + "-" + row[3] + "-" + row[5] + "-" + row[6]
        if sorted_data.get(id_str) is not None:
            prices = sorted_data.get(id_str)
            prices.append(row[26])
            sorted_data.update({id_str: prices})
        else:
            sorted_data.update({id_str: [row[26]]})
    return sorted_data


def sort_search(data):
    sorted_data = {}
    for row in data[2::2]:
        if row[10] != "Round":
            continue
        cut = eval(row[14])
        cut = list(cut.values())[0]
        id_str = str(round(float(row[1]), 2)) + "-" + row[12] + "-" + row[11] + "-" + cut
        prices = []
        if sorted_data.get(id_str) is not None:
            prices = sorted_data.get(id_str)
        prices.append(row[4].replace("$", "").replace(",", ""))
        if row[5] != "None":
            prices.append(row[5].replace("$", "").replace(",", ""))
        sorted_data.update({id_str: prices})
    return sorted_data


def merge(sorted1, sorted2):
    for id_str, prices in sorted1.items():
        sorted1.update({id_str: (prices, [])})
    for id_str, prices in sorted2.items():
        sorted1_prices = []
        if sorted1.get(id_str) is not None:
            sorted1_prices = sorted1.get(id_str)[0]
        sorted1.update({id_str: (sorted1_prices, prices)})
    return sorted1


def to_csv(data):
    rows = []
    for id_str, prices in data.items():
        carat, color, clarity, cut = id_str.split("-")
        our_prices, blue_nile_prices = prices
        rows.append([carat, color, clarity, cut, our_prices, blue_nile_prices])
    with open("compared_prices.csv", "w") as file:
        writer = csv.writer(file)
        writer.writerow(COLUMNS)
        writer.writerows(rows)


def compare_search(diamonds_list_filename):
    river = open("River.csv", 'r')
    search = open(diamonds_list_filename, 'r')
    river_reader = list(csv.reader(river))
    search_reader = list(csv.reader(search))
    river.close()
    search.close()
    sorted_river = sort_river(river_reader)
    sorted_search = sort_search(search_reader)
    return merge(sorted_river, sorted_search)
