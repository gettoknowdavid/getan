import 'package:flutter/material.dart';

import '../../domain/entities/todo.dart';
import '../../domain/entities/todo_priority.dart';

class TodoPriorityWidget extends StatelessWidget {
  const TodoPriorityWidget({Key key, @required this.todo}) : super(key: key);
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final color = Colors.grey[300];

    return Row(
      children: List.generate(3, (index) {
        return index < value()
            ? _PriorityItem(todo: todo)
            : _PriorityItem(todo: todo, color: color);
      }),
    );
  }

  int value() {
    switch (todo.priority) {
      case TodoPriority.high:
        return 3;
      case TodoPriority.medium:
        return 2;
      case TodoPriority.low:
        return 1;
      default:
        return 0;
    }
  }
}

class _PriorityItem extends StatelessWidget {
  const _PriorityItem({Key key, this.todo, this.color = Colors.red})
      : super(key: key);

  final Todo todo;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final conSize = MediaQuery.of(context).size.shortestSide * 0.022;
    final radius = conSize * 0.35;

    return Container(
      height: conSize,
      width: conSize,
      margin: EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
        color: todo.isComplete ? color.withOpacity(0.2) : color,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
