"""
Guy Margalit
"""
import requests
from bs4 import BeautifulSoup


def find_questions(query_page):
    text = []
    questions = query_page.find_all("a", {"class": "question-hyperlink"})
    if questions is not None:
        for question in questions:
            text.append(f"https://stackoverflow.com{question['href']}")
        return "\n\t\t".join(text)
    else:
        return "None Found."


def ask_stack(query):
    query_response = requests.get(f'https://stackoverflow.com/search?q="{query.replace(" ", "+").replace("%20", "+")}"')
    query_page = BeautifulSoup(query_response.text, "html.parser")
    question = find_questions(query_page)
    return question
