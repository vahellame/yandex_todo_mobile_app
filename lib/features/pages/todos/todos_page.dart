import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/extensions/build_context_extension.dart';
import '../../../core/l10n/generated/l10n.dart';
import '../../../core/ui_kit/scaffolds/safe_scaffold.dart';
import '../../../core/utils/controller_state_mixin.dart';
import '../../domain/controllers/todo/create_or_todo_controller.dart';
import '../../domain/controllers/todo/todos_controller.dart';
import '../todo_view/todo_view_page.dart';
import 'widgets/todo_list_item.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage>
    with ControllerStateMixin<TodosPage, TodosController> {
  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      padding: EdgeInsets.zero,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: true,
            backgroundColor: context.colors.backPrimary,
            scrolledUnderElevation: 0,
            expandedHeight: 124.0,
            actionsIconTheme: IconThemeData(
              size: 24,
              color: context.colors.blue,
            ),
            actions: [
              IconButton(
                onPressed: cr.switchShowDoneVisibility,
                icon: Icon(cw.showDone ? Icons.visibility_off : Icons.visibility),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  L10n.current.todosPageTitle,
                  style: context.styles.title.copyWith(
                    color: context.colors.labelPrimary,
                  ),
                ),
              ),
              titlePadding: EdgeInsets.zero,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 16),
              child: RichText(
                text: TextSpan(
                  style: context.styles.body.copyWith(
                    color: context.colors.labelTertiary,
                  ),
                  children: [
                    TextSpan(
                      text: L10n.current.todosPageIsDoneLengthLabel,
                    ),
                    const TextSpan(
                      text: ' - ',
                    ),
                    TextSpan(
                      text: '${cw.todosIsDoneLength}',
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: context.colors.backSecondary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: cw.todos.length + 1,
                (context, index) {
                  if (index == cw.todos.length) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TodoViewPage()),
                        );
                      },
                      child: Container(
                        color: context.colors.backSecondary,
                        height: 48,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              L10n.current.todosPageNewTodoLabel,
                              style: context.styles.body.copyWith(color: context.colors.labelTertiary),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  final todoId = cr.todos[index].id!;
                  return TodoListItem(
                    onDone: () => cr.switchTodoIsDone(todoId),
                    onDelete: () => cr.deleteTodo(todoId),
                    setIsDone: () => cr.switchTodoIsDone(todoId),
                    todo: cw.todos[index],
                  );
                },
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: context.colors.backSecondary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: context.colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TodoViewPage()),
          );
        },
        child: const Icon(
          Icons.add,
          size: 24,
        ),
      ),
    );
  }
}
