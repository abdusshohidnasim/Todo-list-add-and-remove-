

import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/model_class.dart';


class DbHelper {
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'mydatabase.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE DatabaseTable (
          id INTEGER PRIMARY KEY,
          name TEXT,
          age TEXT
        )
        ''');
      },
    );
    return _database!;
  }

  // Insert data
  Future<void> insertData(ModelClass modelClass) async {
    final db = await database;
    await db!.insert('DatabaseTable', modelClass.toMap());
  }

  // Read all data
  Future<List<ModelClass>> readData() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db!.query('DatabaseTable');
    return result.map((e) => ModelClass.fromMap(e)).toList();
  }

  // Delete data
  Future<int> deleteData(int id) async {
    final db = await database;
    return await db!.delete('DatabaseTable', where: 'id = ?', whereArgs: [id]);
  }
}
