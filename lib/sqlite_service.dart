import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SqliteService {

  Future<Database> initializeDB() async {
    // gets the default database location.
    WidgetsFlutterBinding.ensureInitialized();
    String path = await getDatabasesPath();
    // accepts a mandatory String as an argument that is the path of the database.
    return openDatabase(
      join(path, 'chotrana.db'),
      // onCreate() callback: It will be called when the database is created for the first time,
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE users(id INTEGER PRIMARY KEY, username TEXT, email TEXT, password TEXT, telephone TEXT,establishment TEXT,post TEXT,cin TEXT,)',
        );
      },
      version: 1,
    );
  }

}

