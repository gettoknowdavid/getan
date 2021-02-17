
import '../../features/todo/domain/entities/todo.dart';
import '../../features/todo/domain/entities/todo_priority.dart';

String todoPriority(Todo todo) {
  switch (todo.priority) {
    case TodoPriority.high:
      return '!!! ';
    case TodoPriority.medium:
      return '!! ';
    case TodoPriority.low:
      return '! ';
    default:
      return '';
  }
}


