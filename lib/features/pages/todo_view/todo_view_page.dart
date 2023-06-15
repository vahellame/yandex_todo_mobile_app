import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/enums/todo_priority.dart';
import '../../../core/extensions/build_context_extension.dart';
import '../../../core/extensions/datetime_extension.dart';
import '../../../core/extensions/todo_priority_extension.dart';
import '../../../core/l10n/generated/l10n.dart';
import '../../../core/utils/controller_state_mixin.dart';
import '../../domain/controllers/todo/create_or_todo_controller.dart';
import '../../domain/controllers/todo/todos_controller.dart';
import '../../domain/models/todo/todo_model.dart';
import '../todos/todos_page.dart';

class TodoViewPage extends StatefulWidget {
  const TodoViewPage({Key? key, this.todo}) : super(key: key);

  final TodoModel? todo;

  @override
  State<TodoViewPage> createState() => _TodoViewPageState();
}

class _TodoViewPageState extends State<TodoViewPage>
    with ControllerStateMixin<TodoViewPage, CreateOrUpdateTodoController> {
  @override
  void initState() {
    cr.setInitialTodo(widget.todo ?? TodoModel.empty());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colors.backPrimary,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        title: Row(
          children: [
            const Spacer(),
            TextButton(
              onPressed: () {
                cr.createOrUpdate();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const TodosPage()),
                );
              },
              child: Text(
                L10n.current.todoViewPageSaveButton,
                style: context.styles.button,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 6,
                ),
                const _TodoTextField(),
                const SizedBox(
                  height: 28,
                ),
                Text(
                  L10n.current.todoViewPagePriorityLabel,
                  style: context.styles.body.copyWith(color: context.colors.labelPrimary),
                ),
                DropdownButton(
                  underline: const SizedBox(),
                  icon: const SizedBox(),
                  value: cw.todo.priority,
                  items: TodoPriority.values
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: RichText(
                            text: TextSpan(
                              style: context.styles.body.copyWith(
                                color: e == TodoPriority.high
                                    ? context.colors.red
                                    : context.colors.labelPrimary,
                              ),
                              children: [
                                TextSpan(
                                  text: e == TodoPriority.high ? '!! ' : '',
                                ),
                                TextSpan(
                                  text: e.text,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    cr.setPriority(value ?? TodoPriority.no);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  color: context.colors.supportSeparator,
                  height: 1,
                  width: double.infinity,
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          L10n.current.todoViewPageDeadlineLabel,
                          style:
                              context.styles.subhead.copyWith(color: context.colors.labelPrimary),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          cw.todo.deadline != null
                              ? cw.todo.deadline!.toFormattedString('dd MMMM yyyy')
                              : '',
                          style: context.styles.subhead.copyWith(color: context.colors.blue),
                        ),
                      ],
                    ),
                    Switch(
                      value: cw.todo.deadline != null,
                      activeColor: context.colors.blue,
                      onChanged: (value) async {
                        if (value) {
                          final deadline = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            currentDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2077),
                          );
                          if (deadline != null) {
                            cr.setDeadline(deadline);
                          }
                        } else {
                          cr.setDeadline(null);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: context.colors.supportSeparator,
            height: 1,
            width: double.infinity,
          ),
          const SizedBox(
            height: 22,
          ),
          Row(
            children: [
              const SizedBox(width: 12),
              TextButton(
                onPressed: () {
                  if (cr.todo.id != null) {
                    context.read<TodosController>().deleteTodo(cr.todo.id!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TodosPage()),
                    );
                  }
                },
                child: SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color:
                            cw.todo.id != null ? context.colors.red : context.colors.labelDisable,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          L10n.current.todoViewPageDeleteButton,
                          style: context.styles.body.copyWith(
                            color: cw.todo.id != null
                                ? context.colors.red
                                : context.colors.labelDisable,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _TodoTextField extends StatelessWidget {
  const _TodoTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const OutlineInputBorder defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 4,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.06),
          ),
        ],
      ),
      width: double.infinity,
      child: TextFormField(
        initialValue: context.watch<CreateOrUpdateTodoController>().todo.text,
        onChanged: (value) => context.read<CreateOrUpdateTodoController>().setText(value),
        style: context.styles.body.copyWith(color: context.colors.labelPrimary),
        minLines: 3,
        maxLines: 30,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: 'Что надо сделать…',
          contentPadding: const EdgeInsets.all(16),
          isDense: false,
          filled: true,
          fillColor: context.colors.backSecondary,
          border: defaultBorder,
          focusedBorder: defaultBorder,
          enabledBorder: defaultBorder,
          errorBorder: defaultBorder,
          disabledBorder: defaultBorder,
        ),
      ),
    );
  }
}
