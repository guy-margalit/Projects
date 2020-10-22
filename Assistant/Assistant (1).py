

class Assistant:
    def __init__(self, name: str, face_detect: bool=False, email: bool=False, auth: tuple=()):
        if self.has_email:
            self.email_auth = auth
            self.server = smtplib.SMTP('smtp.gmail.com', 587)
            self.server.ehlo()
            self.server.starttls()
            self.server.login(*auth)
        if face_detect:
            ec.capture(0, "Face ID", "face.jpg")
        if not is_guy("face.jpg"):
            self.email_intruder("face.jpg")
            while 1:
                if keyboard.is_pressed("ctrl+space"):
                    ec.capture(0, "Face ID", "face.jpg")
                    if is_guy("face.jpg"):
                        break
                    self.email_intruder("face.jpg")
        self.name = name
        self.has_email = email
        self.recognizer = sr.Recognizer()
        self.microphone = sr.Microphone()
        self.speaker = win32com.client.Dispatch("SAPI.SpVoice")


    def talk(self, text: str) -> str:
        print(self.name + ": " + text)
        self.speaker.Speak(text)

    def translate(self, phrase: str, lang: str) -> str:
        translator = Translator(to_lang=lang)
        translation = translator.translate(phrase)
        self.talk(translation)

    def set_timer(self, time: int) -> None:
        Timer(time, self.alarm, args="your %d timer is up" % time).start()
        self.talk("set")

    def open_website(self, domain: str) -> None:
        if '.com' not in domain:
            domain += ".com"
        url = 'https://www.' + domain
        webbrowser.open(url)
        self.talk("done")

    def open_program(self, app_name: str) -> None:
        try:
            app_name1 = app_name + ".exe"
            subprocess.call(app_name1)
            self.talk("done")
        except FileNotFoundError:
            if '.com' not in app_name:
                app_name += ".com"
            url = 'https://www.' + app_name
            webbrowser.open(url)
            self.talk("done")

    def small_talk(self, request: str) -> str:

    def email_intruder(self, name: str):
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
            "attachment; filename= " + file_name)
        message.attach(part)
        msg = "Someone has tried to enter your program."
        msg = MIMEText(msg)
        message.attach(msg)
        message['To'] = "guymargalit24@gmail.com"
        message['From'] = self.email_auth[0]
        message['Subject'] = "Intrusion Detected"
        text = message.as_string()
        server.sendmail(self.email_auth[0], "guymargalit24@gmail.com", text)
        return text

    def greet(self) -> None:
        current_hour = int(datetime.now().hour)
        if 0 <= current_hour < 12:
            self.talk('Good Morning!')
        elif 12 <= current_hour < 18:
            self.talk('Good Afternoon!')
        elif current_hour >= 18:
            self.talk('Good Evening!')

    def get_command(self) -> dict:
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

    def get_weather(self, location: str="") -> str:
        degree_sign = u'\N{DEGREE SIGN}'
        html = requests.get("https://www.google.com/search?q=weather " + location)
        page = BeautifulSoup(html.text, "html.parser")
        s = page.text.split(degree_sign)[0]
        return s[-2:] + degree_sign + "C"

    def get_news(self) -> str:
        message = ""
        html = requests.get("https://www.geektime.co.il")
        page = BeautifulSoup(html.text, "html.parser")
        articles = page.find_all("section", class_="post-details")
        for article in articles:
            contents = article.contents
            message += "{0}:\n{1}\n\n".format(contents[0].text, contents[2].text)
        return message

    def get_summary(self, subject: str, length: int) -> str:
        self.talk('In what language?')
        message = self.get_command()
        wikipedia.set_lang(message['transcription'][:2:])
        try:
            return wikipedia.summary(subject, sentences=int(length)).replace('. ', '.\n')
        except wikipedia.DisambiguationError:
            q = 'what do you mean?\n' + "\n".join(wikipedia.search(subject))
            self.talk(q)
            message = self.get_command()
            return self.get_summary(message['transcription'], length)

    def get_sentiment(self, text: str) -> int:
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

    def get_number(self, n: int) -> int:
        while 1:
            number = self.get_command()["transcription"]
            print("You: " + number)
            if number.is_digit():
                self.talk("great")
                return int(number)
            elif number == "all":
                return n
            elif number == "none":
                return 0
            else:
                self.talk("not a number. try again")

    def alarm(self, *tag) -> None:
        if not isinstance(tag, str):
            tag = "".join(tag)
        playsound("alarm.mp3", block=False)
        sg.Window('Timer').Layout([[sg.Text(tag, auto_size_text=True)]]).Read()

    def find_title(self, title: str) -> str:
        response = requests.get("https://www.imdb.com/find?ref_=nv_sr_fn&q=" + title.replace(' ', '+'))
        soup = BeautifulSoup(response.content, "html.parser")
        result_parent = soup.find("td", {"class": "result_text"})
        result = result_parent.findChildren("a")[0]
        return result['href']


    def find_reviews(self, title_link: str) -> list:
        response = requests.get("https://www.imdb.com%s?ref_=rvi_tt" % title_link)
        soup = BeautifulSoup(response.content, "html.parser")
        reviews = soup.find_all("div", {"class": "text show-more__control"})[:5]
        return [review.text[:100] for review in reviews]


    def get_rating(self, title_link: str) -> float:
        response = requests.get("https://www.imdb.com%s?ref_=rvi_tt" % title_link)
        soup = BeautifulSoup(response.content, "html.parser")
        rating = float(soup.find("span", {"itemprop": "ratingValue"}).text)
        return rating

    def estimate_quality(self, title: str) -> str:
        title_link = self.find_title(title)
        reviews = self.find_reviews(title_link)
        average_rating = self.get_rating(title_link)
        overall_sentiment = 0
        for review in reviews:
            overall_sentiment += self.get_sentiment(review)
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