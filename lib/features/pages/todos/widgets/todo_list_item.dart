import 'package:flutter/material.dart';

import '../../../../core/constants/enums/todo_priority.dart';
import '../../../../core/extensions/build_context_extension.dart';
import '../../../domain/models/todo/todo_model.dart';
import '../../todo_view/todo_view_page.dart';

class TodoListItem extends StatefulWidget {
  const TodoListItem({
    required this.onDone,
    required this.onDelete,
    required this.setIsDone,
    required this.todo,
    super.key,
  });

  final VoidCallback onDone;
  final VoidCallback onDelete;
  final VoidCallback setIsDone;
  final TodoModel todo;

  @override
  State<TodoListItem> createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  late double _shift = 0;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 84,
          minHeight: 48,
        ),
        child: Container(
          color: context.colors.green,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: _shift * MediaQuery.of(context).size.width - 8 * 2 - 24 * 3 > 0
                    ? _shift * MediaQuery.of(context).size.width - 8 * 2 - 24 * 3
                    : 0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Icon(
                  widget.todo.isDone ? Icons.arrow_back_rounded : Icons.check,
                  size: 24,
                  color: context.colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      onUpdate: (details) {
        _shift = details.progress;
        setState(() {});
      },
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          widget.onDone();
          return false;
        } else {
          return true;
        }
      },
      secondaryBackground: Container(
        color: context.colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete,
              size: 24,
              color: context.colors.white,
            ),
            SizedBox(
              width: _shift * MediaQuery.of(context).size.width - 8 * 2 - 24 * 3 > 0
                  ? _shift * MediaQuery.of(context).size.width - 8 * 2 - 24 * 3
                  : 0,
            ),
          ],
        ),
      ),
      key: ValueKey(widget.todo.id),
      child: Container(
        height: 48,
        width: double.infinity,
        color: context.colors.backSecondary,
        child: Row(
          children: [
            Theme(
              data: ThemeData(
                checkboxTheme: CheckboxThemeData(
                  side: BorderSide(
                    color: widget.todo.priority == TodoPriority.high
                        ? context.colors.red
                        : context.colors.supportSeparator,
                    width: 2,
                  ),
                  fillColor: MaterialStateColor.resolveWith(
                    (states) {
                      if (states.contains(MaterialState.selected)) {
                        return context.colors.green; // Selected checkbox color
                      }
                      return context.colors.supportSeparator; // Unselected checkbox color
                    },
                  ),
                ),
              ),
              child: Checkbox(
                value: widget.todo.isDone,
                onChanged: (_) {
                  widget.setIsDone();
                },
              ),
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: context.styles.body.copyWith(
                    color: widget.todo.isDone
                        ? context.colors.labelTertiary
                        : context.colors.labelPrimary,
                    decoration: widget.todo.isDone ? TextDecoration.lineThrough : null,
                  ),
                  children: [
                    TextSpan(
                      text: !widget.todo.isDone && widget.todo.priority == TodoPriority.high
                          ? '!! '
                          : '',
                      style: context.styles.title.copyWith(color: context.colors.red),
                    ),
                    TextSpan(
                      text: widget.todo.text,
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TodoViewPage(todo: widget.todo)),
                );
              },
              icon: const Icon(
                Icons.info_outlined,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          widget.onDelete();
        }
      },
    );
  }
}
