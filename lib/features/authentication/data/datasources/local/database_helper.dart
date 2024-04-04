import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../domain/model/user.dart';

class DatabaseHelper {
  Database? _database;

  Future<void> initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'my_database.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE user(id INTEGER PRIMARY KEY, username TEXT, email TEXT, password TEXT, telephone TEXT, establishment TEXT, post TEXT, cin TEXT)',
        );
      },
    );
  }

  Future<void> insertUser(User user) async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    await _database!.insert('my_table', user.toMap());
  }

  Future<List<User>> getUsers() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    final List<Map<String, dynamic>> maps = await _database!.query('my_table');
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        username: maps[i]['username'],
        password: maps[i]['password'],
        email: maps[i]['email'],
        telephone: maps[i]['telephone'],
        establishment: maps[i]['establishment'],
        post: maps[i]['post'],
        cin: maps[i]['cin'],
      );
    });
  }

  Future<User?> getFirstUser() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    List<Map<String, dynamic>> users = await _database!.query(
      'my_table',
      where: 'username = ?',
      whereArgs: ['Amir'],
      limit: 1,
    );

    if (users.isNotEmpty) {
      return User(
        id: users[0]['id'],
        username: users[0]['username'],
        password: users[0]['password'],
        email: users[0]['email'],
        telephone: users[0]['telephone'],
        establishment: users[0]['establishment'],
        post: users[0]['post'],
        cin: users[0]['cin'],
      );
    }

    return null; // Return null if no user with the name "Amir" is found
  }

  Future<bool> deleteAllUsers() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }

    int rowsDeleted = await _database!.delete('my_table'); // Delete all rows from the 'my_table' table

    return rowsDeleted > 0; // Return true if rows were deleted, false otherwise
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
    }
  }
}

Future<bool> deleteTokenFromStorage() async {
  final storage =   FlutterSecureStorage();

  String? value = await storage.read(key: 'access_token');
  if (value != null) {
    debugPrint('Connected') ;
    await storage.delete(key: 'access_token');
    String? tokenagain = await storage.read(key: 'access_token');
    debugPrint('Token is $tokenagain') ;

    return true; // Token successfully deleted
  } else {
    debugPrint('Disconnect') ;
    return false; // Token not found or deletion failed
  }
}
