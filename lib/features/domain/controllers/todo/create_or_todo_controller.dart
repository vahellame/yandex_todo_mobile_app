import '../../../../core/constants/enums/todo_priority.dart';
import '../../models/todo/todo_model.dart';
import '../controller.dart';
import 'todos_state.dart';

class CreateOrUpdateTodoController extends Controller {
  CreateOrUpdateTodoController(this._todosState);

  final TodosState _todosState;

  late TodoModel _todo;

  TodoModel get todo => _todo;

  void setText(String value) {
    _todo = _todo.copyWith(text: value);
  }

  void setDeadline(DateTime? value) {
    _todo = _todo.copyWith(deadline: value);
    notifyListeners();
  }

  void setPriority(TodoPriority value) {
    _todo = _todo.copyWith(priority: value);
    notifyListeners();
  }

  void setInitialTodo(TodoModel todo) {
    _todo = todo;
  }

  void createOrUpdate() {
    if (_todo.id == null) {
      _todosState.todos.add(_todo.copyWith(id: _todosState.todos.length + 1));
    } else {
      final index = _todosState.todos.indexWhere((e) => e.id == _todo.id!);
      _todosState.todos[index] = _todo;
    }
  }
}
