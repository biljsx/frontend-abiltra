import 'package:flutter/material.dart';
import 'package:flutter_todoapp/app/todo_app.dart';
import 'package:flutter_todoapp/screens/home_screen.dart';
import 'package:flutter_todoapp/screens/create_task_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: TodoApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        '/create': (context) => CreateTaskScreen(),
      },
    );
  }
}