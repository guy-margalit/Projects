"""
    Guy Margalit
"""
import requests
import csv
from bs4 import BeautifulSoup


BASE_URL = "https://www.jamesallen.com/"
URL = "https://www.jamesallen.com/wedding-rings/womens-eternity/"
COLUMNS = [
    "Category",
    "Sex",
    "Sub Category",
    "Product Name",
    "Product Description",
    "Width",
    "Metal",
    "Diamond Shape",
    "Diamond Quantity",
    "Total Carat (min)",
    "Average Color",
    "Average Clarity"
]
DEFAULT = ["Wedding", "Women", "ETERNITY"]


def get_page(link):
    html = requests.get(link)
    return BeautifulSoup(html.text, "html.parser")


def element_to_row(element):
    div = element.find("div")
    div = div.find("div")
    a = div.find("a")
    link = a['href']
    div = a.find("div", {"class": "bottom-detail-ls-container--1DVIc"})
    div = div.find("div", {"class": "fixed-bottom--vK-hQ"})
    name = div.find("div", {"class": "Description--3Y6Ic"}).text
    page = get_page(BASE_URL + link)
    description = page.find("p", {"class": "description--2Rar8"}).text.replace("é", "e")
    metal = page.find("div", {"data-qa": "jewel_metal_value-ring_information-productDetailsTab"}).text
    width = page.find("div", {"data-qa": "jewel_width_value-ring_information-productDetailsTab"}).text
    shape = page.find("div", {"data-qa": "stone_shape_value-diamond-productDetailsTab"}).text
    quantity = page.find("div", {"data-qa": "stone_quantity_value-diamond-productDetailsTab"}).text
    total_carat = page.find("div", {"data-qa": "stone_total_carat_value-diamond-productDetailsTab"}).text
    average_color = page.find("div", {"data-qa": "stone_average color_value-diamond-productDetailsTab"}).text
    average_clarity = page.find("div", {"data-qa": "stone_average clarity_value-diamond-productDetailsTab"}).text
    return DEFAULT + [name, description, width, metal, shape, quantity, total_carat, average_color, average_clarity]


with open("wedding_rings.csv", "w") as file:
    writer = csv.writer(file)
    writer.writerow(COLUMNS)
    page = get_page(URL)
    list_div = page.find("div", {"id": "data-page-container"})
    for div in list_div:
        try:
            row = element_to_row(div)
            print(row)
            writer.writerow(row)
        except Exception as e:
            print(e)
