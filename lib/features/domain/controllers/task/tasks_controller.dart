import '../../models/task_model/todo_model.dart';
import '../controller.dart';
import 'tasks_state.dart';

class TodosController extends Controller {
  TodosController(this._todosState);

  final TodosState _todosState;

  List<TodoModel> get todos => _todosState.todos;
}
