import 'package:flutter/material.dart';
import 'package:flutter_todoapp/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:flutter_todoapp/service/api_service.dart'; // Import API Service

class CreateTaskScreen extends StatefulWidget {
  static CreateTaskScreen builder(BuildContext context, GoRouterState state) =>
      const CreateTaskScreen();
  const CreateTaskScreen({super.key});

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();
  String title = '';
  String category = '';
  DateTime? date;
  TimeOfDay? time;
  String note = '';

  void saveTask() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newTask = {
        'title': title,
        'category': category,
        'date': date?.toIso8601String(),
        'hour': time?.hour,
        'minute': time?.minute,
        'note': note,
        'isCompleted': false,
      };

      print('Task Data: $newTask');

      try {
        await apiService.addTask(newTask);
        Navigator.pop(context, true);
      } catch (e) {
        print('Failed to add task: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add task')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DisplayWhiteText(text: 'Add New Task'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CommonTextField(
                  title: 'Task Title',
                  hintText: 'Task Title',
                  onSaved: (value) => title = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const Gap(5),
                SelectCategory(
                  onSaved: (value) => category = value!,
                ),
                const Gap(5),
                SelectDateTime(
                  onDateSaved: (value) => date = value,
                  onTimeSaved: (value) => time = value,
                  dateValidator: (value) {
                    if (value == null) {
                      return 'Please select a date';
                    }
                    return null;
                  },
                  timeValidator: (value) {
                    if (value == null) {
                      return 'Please select a time';
                    }
                    return null;
                  },
                ),
                const Gap(5),
                CommonTextField(
                  title: 'Note',
                  hintText: 'Task Note',
                  maxLines: 6,
                  onSaved: (value) => note = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a note';
                    }
                    return null;
                  },
                ),
                const Gap(10),
                ElevatedButton(
                  onPressed: saveTask,
                  child: DisplayWhiteText(text: 'Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
