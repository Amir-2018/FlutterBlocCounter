//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/model/user.dart';

class DatabaseHelper {
  Database? _database;
  Future<void> initializeDatabase() async {
    //sqfliteFfiInit();
    //databaseFactory = databaseFactoryFfi;
    if (_database == null) {
      debugPrint('I will create it for you');
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'chotrana.db');
      debugPrint('your path $path');

      _database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute(
              'CREATE TABLE Users (id INTEGER PRIMARY KEY, name TEXT, username TEXT, email TEXT)');
        },
      );
      debugPrint(' this is the databae${_database.toString()}');
    } else {
      debugPrint('The database is already existed');
    }
  }

  Future<void> insertUser(Map<String, dynamic> row) async {
    if (_database == null) {
      debugPrint('the database is null');
    } else {
      await _database?.transaction((txn) async {
        int id1 = await txn.rawInsert(
            'INSERT INTO Users(name, username, email) VALUES("amir", "mirouch", "amir.maalaoui@gmail.com")');
        print('inserted1: $id1');
        int id2 = await txn.rawInsert(
            'INSERT INTO Users(name, username, email) VALUES(?, ?, ?)',
            ['hamza', 'maalaoui', 'hamza@gmail.com']);
        print('inserted2: $id2');
      });
    }
  }

  Future<void> getUsers() async {
    List<Map> list = await _database!.rawQuery('SELECT * FROM Users');
    debugPrint("your list is $list");
  }
}
