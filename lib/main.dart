import 'package:flutter/material.dart';
import 'package:flutter_article_translator/ArticleScreen.dart';
import 'package:flutter_article_translator/ImportScreen.dart';

import 'global_vars.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Future _future = loadAssets();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<String>(
        future: loadAssets(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            // return ArticleScreen();
            return ImportScreen();
          } else {
            return Scaffold(body: CircularProgressIndicator());
          }
        }
      )
    );
  }
}