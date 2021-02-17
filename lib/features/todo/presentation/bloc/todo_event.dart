part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
  @override
  List<Object> get props => [];
}

class AddTodo extends TodoEvent {
  final Todo todo;
  AddTodo({@required this.todo});

  @override
  List<Object> get props => [todo];
}

class GetTodos extends TodoEvent {}

class RemoveTodo extends TodoEvent {
  final Todo todo;
  RemoveTodo({@required this.todo});

  @override
  List<Object> get props => [todo];
}

class SortByCategory extends TodoEvent {
  final TodoCategory category;
  SortByCategory({@required this.category});

  @override
  List<Object> get props => [category];
}

class SortByDateAsc extends TodoEvent {}

class SortByDateDesc extends TodoEvent {}

class UpdateTodo extends TodoEvent {
  final Todo todo;
  UpdateTodo({@required this.todo});

  @override
  List<Object> get props => [todo];
}
