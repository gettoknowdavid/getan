import 'package:flutter/material.dart';

import '../../features/todo/domain/entities/todo_category.dart';
import 'string_helpers.dart';

List<PopupMenuEntry<TodoCategory>> items() {
  List<PopupMenuEntry<TodoCategory>> _items = [];

  for (TodoCategory category in TodoCategory.values) {
    _items.add(
      PopupMenuItem(
        child: Text(enumCase(category)),
        value: category,
      ),
    );
  }
  return _items.toList();
}
