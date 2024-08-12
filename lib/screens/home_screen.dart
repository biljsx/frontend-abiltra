import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_todoapp/config/routes/routes.dart';
import 'package:flutter_todoapp/data/data.dart';
import 'package:flutter_todoapp/utils/utils.dart';
import 'package:flutter_todoapp/widgets/widgets.dart';
import 'package:gap/gap.dart';
import 'dart:ui';
import 'package:go_router/go_router.dart';
import 'package:flutter_todoapp/service/api_service.dart';

class HomeScreen extends StatefulWidget {
  static HomeScreen builder(BuildContext context, GoRouterState state) =>
      const HomeScreen();
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  void fetchTasks() async {
    try {
      final data = await apiService.getTasks();
      setState(() {
        tasks = data.map((item) => Task.fromJson(item)).toList();
      });
    } catch (e) {
      print('Failed to load tasks: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: deviceSize.height * 0.3, // Header Box
                width: deviceSize.width,
                color: colors.primary,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DisplayWhiteText(
                      text: 'Bismillah Bismillah Bismillah',
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                    DisplayWhiteText(
                      text: 'My Todo App',
                      fontSize: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 170,
            right: 0,
            left: 0,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DisplayListOfTasks(
                      tasks: tasks.where((task) => !task.isCompleted).toList(),
                    ),
                    const Gap(20),
                    const Text(
                      'Completed',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const Gap(20),
                    DisplayListOfTasks(
                      tasks: tasks.where((task) => task.isCompleted).toList(),
                      isCompletedTasks: true,
                    ),
                    const Gap(20),
                    ElevatedButton(
                      onPressed: () => context.push(RouteLocation.createTask),
                      child: const DisplayWhiteText(text: 'Add New Task'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}