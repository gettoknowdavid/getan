import 'package:flutter/material.dart';

import '../../../../core/utils/format_date.dart';
import '../../domain/entities/todo.dart';

class TodoDateWidget extends StatelessWidget {
  const TodoDateWidget({Key key, @required this.todo}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      formatDate(context, todo.created),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: theme.textTheme.bodyText1.copyWith(color: Colors.grey),
    );
  }
}
