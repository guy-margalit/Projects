"""
    Guy Margalit
"""
import csv
from price_script import search_prices


base_uri1 = "https://www.bluenile.com/api/public/diamond-search-grid/v2?startIndex=0&pageSize=1000&_=1604511431554&unlimitedPaging=false&sortDirection=asc&sortColumn=default&shape={0}&minPrice={1}&maxPrice={2}&minCarat={3}&maxCarat={4}&minCut={5}&maxCut={6}&minColor={7}&maxColor={8}&minClarity={9}1&maxClarity={10}&maxDateType=MANUFACTURING_REQUIRED&isQuickShip=false&hasVisualization=false&isFiltersExpanded=false&astorFilterActive=false&country=USA&language=en-us&currency=USD&productSet=BN"
base_uri2 = "https://www.bluenile.com/api/public/diamond-search-grid/v2?startIndex=1000&pageSize=1000&_=1604511431554&unlimitedPaging=false&sortDirection=asc&sortColumn=default&shape={0}&minPrice={1}&maxPrice={2}&minCarat={3}&maxCarat={4}&minCut={5}&maxCut={6}&minColor={7}&maxColor={8}&minClarity={9}1&maxClarity={10}&maxDateType=MANUFACTURING_REQUIRED&isQuickShip=false&hasVisualization=false&isFiltersExpanded=false&astorFilterActive=false&country=USA&language=en-us&currency=USD&productSet=BN"
shapes = {
    "Round": "RD",
    "Princess": "PR",
    "Emerald": "EC",
    "Asscher": "AS",
    "Cushion": "CU",
    "Marquise": "MQ",
    "Radiant": "RA",
    "Oval": "OV",
    "Pear": "PS",
    "Heart": "HS"
}


def main():
    diamonds = []
    with open("River.csv", 'r') as file:
        reader = csv.reader(file)
        for row in list(reader)[1:]:
            diamond = row[1:4]
            diamond.append(row[5])
            diamond.append(row[6])
            diamond.append(row[26])
            diamonds.append(diamond)
    with open("prices.csv", "w") as file:
        writer = csv.writer(file)
        writer.writerow(["Shape", "Carat", "Color", "Clarity", "Cut", "Price", "Prices", "Average Price"])
        for diamond in diamonds:
            print(diamond)
            if diamond[4] != "":
                uri1 = base_uri1.format(shapes[diamond[0]], "0", "3000000", diamond[1], diamond[1], diamond[4], diamond[4], diamond[2], diamond[2], diamond[3], diamond[3])
                uri2 = base_uri2.format(shapes[diamond[0]], "0", "3000000", diamond[1], diamond[1], diamond[4], diamond[4], diamond[2], diamond[2], diamond[3], diamond[3])
            else:
                uri1 = base_uri1.format(shapes[diamond[0]], "0", "3000000", diamond[1], diamond[1], "Good", "Astor Ideal", diamond[2], diamond[2], diamond[3], diamond[3])
                uri2 = base_uri2.format(shapes[diamond[0]], "0", "3000000", diamond[1], diamond[1], "Good", "Astor Ideal", diamond[2], diamond[2], diamond[3], diamond[3])
            prices = search_prices(uri1, uri2)
            print(prices)
            try:
                writer.writerow(diamond + [prices, str(sum(map(lambda x: int(x), prices)) / len(prices))])
            except Exception as e:
                print(e)


if __name__ == '__main__':
    main()
