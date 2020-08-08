import 'dart:convert';

// import 'dart:io';

import 'package:flutter/services.dart';

Map<String, dynamic> driDev = {};
Map<String, dynamic> bravoLang = {};

Future<String> loadAssets() async {
  print("Loading");
  // await rootBundle.loadString('assets/bravolang.json');
  bravoLang = jsonDecode(await rootBundle.loadString('assets/bravolang.json'));
  // print("Loaded1");
  driDev = jsonDecode(await rootBundle.loadString('assets/dridev.json'));
  // await rootBundle.loadString('assets/driDev.json');
  print("Loaded2 ");
  return "abc";
}