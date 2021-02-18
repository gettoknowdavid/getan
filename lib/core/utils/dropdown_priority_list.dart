import 'package:flutter/material.dart';

import '../../features/todo/domain/entities/todo_priority.dart';
import 'string_helpers.dart';

List<DropdownMenuItem<TodoPriority>> priorities() {
  List<DropdownMenuItem<TodoPriority>> _items = [];

  for (TodoPriority priority in TodoPriority.values) {
    _items.add(
      DropdownMenuItem(
        value: priority,
        child: Text(
          priority == null ? enumCase(TodoPriority.none) : enumCase(priority),
        ),
      ),
    );
  }
  return _items.toList();
}
