//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../domain/model/user.dart';
class DatabaseHelper {
  Database? _database;

  Future<void> initializeDatabase() async {
    //sqfliteFfiInit();
    //databaseFactory = databaseFactoryFfi;
    if (_database == null) {
      debugPrint('I will create it for you');
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'dbchotrana.db');
      debugPrint('your path $path');

      _database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute(
            'CREATE TABLE Users(id INTEGER PRIMARY KEY, username TEXT, email TEXT, password TEXT, telephone TEXT,establishment TEXT,post TEXT,cin TEXT)',
          );
        },
      );
      debugPrint(' this is the databae${_database.toString()}');
      //getUsers();
    } else {
      //deleteUsersTable() ;
      //debugPrint('Deleted with success');
      debugPrint('The database is already exist');
    }
  }

  Future<void> insertUser(User user) async {
    if (_database == null) {
      debugPrint('Cannot insert user the database is null');
    } else {
      await _database?.transaction((txn) async {
        int id1 = await txn.rawInsert(
            'INSERT INTO Users(username, email, password, telephone, establishment, post, cin) VALUES(\'${user
                .username}\', \'${user.email}\', \'${user.password}\', \'${user
                .telephone}\', \'${user.establishment}\', \'${user
                .post}\', \'${user.cin}\')');
        print('User inserted successfully with ID: $id1');
      });
    }
  }

  Future<void> getUsers() async {
    List<Map> list = await _database!.rawQuery('SELECT * FROM Users');
    debugPrint(list.toString());
  }

  Future<Map?> getFirstUser() async {
    List<Map> list = await _database!.rawQuery('SELECT * FROM Users');
    debugPrint(list.toString());

    if (list.isNotEmpty) {
      return list.first;
    }

    return null; // Return null if the list is empty
  }


}
