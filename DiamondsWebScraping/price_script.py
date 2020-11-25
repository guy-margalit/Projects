"""
    Guy Margalit
"""
import csv
import PySimpleGUI as sg
import requests


base_uri1 = "https://www.bluenile.com/api/public/diamond-search-grid/v2?startIndex=0&pageSize=1000&_=1604511431554&unlimitedPaging=false&sortDirection=asc&sortColumn=default&shape={0}&minPrice={1}&maxPrice={2}&minCarat={3}&maxCarat={4}&minCut={5}&maxCut={6}&minColor={7}&maxColor={8}&minClarity={9}1&maxClarity={10}&maxDateType=MANUFACTURING_REQUIRED&isQuickShip=false&hasVisualization=false&isFiltersExpanded=false&astorFilterActive=false&country=USA&language=en-us&currency=USD&productSet=BN"
base_uri2 = "https://www.bluenile.com/api/public/diamond-search-grid/v2?startIndex=1000&pageSize=1000&_=1604511431554&unlimitedPaging=false&sortDirection=asc&sortColumn=default&shape={0}&minPrice={1}&maxPrice={2}&minCarat={3}&maxCarat={4}&minCut={5}&maxCut={6}&minColor={7}&maxColor={8}&minClarity={9}1&maxClarity={10}&maxDateType=MANUFACTURING_REQUIRED&isQuickShip=false&hasVisualization=false&isFiltersExpanded=false&astorFilterActive=false&country=USA&language=en-us&currency=USD&productSet=BN"


def search(filename, uri1, uri2):
    with open(filename, "w") as file:
        writer = csv.writer(file)
        response = requests.get(uri1)
        data1 = eval(response.text.replace("false", "False").replace("true", "True").replace("null", "None"))
        response = requests.get(uri2)
        data2 = eval(response.text.replace("false", "False").replace("true", "True").replace("null", "None"))
        results = data1.get("results") + data2.get("results")
        writer.writerow(results[0].keys())
        rows = []
        for result in results:
            row = []
            for value in result.values():
                if type(value) == dict:
                    row.append(str(value.values()[0]))
                elif type(value) == list:
                    row.append(str(value[0]))
                else:
                    row.append(str(value))
            rows.append(row)
        writer.writerows(rows)


def search_prices(uri1, uri2):
    prices = []
    try:
        response = requests.get(uri1)
        data1 = eval(response.text.replace("false", "False").replace("true", "True").replace("null", "None"))
        response = requests.get(uri2)
        data2 = eval(response.text.replace("false", "False").replace("true", "True").replace("null", "None"))
        results = data1.get("results") + data2.get("results")
        for result in results:
            values = list(result.values())
            prices.append(values[4][0].replace("$", "").replace(",", ""))
            if values[5] != "None":
                prices.append(values[5][0].replace("$", "").replace(",", ""))
    except Exception as e:
        print(e)
    return prices


def main():
    window = sg.Window('Search').Layout(
        [[sg.Text("Filename")],
         [sg.Input()],
         [sg.Text('Shape')],
         [sg.Input()],
         [sg.Text('Price')],
         [sg.Text("Min"), sg.Input(), sg.Text("Max"), sg.Input()],
         [sg.Text('Carat')],
         [sg.Text("Min"), sg.Input(), sg.Text("Max"), sg.Input()],
         [sg.Text('Cut')],
         [sg.Text("Min"), sg.Input(), sg.Text("Max"), sg.Input()],
         [sg.Text('Color')],
         [sg.Text("Min"), sg.Input(), sg.Text("Max"), sg.Input()],
         [sg.Text('Clarity')],
         [sg.Text("Min"), sg.Input(), sg.Text("Max"), sg.Input()],
         [sg.OK(), sg.Cancel()]])

    while True:
        event, data = window.Read()
        if event is None or event in ["Exit", "Cancel"]:
            break
        print(list(data.values())[1:])
        values = list(data.values())[1:]
        uri1 = base_uri1.format(*values)
        uri2 = base_uri2.format(*values)
        search(data[0], uri1, uri2)
        sg.Window('Status').Layout([[sg.Text("Done")]]).Read()


if __name__ == '__main__':
    main()
