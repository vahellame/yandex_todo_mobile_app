import 'dart:math';

import '../../../../core/constants/enums/todo_priority.dart';
import '../../models/todo/todo_model.dart';

class TodosState {
  List<TodoModel> todos = [];
  // List<TodoModel> todos = List.generate(
  //   100,
  //   (index) {
  //     final priorityIndex = Random().nextInt(TodoPriority.values.length);
  //     return TodoModel(
  //       text: String.fromCharCodes(List.generate(7, (index) => Random().nextInt(33) + 89)),
  //       priority: TodoPriority.values[priorityIndex],
  //       id: index,
  //     );
  //   },
  // );
}
