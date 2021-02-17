import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/todo_category.dart';
import '../../domain/entities/todo_list_type.dart';
import '../../domain/entities/todo_priority.dart';

part 'todo_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TodoModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final TodoCategory category;
  final TodoListType type;
  final TodoPriority priority;
  final bool isComplete;
  final String created;

  TodoModel({
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

  @override
  List<Object> get props =>
      [id, title, description, category, type, priority, isComplete, created];

  TodoModel copyWith({
    String id,
    String title,
    String desctiption,
    TodoCategory category,
    TodoListType type,
    TodoPriority priority,
    bool isComplete,
    String created,
  }) {
    return TodoModel(
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

  static TodoModel fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);
  Map<String, dynamic> toJson() => _$TodoModelToJson(this);
}
