"""
    Guy Margalit
"""
from selenium import webdriver
from time import sleep
from InstagramAPI import InstagramAPI
import random


letters = 'qwertyuiopasdfghjklzxcvbnm'
letters += letters.upper()
letters += '0123456789'
first_names = ['guy', 'ben', 'ariel', 'ori', 'daniela', 'roy', 'sean', 'yonatan', 'jonathan', 'paul', 'john', 'keren', 'doron', 'yael', 'dan', 'edan', 'yuval']
last_names = ['riber', 'margalit', 'abrahami', 'vitale', 'bezalel', 'ben avi', 'davis', 'johnson', 'obama', 'trump', 'kennedy', 'washington', 'lincoln', 'levi']
driver = webdriver.Chrome(r"C:\Users\guyma\OneDrive\מסמכים\chromedriver.exe")
i = 0
while True:
    driver.get('https://generator.email/')
    sleep(1)
    email = driver.find_element_by_xpath('//*[@id="email_ch_text"]').text
    driver.get('https://www.instagram.com/accounts/emailsignup/')
    sleep(1)
    name = random.choice(first_names) + " " + random.choice(last_names)
    username = 'a' + ''.join(random.choices(letters, k=8))
    password = ''.join(random.choices(letters, k=14))
    email_input = driver.find_element_by_xpath('//*[@id="react-root"]/section/main/div/article/div/div[1]/div/form/div[3]/div/label/input')
    email_input.send_keys(email)
    name_input = driver.find_element_by_xpath('//*[@id="react-root"]/section/main/div/article/div/div[1]/div/form/div[4]/div/label/input')
    name_input.send_keys(name)
    password_input = driver.find_element_by_xpath('//*[@id="react-root"]/section/main/div/article/div/div[1]/div/form/div[6]/div/label/input')
    password_input.send_keys(password)
    username_input = driver.find_element_by_xpath('//*[@id="react-root"]/section/main/div/article/div/div[1]/div/form/div[5]/div/label/input')
    username_input.send_keys(username)
    signup_button = driver.find_element_by_xpath('//*[@id="react-root"]/section/main/div/article/div/div[1]/div/form/div[7]/div/button')
    signup_button.click()
    sleep(2)
    api = InstagramAPI(username, password)
    api.login()
    api.follow("look_.bio")
    i += 1
    print(i, "followers")
