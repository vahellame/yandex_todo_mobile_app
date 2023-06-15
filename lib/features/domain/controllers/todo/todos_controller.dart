import '../../models/todo/todo_model.dart';
import '../controller.dart';
import 'todos_state.dart';

class TodosController extends Controller {
  TodosController(this._todosState);

  final TodosState _todosState;

  List<TodoModel> get todos => _todosState.todos;
}
