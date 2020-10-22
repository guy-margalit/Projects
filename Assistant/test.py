import src.TextClassifier as tc
import requests
from bs4 import BeautifulSoup


def find_title(title):
    response = requests.get(f"https://www.imdb.com/find?ref_=nv_sr_fn&q={title.replace(' ', '+')}")
    soup = BeautifulSoup(response.content, "html.parser")
    result_parent = soup.find("td", {"class": "result_text"})
    result = result_parent.findChildren("a")[0]
    return result['href']


def find_reviews(title_link):
    response = requests.get(f"https://www.imdb.com{title_link}reviews?ref_=tt_urv")
    soup = BeautifulSoup(response.content, "html.parser")
    reviews = soup.find_all("div", {"class": "text show-more__control"})[:5]
    return [review.text for review in reviews]


model, word_index = tc.load_model()
data = find_reviews(find_title("Harry Potter"))
data1 = tc.process_data(data, word_index)
print("\n".join([f"{d}\n{tc.convert(p[0])}" for p in tc.predict(model, data1) for d in data]))