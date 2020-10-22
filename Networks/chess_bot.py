"""
    Guy Margalit
"""
from selenium import webdriver
from selenium.webdriver import ActionChains
from re import search


def get_piece_by_link(link):
    regex = search("/(.*).png", link)
    return regex.group(1)[1].upper(), regex.group(1)[0].upper()


def get_loc_from_style(style):
    regex = search("translate\((.*)px, (.*)px\);", style)
    x = int(regex.group(1))
    y = int(regex.group(2))
    return x, y


def coordinates_from_square(square):
    x = (ord(square[0]) - ord('a')) * 83
    y = abs((int(square) - 1) * 83 - 581)
    return x, y


def square_from_coordinates(x, y):
    x = x // 83
    x_letter = chr(ord('a') + x)
    y_number = (581 - y) // 83 + 1
    return x_letter + str(y_number)


class ChessPiece:
    def __init__(self, element, actor):
        self._actor = actor
        self._element = element
        self._type, self._player = get_piece_by_link(element)
        style = self._element.get_attribute("style")
        self._loc = get_loc_from_style(style)

    def move(self, square):
        target_x, target_y = coordinates_from_square(square)
        x, y = self._loc
        self._actor.drag_and_drop(self._element, target_x - x, target_y - y).perform()

    def get_loc(self):
        return self._loc

    def get_player(self):
        return self._player

    def get_type(self):
        return self._type


class ChessPage:
    def __init__(self, url):
        self._driver = webdriver.Chrome(r"C:\Users\guyma\OneDrive\מסמכים\chromedriver.exe")
        self._driver.get(url)
        self._actor = ActionChains(self._driver)
        self._opponent_pieces = []
        self._my_pieces = []

    def update_pieces(self):
        my_pieces = []
        opponent_pieces = []
        pieces = self._driver.find_element_by_xpath('//*[@id="game-board"]/div[4]')
        pieces = pieces.find_elements_by_tag_name("img")
        for piece in pieces:
            piece = ChessPiece(piece, self._actor)
            if piece.get_player() == 'w':
                opponent_pieces.append(piece)
            else:
                my_pieces.append(piece)
        self._opponent_pieces = opponent_pieces
        self._my_pieces = my_pieces

    def get_op_move(self):
        move_list = self._driver.find_element_by_xpath('//*[@id="moveListControl_vertical"]')
        moves = move_list.find_elements_by_tag_name("div")
        move = moves[-1].find_elements_by_tag_name("span")[1]
        return move.find_element_by_tag_name("a").text

    def __getitem__(self, item, player):

