"""
    Guy Margalit
"""
import re
import requests
from datetime import datetime, timedelta
from bs4 import BeautifulSoup


SEARCH_URL = "https://www.google.com/search?q=%s+stats"
STATS_URL = "https://www.basketball-reference.com/players/pgl_cum_stats.cgi?player=%s&year=2020&date_game=%s&is_playoff_game=Y"
USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:65.0) Gecko/20100101 Firefox/65.0"
STATS = ['pts', 'trb', 'ast', 'stl', 'blk', 'tov']


def get_yesterday(offset=0) -> str:
    return (datetime.now() - timedelta(1 + offset)).strftime('%Y-%m-%d')


def search(name: str) -> str:
    url = SEARCH_URL % "+".join(name.lower().split())
    response = requests.get(url, headers={"user-agent": USER_AGENT})
    page = BeautifulSoup(response.content, "html.parser")
    results = page.find_all("div", {"class": "r"})
    correct = results[0].find("a")['href']
    for result in results:
        link = result.find("a")
        if link['href'].startswith("https://www.basketball-reference.com/"):
            correct = link['href']
    return correct


def get_last_game(link: str) -> [int]:
    try:
        print(link)
        result = re.search("https://www.basketball-reference.com/players/(.*)/(.*).html", link)
        name = result.group(2)
        response1 = requests.get(STATS_URL % (name, get_yesterday()))
        response2 = requests.get(STATS_URL % (name, get_yesterday(offset=2)))
        page1 = BeautifulSoup(response1.content, "html.parser")
        page2 = BeautifulSoup(response2.content, "html.parser")
        stats1 = [int(page1.find('td', {'data-stat': stat}).getText()) for stat in STATS]
        stats2 = [int(page2.find('td', {'data-stat': stat}).getText()) for stat in STATS]
        stats = [stats1[i] - stats2[i] for i in range(len(stats1))]
        return stats
    except Exception as e:
        print(e)


def get_games(link: str) -> [[int]]:
    response = requests.get(link)
    page = BeautifulSoup(response.content, "html.parser")
    new_stats = []
    stats = [[int(td.getText()) for td in page.find_all('td', {'data-stat': stat})] for stat in STATS]
    for i in range(len(stats[0])):
        game = []
        for stat in stats:
            game.append(stat[i])
        new_stats.append(game)
    return new_stats


def calc_points(stats: [int]) -> float:
    return stats[STATS.index('pts')] + 3 * (stats[STATS.index('blk')] + stats[STATS.index('stl')]) + 1.5 * stats[STATS.index('ast')] + 1.2 * stats[STATS.index('trb')] - stats[STATS.index('tov')]


def get_last_game_points(name: str) -> float:
    link = search(name)
    last_game_stats = get_last_game(link)
    if not last_game_stats:
        return 0
    return calc_points(last_game_stats)


def get_average(name: str) -> float:
    link = search(name).replace(".html", "/gamelog/2020/")
    games = get_games(link)
    if not games:
        return 0
    return round(sum(map(calc_points, games)) / len(games), 2)

