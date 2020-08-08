import 'dart:convert';
import 'model.dart';

class DictionaryItem extends Model {
  static String table = 'ind_dictionary';

  final int id;
  final String word;
  // final List<int> translation;
  final String translation;
  final String relatedWords;

  DictionaryItem({this.id, this.word, this.translation, this.relatedWords});

  static String convertString(String word, List<int> arr) {
    List<int> arrby = utf8.encode(word);
    int n2 = 0;
    do {
      int n3;
      int n4;
      int n5;
      if (n2 >= arr.length) break;
      n4 = arr[n2];
      if (n4 < 0) n4 += 256;
      n5 = arrby[-1 + arrby.length - n2 % arrby.length];
      if (n5 < 0) n5 += 256;

      n3 = n4 - n5;
      if (n3 < 0) n3 += 256;
      arr[n2] = n3;
      ++n2;
    } while (true);

    return new String.fromCharCodes(arr);
  }

  Map<String, dynamic> toMap() {
    // Map<String, dynamic> map = {'task': task, 'complete': complete};

    // if (id != null) {
    //   map['id'] = id;
    // }
    // return map;
  }

  static DictionaryItem fromMap(Map<String, dynamic> map) {
    return DictionaryItem(
      id: map['_id'],
      word: map['word'],
      translation: convertString(map['word'], map['translation']),
      relatedWords: map['related_words'],
    );
  }

  @override
  String toString() {
    return this.word + ": " + this.translation;
    // if (this.word == "abdis") 
    // return this.word + ": " + this.translation.toString();
    // else
    // return "";
  }
}
