"""
    Guy Margalit
"""
from nba_stats import *


PLAYERS = ['yotam', 'roy', 'guy', 'ori', 'ben', 'orian']


def read_file(name: str) -> (float, [str]):
    with open(name + ".txt") as file:
        lines = [line.replace("\n", "") for line in file.readlines()]
        if not lines:
            return 0, []
        return float(lines[0]), lines[1:]


def update_file(name: str, points: float, new_names: [str]) -> None:
    with open(name + ".txt", 'w') as file:
        file.write(str(points) + "\n" + "\n".join(new_names))


def add_points(points: float, names: [str]) -> (float, [str]):
    new_names = []
    for name in names:
        name_points = round(get_last_game_points(name), 2)
        print(name, name_points)
        new_names.append(name + " - " + str(name_points))
        points += name_points
    return round(points, 2), new_names


def save_results(results: [str]):
    with open("results.txt") as file:
        file.write("\n".join(results))


def main():
    results = []
    for player in PLAYERS:
        data = read_file(player)
        points = add_points(*data)
        results.append(player + ":" + str(total[0]))
        update_file(player, *points)
    results = list(sorted(results, key=lambda x: float(x.split(":")[1])))
    save_results(results)


if __name__ == '__main__':
    main()
