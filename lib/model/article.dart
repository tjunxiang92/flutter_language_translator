
import 'package:translator/translator.dart';

import '../global_vars.dart';

var testArticle = '''
Menurut Duterte saat ini negaranya tidak memiliki kemampuan untuk menentang China secara militer.

"Kita tidak bisa berperang," kata Duterte menambahkan seperti dikutip The Star pada Selasa (28/7).

Hal itu diutarakan Duterte di saat ketegangan di Laut China Selatan terus memanas belakangan, terutama antara China dan Amerika Serikat yang saling mengerahkan armada militernya untuk memperkuat pengaruh di perairan itu.

Belakangan, China terus memperkuat klaim historis atas hampir 90 persen wilayah Laut China Selatan dengan mengerahkan kapal-kapal ikan dan patrolinya ke perairan kaya sumber daya alam itu.

Agresivitas China di Laut China Selatan baru-baru ini bahkan sempat memicu friksi antara Vietnam, Malaysia, hingga Indonesia pada awal tahun ini ketika kapal ikan dan kapal patroli Tiongkok menerobos ZEE Indonesia di dekat Natuna.
''';

class Article {
  final translator = GoogleTranslator();
  final String content;
  final List<String> paragraphs;

  Article(this.content) : paragraphs = content.split('.').map((a) => '${a.trim()}.').toList()..removeWhere((a) => a == '.');

  getWords(String paragraph) {
    var words = RegExp(r"([a-zA-Z^0-9]+)").allMatches(paragraph).map((a) => a.group(0)).toList();

    List<String> splitted = [];
    int currIndex = 0;

    for (var i = 0; i < words.length; i++) {
      var newIndex = currIndex + paragraph.substring(currIndex).indexOf(words[i]);
      splitted.add(paragraph.substring(currIndex, newIndex));
      // splitted.add(" ");
      splitted.add(words[i]);
      currIndex = newIndex + words[i].length;    
    }

    splitted.add(paragraph.substring(currIndex));

    return {
      "words": words,
      "splitted": splitted
    };
  }

  Future<String> googleTranslate(String txt) async {
    // Call Google Translate API
    return (await translator.translate(txt, from: 'id', to: 'en')).text;
  }

  getDefinitions(String word) {
    return {
      "driDev": driDev[word],
      "bravoLang": bravoLang[word]
    };
    // print("driDev: ${driDev[word]}");
    // print("bravoLang: ${bravoLang[word]}");
  }


  factory Article.fromString(String txt) {
    var article = Article(txt);
    for (String i in article.paragraphs) {
      print("A: $i");
      print(article.getWords(i));
      print(article.getDefinitions(article.getWords(i)[0]));
    }

    // print(article.googleTranslate(article.paragraphs[0]));

    return article;
  }
}