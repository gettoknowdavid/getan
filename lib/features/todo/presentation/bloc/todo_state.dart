part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoEmpty extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  TodoLoaded({@required this.todos});
  final List<Todo> todos;

  @override
  List<Object> get props => [todos];
}

class TodoError extends TodoState {
  TodoError({@required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
