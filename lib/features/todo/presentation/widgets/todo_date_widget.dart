import 'package:flutter/material.dart';

import '../../../../core/utils/format_date.dart';
import '../../domain/entities/todo.dart';

class TodoDateWidget extends StatelessWidget {
  const TodoDateWidget({
    Key key,
    @required this.todo,
    this.topPadding = 0.0,
  }) : super(key: key);

  final Todo todo;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Text(
        formatDate(context, todo.created),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodyText1.copyWith(
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
    );
  }
}
