import '../constants/enums/todo_priority.dart';
import '../l10n/generated/l10n.dart';

extension TodoPriorityExtension on TodoPriority {
  String get text {
    switch (this) {
      case TodoPriority.no:
        return L10n.current.todos_page_title;
      case TodoPriority.low:
        return L10n.current.todos_page_title;
      case TodoPriority.high:
        return L10n.current.todos_page_title;
    }
  }
}
