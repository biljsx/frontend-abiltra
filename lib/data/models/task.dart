import 'package:equatable/equatable.dart';
import 'package:flutter_todoapp/utils/utils.dart';

class Task extends Equatable {
  final int? id;
  final String title;
  final String note;
  final String time;
  final String date;
  final TasksCategories category;
  final bool isCompleted;

  const Task({
    this.id,
    required this.title,
    required this.note,
    required this.time,
    required this.date,
    required this.category,
    required this.isCompleted,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      note: json['note'] ?? '',
      time: json['time'],
      date: json['date'],
      isCompleted: json['isCompleted'],
      category: TasksCategories.values.firstWhere(
        (e) => e.toString() == 'TasksCategories.' + json['category'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'note': note,
      'time': time,
      'date': date,
      'isCompleted': isCompleted,
      'category': category.toString().split('.').last,
    };
  }

  @override
  List<Object?> get props => [id!, title, note, time, date, isCompleted];
}
