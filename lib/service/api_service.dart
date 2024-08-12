import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://ef4f-180-248-47-126.ngrok-free.app/api-docs';

  Future<void> addTask(Map<String, dynamic> task) async {
    try {
      final response = await http.post(
        Uri.parse('https://ef4f-180-248-47-126.ngrok-free.app/api/products/post'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(task),
      );

      if (response.statusCode != 201) {
        print('Failed to add task: ${response.body}');
        throw Exception('Failed to add task');
      }
    } catch (e) {
      print('Exception caught: $e');
      throw Exception('Failed to add task: $e');
    }
  }
  

  Future<List<Map<String, dynamic>>> getTasks() async {
    final response = await http.get(Uri.parse('https://ef4f-180-248-47-126.ngrok-free.app/api/products/get'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load tasks: ${response.body}');
    }

    final List<dynamic> tasksJson = jsonDecode(response.body);
    return tasksJson.map((task) => task as Map<String, dynamic>).toList();
  }


  Future<void> updateTask(String id, Map<String, dynamic> task) async {
    final response = await http.put(
      Uri.parse('https://ef4f-180-248-47-126.ngrok-free.app/api/products/put/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(task),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update task: ${response.body}');
    }
  }
  

  Future<void> deleteTask(String id) async {
    final response = await http.delete(Uri.parse('https://ef4f-180-248-47-126.ngrok-free.app/api/products/delete/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete task: ${response.body}');
    }
  }
}
