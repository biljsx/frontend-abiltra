import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todoapp/utils/utils.dart';

final categoryProvider = StateProvider.autoDispose<TasksCategories>((ref) {
  return TasksCategories.others;
});