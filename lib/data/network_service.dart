import 'dart:convert';

import 'package:http/http.dart';
import 'package:todo_app/constants/strings.dart';

class NetworkService {
  // final baseUrl = "http://10.0.2.2:3000";
  final baseUrl = "http://192.168.1.5:3000";
  Future<List<dynamic>> fetchTodos() async {
    try {
      final response = await get(Uri.parse(baseUrl + "/todos"));
      print(response.body);
      return jsonDecode(response.body) as List;
    } catch (e) {
      return [];
    }
  }

  Future<bool> patchTodo(Map<String, String> patchObj, int id) async {
    try {
      await patch(Uri.parse(baseUrl + "/todos/$id"), body: patchObj);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map?> addTodo(Map<String, String> todoObj) async {
    try {
      final response = await post(Uri.parse(baseUrl + "/todos"), body: todoObj);
      return jsonDecode(response.body);
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteTodo(int id) async {
    try {
      final response =
          await delete(Uri.parse(baseUrl + "/todos/$id"), body: id);
      return true;
    } catch (e) {
      return false;
    }
  }
}
