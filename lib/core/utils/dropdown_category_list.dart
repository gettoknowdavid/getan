import 'package:flutter/material.dart';

import '../../features/todo/domain/entities/todo_category.dart';
import 'string_helpers.dart';

List<DropdownMenuItem<TodoCategory>> categories() {
  List<DropdownMenuItem<TodoCategory>> _items = [];

  for (TodoCategory category in TodoCategory.values) {
    _items.add(
      DropdownMenuItem(
        value: category,
        child: Text(
          category == null ? enumCase(TodoCategory.none) : enumCase(category),
        ),
      ),
    );
  }
  return _items.toList();
}
