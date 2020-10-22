# -*- coding: utf-8 -*-
import subprocess
from datetime import date, datetime
import random
import smtplib
import sys
import re
import webbrowser
import win32com.client
from playsound import playsound
from threading import Timer
from src.AskStack import ask_stack

try:
    from email import encoders
    from email.mime.base import MIMEBase
    from email.mime.multipart import MIMEMultipart
    from email.mime.text import MIMEText
except ImportError:
    subprocess.call("pip install email")
    from email import encoders
    from email.mime.base import MIMEBase
    from email.mime.multipart import MIMEMultipart
    from email.mime.text import MIMEText

try:
    from word2number import w2n
except ImportError:
    subprocess.call("pip install word2number")
    from word2number import w2n

try:
    import face_recognition as fr
except ImportError:
    subprocess.call("pip install face_recognition")
    import face_recognition as fr

try:
    import keyboard
except ImportError:
    subprocess.call("pip install keyboard")
    import keyboard

try:
    import requests
except ImportError:
    subprocess.call("pip install requests")
    import requests

try:
    import wikipedia
except ImportError:
    subprocess.call("pip install wikipedia")
    import wikipedia

try:
    import speech_recognition as sr
except ImportError:
    subprocess.call("pip install speech_recognition")
    import speech_recognition as sr

try:
    from translate import Translator
except ImportError:
    subprocess.call("pip install translate")
    from translate import Translator

try:
    from bs4 import BeautifulSoup
except ImportError:
    subprocess.call("pip install bs4")
    from bs4 import BeautifulSoup

try:
    from ecapture import ecapture as ec
except ImportError:
    subprocess.call("pip install ecapture")
    from ecapture import ecapture as ec

try:
    import PySimpleGUI as sg
except ImportError:
    subprocess.call("pip install PySimpleGUI")
    import PySimpleGUI as sg


def talk(audio):
    print('Jarvis: ' + audio)
    speaker.Speak(audio)


def greet_me():
    current_hour = int(datetime.now().hour)
    if 0 <= current_hour < 12:
        talk('Good Morning!')
    elif 12 <= current_hour < 18:
        talk('Good Afternoon!')
    elif current_hour >= 18:
        talk('Good Evening!')


def given_command():
    with microphone as source:
        recognizer.adjust_for_ambient_noise(source)
        playsound('wake_up_sound.mp3')
        print("...")
        audio = recognizer.listen(source)

    response = {
        "success": True,
        "error": None,
        "transcription": None
    }
    try:
        response["transcription"] = recognizer.recognize_google(audio)
    except sr.RequestError:
        response["success"] = False
        response["error"] = "API unavailable"
    except sr.UnknownValueError:
        response["success"] = False
        response["error"] = "Unable to recognize speech"
    return response


def is_guy(unknown_face):
    unknown_face = fr.load_image_file(unknown_face)
    unknown_face_locations = fr.face_locations(unknown_face)
    if len(unknown_face_locations) > 0:
        unknown_face_encoding = fr.face_encodings(unknown_face, unknown_face_locations)[0]
        image = fr.load_image_file("faces\\Guy.jpg")
        face_locations = fr.face_locations(image)
        known_face_encoding = fr.face_encodings(image, face_locations)
        match = fr.compare_faces(known_face_encoding, unknown_face_encoding)
        return match[0]
    return False


def get_weather(location=""):
    degree_sign = u'\N{DEGREE SIGN}'
    html = requests.get("https://www.google.com/search?q=weather " + location)
    page = BeautifulSoup(html.text, "html.parser")
    s = page.text.split(degree_sign)[0]
    return s[-2:] + degree_sign + "C"


def get_news():
    message = ""
    html = requests.get("https://www.geektime.co.il")
    page = BeautifulSoup(html.text, "html.parser")
    articles = page.find_all("section", class_="post-details")
    for article in articles:
        contents = article.contents
        message += "{0}:\n{1}\n\n".format(contents[0].text, contents[2].text)
    return message


def get_summary(subject, length):
    talk('In what language?')
    message = given_command()
    wikipedia.set_lang(message['transcription'][:2:])
    try:
        return wikipedia.summary(subject, sentences=int(length)).replace('. ', '.\n')
    except wikipedia.DisambiguationError:
        q = 'what do you mean?\n' + "\n".join(wikipedia.search(subject))
        talk(q)
        message = given_command()
        return get_summary(message['transcription'], length)


def send_changes(send_2_email=True):
    d = date.today()
    today = d.strftime("%d.%m.%Y")
    tomorrow = d.strftime(f"{str(1 + int(d.day))}.%m.%Y")
    msg = ""
    changes_to_send = ""
    tests_to_send = ""
    events_to_send = ""
    params = {'__EVENTTARGET': 'dnn$ctr16914$TimeTableView$btnChanges',
              '__EVENTARGUMENT': '',
              '__LASTFOCUS': '',
              '__VIEWSTATE': '/wEPDwUIMjU3MTQzOTcPZBYGZg8WAh4EVGV4dAU'
                             '+PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0'
                             'MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwvL'
                             '0VOIj5kAgEPZBYMAgEPFgIeB1Zpc2libGVoZAIC'
                             'DxYCHgdjb250ZW50BSnXqteZ15vXldefINeo15X'
                             'XmNeR16jXkiDXqNee16og15TXqdeo15XXn2QCAw'
                             '8WAh8CBTjXqteZ15vXldefINeo15XXmNeR16jXk'
                             'iDXqNee16og15TXqdeo15XXnyxEb3ROZXROdWtl'
                             'LEROTmQCBA8WAh8CBSDXm9ecINeU15bXm9eV15n'
                             'XldeqINep157Xldeo15XXqmQCBQ8WAh8CBQtEb3'
                             'ROZXROdWtlIGQCBg8WAh8CBSnXqteZ15vXldefI'
                             'Neo15XXmNeR16jXkiDXqNee16og15TXqdeo15XX'
                             'n2QCAg9kFgJmD2QWAgIED2QWAmYPZBYGAgIPZBY'
                             'CZg8PFgYeCENzc0NsYXNzBQtza2luY29sdHJvbB'
                             '4EXyFTQgICHwFoZGQCAw9kFgJmDw8WBh8DBQtza'
                             '2luY29sdHJvbB8ABRfXm9eg15nXodeUINec157X'
                             'oteo15vXqh8EAgJkZAIKD2QWAgICD2QWCAIBDw8'
                             'WAh8BaGRkAgMPDxYCHwFoZGQCBQ9kFgICAg8WAh'
                             '8BaGQCBw9kFgICAQ9kFgICAQ9kFgoCBg9kFgJmD'
                             '2QWDAICDxYCHgVjbGFzcwUKSGVhZGVyQ2VsbGQC'
                             'BA8WAh8FBQpIZWFkZXJDZWxsZAIGDxYCHwUFCkh'
                             'lYWRlckNlbGxkAggPFgIfBQUKSGVhZGVyQ2VsbG'
                             'QCCg8WAh8FBQpIZWFkZXJDZWxsZAIMDxYCHwUFE'
                             'EhlYWRlckNlbGxCdXR0b25kAgcPEGQQFQAVABQr'
                             'AwBkZAILDxYCHwFoZAIMD2QWAmYPZBYcZg9kFgI'
                             'CAQ8QZBAVHwTXmScxBNeZJzIE15knMwTXmSc0BN'
                             'eZJzUE15knNgTXmSc3BNeZJzgE15knOQXXmScxM'
                             'AXXmdeQMQXXmdeQMgXXmdeQMwXXmdeQNAXXmdeQ'
                             'NQXXmdeQNgXXmdeQNwXXmdeQOAXXmdeQOQbXmde'
                             'QMTAF15nXkTEF15nXkTIF15nXkTMF15nXkTQF15'
                             'nXkTUF15nXkTYF15nXkTcF15nXkTgF15nXkTka1'
                             '6LXldec15nXnSDXl9eT16nXmdedINeZ15Aa16LX'
                             'ldec15nXnSDXl9eT16nXmdedINeZ15EVHwExATI'
                             'BMwE0ATUBNgE3ATgDMTg4AzE5NAE5AjEwAjExAj'
                             'EyAjEzAjE0AjE1AjE2AzE5NQMyMDcCMjICMjMCM'
                             'jQCMjUCMjYCMjcCMjgCMjkDMjA4AzExMwMxOTcU'
                             'KwMfZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2d'
                             'nZ2dnZxYBAgxkAgIPFgQfBQUKSGVhZGVyQ2VsbB'
                             '8BaGQCAw8WAh8BaGQCBA8WAh8FBQpIZWFkZXJDZ'
                             'WxsZAIGDxYCHwUFCkhlYWRlckNlbGxkAggPFgIf'
                             'BQUSSGVhZGVyQ2VsbFNlbGVjdGVkZAIKDxYCHwU'
                             'FCkhlYWRlckNlbGxkAgwPFgIfBQUKSGVhZGVyQ2'
                             'VsbGQCDg8WAh8FBQpIZWFkZXJDZWxsZAIQDxYEH'
                             'wUFCkhlYWRlckNlbGwfAWhkAhEPFgIfAWhkAhIP'
                             'FgQfBQUKSGVhZGVyQ2VsbB8BaGQCEw8WAh8BaGQ'
                             'CFA8WBB8FBRBIZWFkZXJDZWxsQnV0dG9uHwFoZA'
                             'IPDw8WAh8ABTvXntei15XXk9eb158g15w6IDI3L'
                             'jA5LjIwMTksINep16LXlDogMDk6MDUsINee16HX'
                             'mjogQTExNjkxNGRkZJUq2NOR56WtCSMGgDaO6YTVAmqJ',
              '__VIEWSTATEGENERATOR': 'CA0B0334',
              'dnn$ctr16914$TimeTableView$ClassesList': 11,
              'dnn$ctr16914$TimeTableView$MainControl$WeekShift': 0,
              'dnn$ctr16914$TimeTableView$ControlId': 2,
              'ScrollTop': '',
              '__dnnVariable': ''}
    url = 'http://rotberg.iscool.co.il/%D7%93%D7%A3%D7%91%D7%99%D7%AA/tabid/4867/language/he-IL/Default.aspx'
    page = requests.post(url=url, data=params)
    soup = BeautifulSoup(page.text, features='html.parser')
    for cell in soup.select('.MsgCell'):
        string = cell.get_text()
        if send_2_email:
            changes_to_send += string + "\n"
        elif today in string or tomorrow in string:
            changes_to_send += string + "\n"
    if changes_to_send != "":
        msg += 'Changes:\n' + changes_to_send
    params['__EVENTTARGET'] = 'dnn$ctr16914$TimeTableView$btnExams'
    page = requests.post(url=url, data=params)
    soup = BeautifulSoup(page.text, features='html.parser')
    for cell in soup.select('.MsgCell'):
        string = cell.get_text()
        tests_to_send += string + "\n"
    if tests_to_send != "":
        msg += 'Exams:\n' + tests_to_send
    params['__EVENTTARGET'] = 'dnn$ctr16914$TimeTableView$btnEvents'
    page = requests.post(url=url, data=params)
    soup = BeautifulSoup(page.text, features='html.parser')
    for cell in soup.select('.MsgCell'):
        string = cell.get_text()
        events_to_send += string + "\n"
    if events_to_send != "":
        msg += 'Events:\n' + events_to_send
    if msg == "":
        msg = "No changes."
    msg = MIMEText(msg)
    msg['To'] = "guymargalit24@gmail.com"
    msg['From'] = username
    msg['Subject'] = "News"
    server.sendmail(username, "guymargalit24@gmail.com", msg)


def get_sentiment(text):
    request_headers = {
        "language": "english",
        "text": text}

    response = requests.post("https://text-processing.com/demo/sentiment/", request_headers)
    soup = BeautifulSoup(response.content, "html.parser")
    strong_pos = soup.find("strong", {"class": "large positive"})
    strong_neg = soup.find("strong", {"class": "large negative"})
    if strong_neg is not None:
        return -1
    elif strong_pos is not None:
        return 1
    else:
        return 0


def get_number(n: int) -> int:
    while 1:
        number = given_command()["transcription"]
        print(f"You: {number}")
        if number.is_digit():
            talk("great")
            return int(number)
        elif number == "all":
            return n
        elif number == "none":
            return 0
        else:
            talk("not a number. try again")


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
    return [review.text[:100] for review in reviews]


def get_rating(title_link):
    response = requests.get(f"https://www.imdb.com{title_link}?ref_=rvi_tt")
    soup = BeautifulSoup(response.content, "html.parser")
    rating = float(soup.find("span", {"itemprop": "ratingValue"}).text)
    return rating


def estimate_quality(title):
    title_link = find_title(title)
    reviews = find_reviews(title_link)
    average_rating = get_rating(title_link)
    overall_sentiment = 0
    for review in reviews:
        overall_sentiment += get_sentiment(review)
    opinion = "The ratings are %s %s the reviews are %s"
    if average_rating >= 8:
        rating = "great"
    elif average_rating > 5:
        rating = "ok"
    else:
        rating = "bad"
    if overall_sentiment >= 4:
        review = "good"
        if rating == "bad":
            link = "but"
        else:
            link = "and"
    elif overall_sentiment == 3:
        review = "ok"
        if rating == "ok":
            link = "and"
        else:
            link = "but"
    else:
        review = "bad"
        if rating == "bad":
            link = "and"
        else:
            link = "but"
    return opinion % (rating, link, review)


def alarm(*tag):
    if not isinstance(tag, str):
        tag = "".join(tag)
    playsound("alarm.mp3", block=False)
    sg.Window('Timer').Layout([[sg.Text(tag, auto_size_text=True)]]).Read()


def detected():
    global latest
    command = given_command()
    if command['success']:
        message = command['transcription']
    else:
        talk("I don't understand")
        return
    print(f"You: {message}")
    message = message.lower()

    if 'changes' in message:
        talk('Sure')
        talk('Sending...')
        send_changes()

    elif "roll the dice" == message:
        talk("Rolling...")
        cube_1 = random.randint(1, 6)
        cube_2 = random.randint(1, 6)
        talk(f"The dice have rolled: {cube_1}, {cube_2}")

    elif "how do i say" in message:
        rex = re.search("how do i say (.*) in (.*)", message)
        lang = rex.group(2)
        phrase = rex.group(1)
        translator = Translator(to_lang=lang)
        translation = translator.translate(phrase)
        talk(translation)

    elif "how much is" in message:
        rex = re.search("how much is (.*)", message.replace("^", "**"))
        talk(str(eval(rex.group(1))))

    elif "timer" in message and ("set a" in message or "start a" in message):
        rex = re.search(" a (.*) (.*) timer", message)
        unit = 1
        if "minute" in rex.group(2):
            unit = 60
        elif "hour" in rex.group(2):
            unit = 3600
        try:
            interval = int(rex.group(1)) * unit
        except ValueError:
            interval = w2n.word_to_num(rex.group(1)) * unit
        time = f"{rex.group(1)} {rex.group(2)}"
        Timer(interval, alarm, args=f"your {time} timer is up").start()
        talk("set")

    elif 'open' in message and 'website' in message:
        talk('Sure')
        reg_ex = re.search('open (.*) website', message)
        if reg_ex:
            domain = reg_ex.group(1).replace(" ", "")
            if '.com' not in domain:
                domain += ".com"
            url = 'https://www.' + domain
            webbrowser.open(url)
            talk("done")
        else:
            talk("not found")

    elif 'open' in message:
        reg_ex = re.search('open (.*)', message)
        app_name = ""
        try:
            if reg_ex:
                app_name = reg_ex.group(1)
                app_name1 = app_name + ".exe"
                subprocess.call(app_name1)
                talk("done")
            else:
                talk("not found")
        except FileNotFoundError:
            if '.com' not in app_name:
                app_name += ".com"
            url = 'https://www.' + app_name
            webbrowser.open(url)
            talk("done")

    elif 'tell me about' in message:
        reg_ex = re.search('tell me about (.*)', message)
        try:
            if reg_ex:
                topic = reg_ex.group(1)
                talk('How long?')
                length = given_command()
                talk(get_summary(topic, length))
        except Exception as e:
            talk(str(e))

    elif 'current weather' in message:
        reg_ex = re.search('current weather in (.*)', message)
        if reg_ex:
            talk(get_weather(reg_ex.group(1)))
        else:
            talk("not found")

    elif 'who is' in message:
        talk('Searching...')
        rex = re.search("who is (.*)", message)
        name = rex.group(1).replace(" ", "+")
        webbrowser.open('https://www.google.com/search?q=' + name)
        try:
            outputs = wikipedia.summary(message, sentences=3)
            talk('Gotcha')
            talk(outputs)

        except wikipedia.DisambiguationError:
            talk("Searching on google for " + message)
            webbrowser.open('https://www.google.co.il/search?q=' + message)

    elif 'email summary' in message:
        reg_ex = re.search('email summary (.*)', message)
        if reg_ex:
            topic = reg_ex.group(1)
            talk('How long?')
            length = given_command()
            content = get_summary(topic, length)
            msg = MIMEText(content)
            msg['To'] = "guymargalit24@gmail.com"
            msg['From'] = username
            msg['Subject'] = message
            server.sendmail(username, "guymargalit24@gmail.com", msg.as_string())
            talk("sent")
        else:
            talk("not found")

    elif 'email news' in message:
        page = BeautifulSoup(requests.get('https://www.ynet.co.il/home/0,7340,L-8,00.html').text,
                             features='html.parser')
        content = page.select_one('.title').get_text() + ':\n' + page.select_one('.sub-title').get_text() + '.\n '
        titles = page.select('.title')
        sub_titles = page.select('.sub_title.sub_title_no_credit')

        i = 0
        while i < len(sub_titles):
            content += '\n' + titles[i + 1].get_text() + ':\n' + sub_titles[i].get_text() + '.\n'
            i += 1

        msg = MIMEText(content)
        msg['To'] = "guymargalit24@gmail.com"
        msg['From'] = username
        msg['Subject'] = "News"
        server.sendmail(username, "guymargalit24@gmail.com", msg.as_string())
        talk("sent")

    elif "whats the error" in message:
        talk("Checking...")
        reg_ex = re.search("whats the error (.*)", message)
        error = reg_ex.group(1)
        links = ask_stack(error)
        links_amount = len(links)
        if links_amount == 0:
            talk("could not find anything about that")
        else:
            talk(f"I found {links_amount} questions about that on stackoverflow, how many do you want me to open?")
            index = get_number(links)
            for link in links[:index]:
                webbrowser.open(link)

    elif "news flash" in message:
        response = requests.get("https://www.theverge.com")
        page = BeautifulSoup(response.text, "html.parser")
        title_boxes = page.find_all("h2", {"class": "c-entry-box--compact__title"})
        articles = []
        for title_box in title_boxes:
            articles.append(title_box.findChildren("a")[0].text)
        talk(f"I found {len(articles)-1} articles, how many do you want?")
        talk(".\n".join(articles[:get_number(len(articles)):]))

    elif 'email' in message:
        talk('Who is the recipient? ')
        recipient = given_command()['transcription']

        if 'me' in recipient:
            try:
                talk('What should I say? ')
                content = given_command()['transcription']
                server.sendmail(username, "guymargalit24@gmail.com", content)
                talk('Email sent!')

            except Exception as e:
                print(type(e))
                talk('Sorry ! I am unable to send your message at this moment!')

    elif 'abort' in message or 'stop' in message or 'bye' in message:
        talk('Okay')
        talk('Bye, have a good day.')
        sys.exit()

    elif 'search for' in message:
        talk('Searching...')
        message = message.split("search for")[-1]
        message = message.replace(' ', '+')
        webbrowser.open('https://www.google.co.il/search?q=' + message)

    elif "repeat" in message:
        talk(latest)

    elif "should i watch" in message:
        talk("Checking...")
        reg_ex = re.search('should i watch (.*)', message)
        opinion = estimate_quality(reg_ex.group(1))
        if "bad" in opinion:
            opinion += ", so I don't recommend you watch it."
        else:
            opinion += ", so I recommend you watch it"
        talk(opinion)

    else:
        try:
            page = subprocess.getoutput('curl "https://miapi.pandorabots.com/talk" -H "Sec-Fetch-Mode: cors" -H '
                                        '"Referer: https://www.pandorabots.com/mitsuku/" -H "Origin: '
                                        'https://www.pandorabots.com" -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; '
                                        'Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 '
                                        'Safari/537.36" -H "Content-type: application/x-www-form-urlencoded" --data '
                                        f'"input={message}&sessionid={sessionID}&channel=6&botkey'
                                        '=n0M6dW2XZacnOgCWTp0FRYUuMjSfCkJGgobNpgPv9060_72eKnu3Yl-o1v2nFGtSXqfwJBG2Ros'
                                        '~&client_name=cw16d8c77ebdd"').split("\n")[-1]
            talk(eval(page)['responses'][0].replace("Mitsuku", "Jarvis").replace("Mitsuku", "Jarvis"))
        except UnicodeDecodeError:
            talk("Something went wrong, please try something else.")


def email_intruder(name):
    message = MIMEMultipart()
    with open(name, "rb") as attachment:
        part = MIMEBase("application", "octet-stream")
        part.set_payload(attachment.read())
        attachment.close()
    encoders.encode_base64(part)
    file_name = name.split('\\')
    file_name = file_name[-1]
    part.add_header(
        "Content-Disposition",
        f"attachment; filename= {file_name}")
    message.attach(part)
    msg = "Someone has tried to enter your program."
    msg = MIMEText(msg)
    message.attach(msg)
    message['To'] = "guymargalit24@gmail.com"
    message['From'] = username
    message['Subject'] = "Intrusion Detected"
    text = message.as_string()
    server.sendmail(username, "guymargalit24@gmail.com", text)
    return text

"""
server = smtplib.SMTP('smtp.gmail.com', 587)
server.ehlo()
server.starttls()
server.login("computer.server.email@gmail.com", '0101guymargalit')
username = 'computer.server.email@gmail.com'"""
ec.capture(0, "Face ID", "face.jpg")
if not is_guy("face.jpg"):
    email_intruder("face.jpg")
    while 1:
        if keyboard.is_pressed("ctrl+space"):
            ec.capture(0, "Face ID", "face.jpg")
            if is_guy("face.jpg"):
                break
            email_intruder("face.jpg")
latest = ""
speaker = win32com.client.Dispatch("SAPI.SpVoice")
greet_me()
recognizer = sr.Recognizer()
microphone = sr.Microphone()
page = subprocess.getoutput('curl "https://miapi.pandorabots.com/talk" -H "Sec-Fetch-Mode: cors" -H '
                                        '"Referer: https://www.pandorabots.com/mitsuku/" -H "Origin: '
                                        'https://www.pandorabots.com" -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; '
                                        'Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 '
                                        'Safari/537.36" -H "Content-type: application/x-www-form-urlencoded" --data '
                                        f'"input=xintro&sessionid=null&channel=6&botkey'
                                        '=n0M6dW2XZacnOgCWTp0FRYUuMjSfCkJGgobNpgPv9060_72eKnu3Yl-o1v2nFGtSXqfwJBG2Ros'
                                        '~&client_name=cw16d8c77ebdd"').split("\n")[-1]
sessionID = eval(page)['sessionid']
while 1:
    if keyboard.is_pressed("ctrl+space"):
        detected()
