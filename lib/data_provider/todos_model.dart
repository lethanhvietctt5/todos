import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos/data_provider/todo_model.dart';

class TodosModel extends ChangeNotifier {
  final List<TodoModel> _listTodos = [];
  final List<TodoModel> _today = [];
  final List<TodoModel> _upcomming = [];

  TodosModel() {
    loadTodos();
  }

  get listTodos => _listTodos;
  get today => _today;
  get upcomming => _upcomming;

  void addTodo(TodoModel todo) async {
    _listTodos.add(todo);
    final prefs = await SharedPreferences.getInstance();
    var str = json.encode(_listTodos);
    prefs.setString("todos", str);
    sortList();
    notifyListeners();
  }

  void removeTodo(String id) {
    _listTodos.removeWhere((todo) => todo.id == id);
    sortList();
    notifyListeners();
  }

  void doneTodo(String id) {
    _listTodos.forEach((todo) {
      if (todo.id == id) {
        todo.isDone = true;
      }
    });
    sortList();
    notifyListeners();
  }

  void loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedJSON = prefs.getString('todos');

    if (encodedJSON != null) {
      var res = jsonDecode(encodedJSON);
      res.forEach((todo) {
        _listTodos.add(TodoModel.fromJson(todo));
      });
    }
    sortList();
    notifyListeners();
  }

  void sortList() {
    _listTodos.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    separate();
  }

  void separate() {
    _today.clear();
    _upcomming.clear();
    for (TodoModel todo in _listTodos) {
      if (todo.checkToday() == 0) {
        _today.add(todo);
      } else if (todo.checkToday() >= 1) {
        _upcomming.add(todo);
      }
    }
  }
}
