import 'package:flutter/material.dart';
import 'package:flutter_article_translator/model/article.dart';

import 'global_vars.dart';

class ArticleScreen extends StatelessWidget {
  final String content;
  // final article = Article.fromString(testArticle);
  final Article article;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  
  ArticleScreen(this.content) : article = Article.fromString(content);

  googleTranslate(sentence) {
    _key.currentState.showBottomSheet<void>(
      (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(width: double.infinity, height: 1.0),
              Align(alignment: Alignment.topRight, child: IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.pop(context))),
              Text('Sentence', style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
              Text(sentence),
              Text(" "),
              Text('Translation', style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
              // Text("Accoriding to Duterte")
              FutureBuilder(
                future: article.googleTranslate(sentence),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data);
                  } else {
                    return CircularProgressIndicator();
                  }
                }
              ),
            ],
          ),
        );
      },
      elevation: 10.0,
    );
  }
  
  void showWordDefn(String word){
    var defn = article.getDefinitions(word.toLowerCase());
    var driDev = defn['driDev'];
    Map bravoLang = defn['bravoLang'];

    _key.currentState.showBottomSheet<void>(
      (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(width: double.infinity, height: 1.0),
              Align(alignment: Alignment.topRight, child: IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.pop(context))),
              Text(word, style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
              Container(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Column(
                    children: [
                      Text("driDev", style: TextStyle(fontWeight: FontWeight.bold)),
                      driDev == null ?
                        Container() :
                        Column(
                          children: [
                            Text("Definition", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(driDev['translation'].toString().split("><").join(">\n<")),
                            Text("Related Words", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(driDev['related_words'].toString()),
                          ],
                        ),
                    ],
                  )),
                  Align(alignment: Alignment.center, child: Container(width: 1.0, height: 80.0, color: Colors.grey)),
                  Expanded(child: Column(
                    children: [
                      Text("bravoLang", style: TextStyle(fontWeight: FontWeight.bold)),
                    ]..addAll(
                      bravoLang?.keys?.map((e) => Column(
                        children: [
                          Text(e, style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(bravoLang[e].join(', ')),
                        ],
                      ))
                    ),
                  )),
                ],
              )

            ]
          )
        );
      },
      elevation: 10.0,
    );
  }



  Widget renderSentence(Map sentence) {
    List<String> words = sentence['words'];
    List<String> splitted = sentence['splitted'];

    return Wrap(
      children: splitted.map<Widget>((word) {
        Widget widget = Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(word),
        );

        if (words.contains(word)) {
          widget = InkWell(
            onTap: () => showWordDefn(word),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: widget
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: widget
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Article"),
        actions: [
          IconButton(icon: Icon(Icons.g_translate), onPressed: () => googleTranslate(article.content))
        ],
      ),
      body: ListView.separated(
        itemCount: article.paragraphs.length,
        separatorBuilder: (BuildContext context, int i) => Container(height: 1.0, color: Colors.grey),
        itemBuilder: (BuildContext context, int i) {
          var sentence = article.paragraphs[i];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Expanded(child: renderSentence(article.getWords(sentence))),
              IconButton(icon: Icon(Icons.g_translate), onPressed: () => googleTranslate(sentence))
            ]),
          );
        },
      )
    );
  }
}