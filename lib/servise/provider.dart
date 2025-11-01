import 'package:flutter/material.dart';
import '../model/model_class.dart';
import 'db_helper.dart';

class TodoProvider with ChangeNotifier {
  List<TodoModel> _list = [];

  List<TodoModel> get list => _list;

  Future<void> loadData() async {
    _list = await DbHelper().getTodos(); // ✅ readData না, getTodos
    notifyListeners();
  }

  Future<void> addData(TodoModel model) async {
    await DbHelper().insertTodo(model);
    await loadData();
  }

  Future<void> removeData(int id) async {
    await DbHelper().deleteTodo(id);
    await loadData();
  }

  Future<void> updateTodo(TodoModel model) async {
    await DbHelper().updateTodo(model);
    await loadData();
  }
}
