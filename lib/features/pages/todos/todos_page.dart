import 'package:flutter/material.dart';

import '../../../core/constants/enums/todo_priority.dart';
import '../../../core/extensions/todo_priority_extension.dart';
import '../../../core/utils/controller_state_mixin.dart';
import '../../domain/controllers/todo/todos_controller.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage>
    with ControllerStateMixin<TodosPage, TodosController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(TodoPriority.high.text),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child: Text('$index', textScaleFactor: 5),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
