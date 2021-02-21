import 'package:flutter/material.dart';

import '../../domain/entities/todo.dart';

class TodoDescriptionWidget extends StatelessWidget {
  const TodoDescriptionWidget({Key key, @required this.todo}) : super(key: key);
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      todo.description.trim(),
      maxLines: 1,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: theme.textTheme.subtitle1.copyWith(
        color: Colors.grey[600],
      ),
    );
  }
}
