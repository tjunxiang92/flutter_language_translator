
// Mock Class to prevent errors
class DB {
  static DB get db => DB();

  static init() { }

  // var db = class Db {
  Future<List> query(var1, {limit, where}) {
    return null;
  }
}

// Commented away as it requires the SQLite Library
/* 
import 'dart:async';
import 'package:flutter_article_translator/archive/models/model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';

abstract class DB {

    static Database _db;

    static Database get db => _db;

    static Future<void> init() async {
      if (_db != null) { return; }

      try {
        var databasesPath = await getDatabasesPath();
        var path = join(databasesPath, "kamus.db");

        // Check if the database exists
        var exists = await databaseExists(path);

        if (!exists) {
          // Should happen only the first time you launch your application
          print("Creating new copy from asset");

          // Make sure the parent directory exists
          try {
            await Directory(dirname(path)).create(recursive: true);
          } catch (_) {}
            
          // Copy from asset
          ByteData data = await rootBundle.load(join("assets", "kamus.db"));
          List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
          
          // Write and flush the bytes written
          await File(path).writeAsBytes(bytes, flush: true);

        } else {
          print("Opening existing database");
        }
        // open the database
        _db = await openDatabase(path, readOnly: true);
      } catch(ex) { 
        print(ex);
      }
    }

    static Future<List<Map<String, dynamic>>> query(String table) async => _db.query(table);

    static Future<int> insert(String table, Model model) async =>
        await _db.insert(table, model.toMap());
    
    static Future<int> update(String table, Model model) async =>
        await _db.update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

    static Future<int> delete(String table, Model model) async =>
        await _db.delete(table, where: 'id = ?', whereArgs: [model.id]);
}
*/