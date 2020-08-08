import 'package:flutter/material.dart';
import 'package:flutter_article_translator/archive/services/db.dart';
import 'package:flutter_article_translator/archive/services/debouncer.dart';

import 'models/dictionary.dart';

class DictionaryScreen extends StatefulWidget {
  final String intialWord;

  const DictionaryScreen([this.intialWord]);
  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  String search;
  Debouncer _debouncer;

  @override
  void initState() { 
    super.initState();
    _debouncer = Debouncer(milliseconds: 200);
    
    setState(() {
      search = widget.intialWord ?? '';
    });
      
    
  }

  Future<List<DictionaryItem>> getWord(word) async {
    List<Map<String, dynamic>> _results = await DB.db.query(DictionaryItem.table, limit: 50, where: 'LOWER(word) LIKE "%${word.toLowerCase()}%"');
    return _results.map((item) => DictionaryItem.fromMap(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Word Search"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: TextEditingController(text: search),
              decoration: InputDecoration(
                hintText: 'Enter a search term',
              ),
              onChanged: (e) => _debouncer.run(() => setState(() => search = e)),
              autofocus: true,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getWord(search),
              builder: (BuildContext context, AsyncSnapshot<List<DictionaryItem>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView(
                  children: snapshot.data.map<Widget>((e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Divider(height: 1.0),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 150.0,
                              child: Text(e.word)
                            ),
                            Expanded(child: Text(e.translation))
                          ],
                        ),
                      ],
                    ),
                  )).toList()
                );
              }
            )
          )
        ]
      ),
      
    );
  }
}