import '../../domain/entities/todo.dart';
import '../../domain/entities/todo_category.dart';
import '../../domain/entities/todo_list_type.dart';
import '../../domain/entities/todo_priority.dart';
import 'todo_model.dart';

class TodoMapper {
  static Todo toEntity(TodoModel model) {
    return Todo(
      id: model.id,
      title: model.title,
      description: model.description,
      category: model.category ?? TodoCategory.none,
      type: model.type ?? TodoListType.todo,
      priority: model.priority ?? TodoPriority.none,
      isComplete: model.isComplete ?? false,
      created: model.created,
    );
  }

  static TodoModel toModel(Todo todo) {
    return TodoModel(
      id: todo.id,
      title: todo.title,
      description: todo.description,
      category: todo.category ?? TodoCategory.none,
      type: todo.type ?? TodoListType.todo,
      priority: todo.priority ?? TodoPriority.none,
      isComplete: todo.isComplete ?? false,
      created: todo.created,
    );
  }

  static List<Todo> toEntityList(List<TodoModel> modelList) {
    List<Todo> entityList = [];
    modelList.forEach((model) {
      entityList.add(toEntity(model));
    });
    return entityList;
  }
}
