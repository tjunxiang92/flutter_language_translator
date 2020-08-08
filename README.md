# Deploy Python on Heroku

Tags
```
"<ex>", "<mn>", "<syn>", "<ant>", "<ing>", "<v2>", "<v3>", "<plu>", "<com>", "<sup>"
"</ex>", "</mn>", "</syn>", "</ant>", "</ing>", "</v2>", "</v3>", "</plu>", "</com>", "</sup>"
```
https://jx-newspaper-retriever.herokuapp.com/api/v1/extract?url=<url>


https://shekhargulati.com/2019/05/18/building-an-article-extraction-python-api-with-newspaper3k-and-flask/
```
from newspaper import Article
url = 'https://haluankepri.com/2020/03/08/panglima-tni-dan-kapolri-ke-pulau-galang-pagi-ini/'
article = Article(url, language='id')
article.download()
article.html
article.parse()
article.authors
article.publish_date
article.text
article.top_image
article.movies
```

https://devtrik.com/python/text-preprocessing-dengan-python-nltk/
```
import nltk

kalimat ="""
BATAM (HK) – Panglima TNI, Marsekal Hadi Tjahjanto dan Kapolri Jendral Idham Aziz beserta rombongan dijadwalkan akan berkunjung ke Batam, Minggu (8/3).

“Kedatangan Panglima TNI dan Kapolri ke Batam dalam agenda kunjungan kerja,” kata Kadispen Lantamal IV, Mayor Marinir Saul Jamlaay, Sabtu (7/3/2020).

Dijadwalkan, rombongan akan tiba di Bandara Internasional Hang Nadim Batam sekitarpukul 19.15 Wib.

“Selanjutnya melalui jalur darat, rombongan menuju tempat Baksos di Kelurahan Sijantung, Galang untuk memberikan bingkisan kepada masyarakat sekitar secara simbolis,” ungkap Saul.

Usai itu, kata Saul, perjalanan dilanjutkan ke Camp Vietnam untuk memberikan pengarahan kepada prajurit TNI dan Polri dilanjutkan potong tumpeng dan makan siang bersama.

“Kemudian, pukul 14.00 Wib Panglima TNI dan Kapolri beserta rombongan bertolak ke Lanud Roesmin Nurjadin, Pekan Baru dalam agenda peluncuran Lancang Kuning Nusantara yang dilaksanakan esok harinya,” pungkasnya.

Diberitakan sebelumnya, Panglima TNI, Rabu (4/3) lalu, meninjau lokasi pembangunan Rumah Sakit khusus pasien Corona di Camp Vietnam eks pengungsi Vietnam, Pulau Galang. (bob)
"""
tokens = nltk.tokenize.word_tokenize(kalimat)
print(tokens)
```

>>> s = "Good muffins cost $3.88\nin New York.  Please buy me\n"
>>> ll = [[nltk.tokenize.word_tokenize(w), ' '] for w in s.split()]
>>> list(itertools.chain(*list(itertools.chain(*ll))))

https://github.com/gabrielpacheco23/google-translator
Google Translate
https://github.com/codelucas/newspaper

API Dictionary
http://kateglo.com/