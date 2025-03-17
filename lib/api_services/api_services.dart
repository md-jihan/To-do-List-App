import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/get_all_todos.dart';
import '../models/todo_model.dart';

class ApiService {
  String baseUrl = "https://api.nstack.in";

  Future<GatAllTodosModel> getAllTodos() async {
    var response = await http.get(Uri.parse('$baseUrl/v1/todos'));

    if (response.statusCode == 200) {
      debugPrint(jsonDecode(response.body).toString());
      final data = GatAllTodosModel.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception("API Error");
    }
  }

  Future<TodoModel> addTodos(
    String title,
    String description,
    bool isCompleted,
  ) async {
    var response = await http.post(
      Uri.parse('$baseUrl/v1/todos'),
      headers: {"Content-Type": "application/json"},
      body: {
        jsonEncode({
          "title": title,
          "description": description,
          "is_completed": isCompleted,
        }),
      },
    );

    if (response.statusCode == 201) {
      debugPrint(jsonDecode(response.body).toString());
      final data = TodoModel.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception("API Error");
    }
  }

  Future<TodoModel> updateTodo(
    String id,
    String title,
    String description,
    bool isCompleted,
  ) async {
    var response = await http.put(
      Uri.parse('$baseUrl/v1/todos/$id'),
      headers: {"Content-Type": "application/json"},
      body: {
        {
          "title": title,
          "description": description,
          "is_completed": isCompleted,
        },
      },
    );

    if (response.statusCode == 200) {
      debugPrint(jsonDecode(response.body).toString());
      final data = TodoModel.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception("API Error");
    }
  }

  Future<GatAllTodosModel> deleteTodos(String id) async {
    var response = await http.delete(Uri.parse('$baseUrl/v1/todos/$id'));

    if (response.statusCode == 200) {
      debugPrint(jsonDecode(response.body).toString());
      final data = GatAllTodosModel.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception("API Error");
    }
  }
}
