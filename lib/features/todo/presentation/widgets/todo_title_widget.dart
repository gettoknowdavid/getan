import 'package:flutter/material.dart';

import '../../domain/entities/todo.dart';
import 'todo_priority_widget.dart';

class TodoTitleWidget extends StatelessWidget {
  const TodoTitleWidget({Key key, @required this.todo}) : super(key: key);
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final mainStyle = theme.textTheme.headline6;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LimitedBox(
          maxWidth: width * 0.5,
          child: Text(
            todo.title.trim(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: mainStyle.copyWith(
              color: todo.isComplete ? Colors.grey[500] : mainStyle.color,
              decoration: todo.isComplete
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
        ),
        SizedBox(width: 6),
        TodoPriorityWidget(todo: todo),
      ],
    );
  }
}
