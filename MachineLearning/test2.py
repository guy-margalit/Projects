"""
    Guy Margalit
"""
import random

letters = 'qwertyuiopasdfghjklzxcvbnm'
letters += letters.upper()
letters += '0123456789'
print(random.choices(letters, k=5))
