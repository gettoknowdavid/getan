import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'todo_category.dart';
import 'todo_list_type.dart';
import 'todo_priority.dart';

class Todo extends Equatable {
  final String id;
  final String title;
  final String description;
  final TodoCategory category;
  final TodoPriority priority;
  final TodoListType type;
  final bool isComplete;
  final String created;

  Todo({
    this.id,
    @required this.title,
    this.description,
    TodoCategory category,
    TodoListType type,
    TodoPriority priority,
    this.isComplete,
    this.created,
  })  : category = category ?? TodoCategory.none,
        type = type ?? TodoListType.todo,
        priority = priority ?? TodoPriority.none,
        assert(title != null);

  Todo copyWith({
    String id,
    String title,
    String desctiption,
    TodoCategory category,
    TodoListType type,
    TodoPriority priority,
    bool isComplete,
    String created,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      isComplete: isComplete ?? this.isComplete,
      created: created ?? this.created,
    );
  }

  @override
  List<Object> get props =>
      [id, title, description, category, type, priority, isComplete, created];
}
