import sqlite3
from Crypto.Cipher import AES
import random
import base64
import math
import re
import json


conn = sqlite3.connect("com.bravolang.dictionary.indonesian.db")
cur = conn.cursor()

import itertools
def filter_nonprintable(ttt):
  return ttt.translate({c: None for c in itertools.chain(range(0x00,0x20),range(0x7f,0xa0))})

# 14 - Definition
# 99 - Definition
# 1 - Article
# 2 - Noun
# 3 - Verb
# 4 - Adjective
# 5 - Adverb
# 6 - Pronoun
# 7 - Preposition
# 8 - Conjunction
# 9 - Interjection
def decode_prop(n, str2):
  mapping = {
    14: "Definition1",
    99: "Definition",
    1: "Article",
    2: "Noun",
    3: "Verb",
    4: "Adjective",
    5: "Adverb",
    6: "Pronoun",
    7: "Preposition",
    8: "Conjunction",
    9: "Interjection"
  }

  if str2 == "0":
    return "0"

  n2 = int(n % 10)
  d2 = math.pow(10, int(math.log10(n)))
  # double d2 = Math.pow((double)10.0, (double)((int)Math.log10((double)(1.0 * d))));
  n3 = int(n / d2);
  n4 = int(str2[2:]) # Integer.parseInt((String)string2.substring(2));
  # print(n2, d2, n3, n4)
  return mapping[int((n4 - n3) / (n2 + 1))]

# Decoding Translation
def decode(txt, padd = 128):
  b = ""
  # print(len(txt))
  for i in range(len(txt)):
    if len(list(txt[i].encode('utf-8'))) == 2 and list(txt[i].encode('utf-8'))[0] == 195:
      # print("{}: '{}', {}, {}".format(i, txt[i], list(txt[i].encode('utf-8')), bytearray([list(txt[i].encode('utf-8'))[-1] + 64 - (i % padd)]).decode('utf-8')))
      b = b + bytearray([list(txt[i].encode('utf-8'))[-1] + 64 - i % padd]).decode('utf-8')
    else:
      # print("{}: '{}', {}, {}".format(i, txt[i], list(txt[i].encode('utf-8')), bytearray([list(txt[i].encode('utf-8'))[-1] - (i % padd)]).decode('utf-8')))
      b = b + bytearray([list(txt[i].encode('utf-8'))[-1] - i % padd]).decode('utf-8')
  # print("Padding: {}".format(padd))
  # return decode(txt, padd + 1)
  # print("Results: " + b)
  return decrypt(b)



def decrypt(data):
  aes = AES.new(b"jd6M*=cwhf4+xV@W", AES.MODE_ECB)
  encd = aes.decrypt(base64.b64decode(data.encode("utf-8")))
  return encd.decode("utf-8")


def get_word_defn(word):
  cur.execute("""
  SELECT explainOrder, english, translation FROM 'indWordList' ind 
  LEFT JOIN exampleList exa ON ind._id = exa.wordList_id 
  LEFT JOIN sentenceList sent ON exa.sentenceList_id = sent._id
  WHERE ind.displayWord = '{}'
  """.format(word))

  rows = cur.fetchall()
  names = [description[0] for description in cur.description]
  print(names)

  for row in rows:
    # print(row[3].encode())
    curr_row = dict(zip(names, row))
    # curr_row['posTypes'] = [decode_prop(curr_row['_id'], i) for i in curr_row['posTypes'].replace("\x02", "\x03").split("\x03")]
    curr_row['english'] = curr_row['english']
    curr_row['translation'] = filter_nonprintable(decode(curr_row['translation']))

    print(curr_row)
  # print(row[1], row[2].split('\x02'), len(row[3].split('\x03')))
  # print(row[0], row[1], row[2], row[3], decode(row[4]).strip())
  # print("{}: {}".format(row[0], decode(row[2]).strip()))

def get_words():
  cur.execute("SELECT _id, posTypes, displayWord, explanations FROM 'indWordList'")

  rows = cur.fetchall()
  names = [description[0] for description in cur.description]
  print(names)

  all_words = {}

  for row in rows:
    # print(row[3].encode())
    curr_row = dict(zip(names, row))
    curr_row['posTypes'] = [decode_prop(curr_row['_id'], i) for i in curr_row['posTypes'].replace("\x02", "\x03").split("\x03")]
    curr_row['explanations'] = [i.split("\x03") for i in curr_row['explanations'].split("\x02")]
    curr_row['defn'] = dict(zip(curr_row['posTypes'], curr_row['explanations']))
    

    displayWord = curr_row['displayWord']
    # for i in ['_id', 'displayWord', 'posTypes', 'explanations']:
    #   del curr_row[i]

    all_words[displayWord] = curr_row['defn']
  
  # with open('bravolang.dart', 'w') as f:
  #   f.write("var bravoLang = {};".format(json.dumps(all_words)))

  with open('bravolang.json', 'w') as f:
    f.write(json.dumps(all_words))

    # print(curr_row)
    # for i in curr_row['posTypes']:
    #   if not i in [1,2,3,4,5,6,7,8,9,99]:
    #     print(curr_row)
    #     break


# TODO: Saving all the word examples as a JSON
# get_word_defn('mengingat')
get_words()
