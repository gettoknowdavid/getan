import 'package:flutter/material.dart';
import 'package:getan/features/todo/domain/entities/todo_category.dart';

Color categoryColor(TodoCategory category) {
  switch (category) {
    case TodoCategory.personal:
      return Colors.purple;
    case TodoCategory.errands:
      return Colors.blue;
    case TodoCategory.work:
      return Colors.green;
    case TodoCategory.business:
      return Colors.black;
    case TodoCategory.home:
      return Colors.orange;
    default:
      return Colors.grey;
  }
}
