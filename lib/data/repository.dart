import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/network_service.dart';
import 'dart:async';

class Repository {
  final NetworkService networkService;

  Repository({required this.networkService});
  Future<List<Todo>> fetchTodos() async {
    final todoRaw = await networkService.fetchTodos();

    return todoRaw.map((e) => Todo.fromJson(e)).toList();
  }

  Future<bool> changeCompletion(bool isComplete, int id) async {
    final patchObj = {"isComplete": isComplete.toString()};
    return await networkService.patchTodo(patchObj, id);
  }

  Future<Todo> addTodo(String message) async {
    final todoObj = {"todo": message, "isComplete": "false"};
    final todoMap = await networkService.addTodo(todoObj);
    return Todo.fromJson(todoMap!);
  }

  Future<bool> deleteTodo(int id) async {
    return await networkService.deleteTodo(id);
  }

  Future<bool> updateTodo(String message, int id) async {
    final patchObj = {"todo": message};
    return await networkService.patchTodo(patchObj, id);
  }
}
