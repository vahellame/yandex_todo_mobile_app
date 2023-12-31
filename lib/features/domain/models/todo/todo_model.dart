import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constants/enums/todo_priority.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@freezed
class TodoModel with _$TodoModel {
  const factory TodoModel({
    required String text,
    required TodoPriority priority,
    int? id,
    @Default(false) bool isDone,
    DateTime? deadline,
  }) = _TodoModel;

  factory TodoModel.empty() {
    return const TodoModel(
      text: '',
      priority: TodoPriority.low,
    );
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) => _$TodoModelFromJson(json);
}
