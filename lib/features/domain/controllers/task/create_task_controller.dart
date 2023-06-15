import '../../../../core/constants/enums/todo_priority.dart';
import '../controller.dart';
import 'tasks_state.dart';

class CreateTodoController extends Controller {
  CreateTodoController(this._todosState);

  final TodosState _todosState;

  String _text = '';
  DateTime? _deadline;
  TodoPriority? _priority;

  void setText(String value) {
    _text = value;
  }

  void setDeadline(DateTime? value) {
    _deadline = value;
    notifyListeners();
  }

  void setPriority(TodoPriority value) {
    _priority = value;
    notifyListeners();
  }
}