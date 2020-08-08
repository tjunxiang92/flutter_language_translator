import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_article_translator/archive/services/db.dart';

import 'dictionary.dart';
import 'models/dictionary.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var content = ["BATAM"," ","(","HK",")"," ","\u2013"," ","Panglima"," ","TNI",","," ","Marsekal"," ","Hadi"," ","Tjahjanto"," ","dan"," ","Kapolri"," ","Jendral"," ","Idham"," ","Aziz"," ","beserta"," ","rombongan"," ","dijadwalkan"," ","akan"," ","berkunjung"," ","ke"," ","Batam",","," ","Minggu"," ","(","8/3",")",".","\n\n","\u201c","Kedatangan"," ","Panglima"," ","TNI"," ","dan"," ","Kapolri"," ","ke"," ","Batam"," ","dalam"," ","agenda"," ","kunjungan"," ","kerja",",","\u201d"," ","kata"," ","Kadispen"," ","Lantamal"," ","IV",","," ","Mayor"," ","Marinir"," ","Saul"," ","Jamlaay",","," ","Sabtu"," ","(","7/3/2020",")",".","\n\n","Dijadwalkan",","," ","rombongan"," ","akan"," ","tiba"," ","di"," ","Bandara"," ","Internasional"," ","Hang"," ","Nadim"," ","Batam"," ","sekitarpukul"," ","19.15"," ","Wib",".","\n\n","\u201c","Selanjutnya"," ","melalui"," ","jalur"," ","darat",","," ","rombongan"," ","menuju"," ","tempat"," ","Baksos"," ","di"," ","Kelurahan"," ","Sijantung",","," ","Galang"," ","untuk"," ","memberikan"," ","bingkisan"," ","kepada"," ","masyarakat"," ","sekitar"," ","secara"," ","simbolis",",","\u201d"," ","ungkap"," ","Saul",".","\n\n","Usai"," ","itu",","," ","kata"," ","Saul",","," ","perjalanan"," ","dilanjutkan"," ","ke"," ","Camp"," ","Vietnam"," ","untuk"," ","memberikan"," ","pengarahan"," ","kepada"," ","prajurit"," ","TNI"," ","dan"," ","Polri"," ","dilanjutkan"," ","potong"," ","tumpeng"," ","dan"," ","makan"," ","siang"," ","bersama",".","\n\n","\u201c","Kemudian",","," ","pukul"," ","14.00"," ","Wib"," ","Panglima"," ","TNI"," ","dan"," ","Kapolri"," ","beserta"," ","rombongan"," ","bertolak"," ","ke"," ","Lanud"," ","Roesmin"," ","Nurjadin",","," ","Pekan"," ","Baru"," ","dalam"," ","agenda"," ","peluncuran"," ","Lancang"," ","Kuning"," ","Nusantara"," ","yang"," ","dilaksanakan"," ","esok"," ","harinya",",","\u201d"," ","pungkasnya",".","\n\n","Diberitakan"," ","sebelumnya",","," ","Panglima"," ","TNI",","," ","Rabu"," ","(","4/3",")"," ","lalu",","," ","meninjau"," ","lokasi"," ","pembangunan"," ","Rumah"," ","Sakit"," ","khusus"," ","pasien"," ","Corona"," ","di"," ","Camp"," ","Vietnam"," ","eks"," ","pengungsi"," ","Vietnam",","," ","Pulau"," ","Galang","."," ","(","bob",")"];
  var selected = [];

  @override
  void initState() {
    // refresh();
    super.initState();
  }

  Future<String> getWord(word) async {
    List<Map<String, dynamic>> _results = await DB.db.query(DictionaryItem.table, limit: 2, where: 'LOWER(word)="${word.toLowerCase()}"');
    var items = _results.map((item) => DictionaryItem.fromMap(item)).toList();
    return items[0].translation;
    // setState(() { });
  }


  // https://gist.github.com/Takhion/e48938fd865fc9be64ec28ad2f7063d0 - With Response
  // https://stackoverflow.com/questions/48914775/gesture-detection-in-flutter-textspan
  List<TextSpan> createTextSpans(){
    final arrayStrings = content;
    List<TextSpan> arrayOfTextSpan = [];
    for (int index = 0; index < arrayStrings.length; index++){
      final text = arrayStrings[index];
      final span = TextSpan(
        text: text,
        style: TextStyle(
          decoration: selected.contains(text)
            ? TextDecoration.underline
            : null,
        ),
        recognizer: TapGestureRecognizer()..onTap = () {
          if (text.length == 1)
            return;
          print("The word touched is $text");
          getWord(text.trim());
          setState(() {
            selected.contains(text)
              ? selected.remove(text)
              : selected.add(text);
          });
          print(selected);
        }
      );
      arrayOfTextSpan.add(span);
    }
    return arrayOfTextSpan;
  }
  void openSearch([text]) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DictionaryScreen(text)),
    );
  }

  Widget translationWidget(e) {
    return InkWell(
      onTap: () => openSearch(e),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Divider(height: 1.0),
            Row(
              children: <Widget>[
                Container(
                  width: 150.0,
                  child: Text(e)
                ),
                FutureBuilder(
                  future: getWord(e),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return Expanded(
                      child: Text(
                        snapshot.hasData
                          ? snapshot.data
                          : ""
                      ),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _showDialog() async {
    var ctrl = TextEditingController(text: "");
    var result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: ctrl,
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: 'Article URL', hintText: 'https://...'),
                ),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
            FlatButton(
              child: const Text('OPEN'),
              onPressed: () {
                Navigator.pop(context,);
              })
          ],
        );
      }
    );
    print("Done!");
    print(ctrl.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showDialog(),
          )
        ],
      ),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                text: 'Text:\n',
                style: TextStyle(
                  color: Colors.black,
                  // height: 1.2,
                  height: 1.5,
                  // letterSpacing: 1.0,
                ),
                children: createTextSpans(),
              ),
            ),
          ),
        ]..addAll(selected.reversed.map<Widget>((e) => translationWidget(e))
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () => openSearch(),
      ),
    );
  }
}
