import 'package:getan/features/todo/domain/entities/todo_list_type.dart';

String enumToString(dynamic input) {
  return input.toString().split('.').last;
}

String enumCase(dynamic input) {
  String name = input.toString().split('.').last;
  String firstChar = name[0].toUpperCase();
  String others = name.substring(1);
  return firstChar + others;
}

String listTypeCase(TodoListType input) {
  switch (input) {
    case TodoListType.todo:
      return 'Todo';
    case TodoListType.inProgress:
      return 'In Progress';
    case TodoListType.completed:
      return 'Completed';
    default:
      return 'All';
  }
}
