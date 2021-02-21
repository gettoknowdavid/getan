import 'package:flutter/material.dart';
import 'package:getan/core/utils/string_helpers.dart';
import 'package:getan/core/utils/todo_category_to_color.dart';
import 'package:getan/features/todo/domain/entities/todo.dart';

class TodoCategoryWidget extends StatelessWidget {
  const TodoCategoryWidget({Key key, @required this.todo}) : super(key: key);
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: categoryColor(todo.category),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
        child: Text(
          enumCase(todo.category),
          style: Theme.of(context).textTheme.bodyText1.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
