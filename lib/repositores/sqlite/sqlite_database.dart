import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

Map<int, String> scripts = {
  1 : '''CREATE TABLE tarefas (id INTEGER PRIMARY KEY AUTOINCREMENT, descricao TEXT, concluido INTEGER);'''
};

class SQLiteDatabase {

  static Database? db;

  Future<Database> getDatabase() async {
    if (db == null) {
      return await iniDataBase();
    } else {
      return db!;
    }
  }

  Future iniDataBase() async {
    var db = await openDatabase(
        path.join(await getDatabasesPath(), 'database.db'),
        version: scripts.length,
        onCreate: (Database db, int version) async {
          for (var i = 1; i <= scripts.length; i++) {
            var sql = scripts[i]!;
            await db.execute(sql);
            debugPrint('onCreate: $sql');
          }
        },
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
          for (var i = oldVersion; i <= scripts.length; i++) {
            var sql = scripts[i]!;
            await db.execute(sql);
            debugPrint('onUpgrade: $sql');
          }
        }
    );

    return db;
  }
}