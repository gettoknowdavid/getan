import 'package:flutter/material.dart';

import '../../domain/entities/todo.dart';

class TodoDescriptionWidget extends StatelessWidget {
  const TodoDescriptionWidget({Key key, @required this.todo}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return todo.isComplete || todo.description.isEmpty
        ? Container()
        : Text(
            todo.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.subtitle1.copyWith(
              fontSize: 17,
              color: Colors.grey[600],
            ),
          );
  }
}
