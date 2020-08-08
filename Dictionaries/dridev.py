import json
import sqlite3
from Crypto.Cipher import AES
import random
import base64
conn = sqlite3.connect("com.dridev.kamusku.db")
cur = conn.cursor()
cur.execute("SELECT * FROM 'ind_dictionary'")

rows = cur.fetchall()

def decode(word, trans):
  word = str.encode(word)
  trans = bytearray(trans)

  n2 = 0
  while True:
    if n2 >= len(trans): break
    n4 = trans[n2];
    if (n4 < 0): n4 += 256;
    n5 = word[-1 + len(word) - n2 % len(word)]
    if (n5 < 0): n5 += 256;

    n3 = n4 - n5;
    if (n3 < 0): n3 += 256;
    trans[n2] = n3;
    n2 += 1;

  return trans.decode("utf-8")

toJson = {}

for row in rows:
  toJson[row[1]] = {
    "translation": decode(row[1], row[2]),
    "related_words": row[3]
  }
  # print("{}: {}, {}".format(row[1], decode(row[1], row[2]), row[3]))

# with open('dridev.dart', 'w') as f:
#   f.write("var driDev = {};".format(json.dumps(toJson).replace("$", "\\$")))

with open('dridev.json', 'w') as f:
  f.write(json.dumps(toJson))
