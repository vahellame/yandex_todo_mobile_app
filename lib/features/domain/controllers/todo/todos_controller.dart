import '../../../../core/utils/logger.dart';
import '../../models/todo/todo_model.dart';
import '../controller.dart';
import 'todos_state.dart';

class TodosController extends Controller {
  TodosController(this._todosState);

  final TodosState _todosState;

  List<TodoModel> get todos =>
      _showDone ? _todosState.todos : _todosState.todos.where((e) => !e.isDone).toList();

  bool _showDone = true;
  bool get showDone => _showDone;
  int get todosIsDoneLength => _todosState.todos.where((e) => e.isDone).length;

  void switchShowDoneVisibility() {
    _showDone = !_showDone;
    notifyListeners();
  }

  void deleteTodo(int todoId) {
    Logger.i('TODO DELETED ${_todosState.todos.firstWhere((e) => e.id == todoId)}');
    _todosState.todos.removeWhere((e) => e.id == todoId);
    notifyListeners();
  }

  void switchTodoIsDone(int todoId) {
    Logger.i('TODO  ${_todosState.todos.firstWhere((e) => e.id == todoId)}');
    final index = _todosState.todos.indexWhere((e) => e.id == todoId);
    _todosState.todos[index] = _todosState.todos[index].copyWith(
      isDone: !_todosState.todos[index].isDone,
    );
    notifyListeners();
  }
}
