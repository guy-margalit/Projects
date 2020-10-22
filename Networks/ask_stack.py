"""
Guy Margalit
"""
import requests
from bs4 import BeautifulSoup


def find_questions(query_page):
    links = []
    questions = query_page.find_all("a", {"class": "question-hyperlink"})
    if questions is not None:
        for question in questions:
            links.append(f"https://stackoverflow.com{question['href']}")
        return links
    else:
        return []


def ask_stack(query):
    query_response = requests.get(f'https://stackoverflow.com/search?q="{query.replace(" ", "+").replace("%20", "+")}"')
    query_page = BeautifulSoup(query_response.text, "html.parser")
    question = find_questions(query_page)
    return question
