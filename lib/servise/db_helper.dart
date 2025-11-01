import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


import '../model/model_class.dart';

class DbHelper {
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'todo.db');

    _database = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE todos(
            id INTEGER PRIMARY KEY,
            title TEXT,
            description TEXT,
            isDone INTEGER
          )
        ''');
      },
    );

    return _database!;
  }

  Future<void> insertTodo(TodoModel todo) async {
    final db = await database;
    await db!.insert('todos', todo.toMap());
  }

  Future<List<TodoModel>> getTodos() async {
    final db = await database;
    final result = await db!.query('todos', orderBy: 'id DESC');
    return result.map((e) => TodoModel.fromMap(e)).toList();
  }

  Future<void> deleteTodo(int id) async {
    final db = await database;
    await db!.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateTodo(TodoModel todo) async {
    final db = await database;
    await db!.update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }
}
