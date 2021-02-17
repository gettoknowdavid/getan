import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/failures/failure.dart';
import '../../../../core/errors/failures/failure_messages.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/todo_category.dart';
import '../../domain/usecases/add_todo_usecase.dart';
import '../../domain/usecases/get_todos_usecase.dart';
import '../../domain/usecases/remove_todo_usecase.dart';
import '../../domain/usecases/sort_by_category_usecase.dart';
import '../../domain/usecases/sort_by_date_asc_usecase.dart';
import '../../domain/usecases/sort_by_date_desc_usecase.dart';
import '../../domain/usecases/update_todo_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc({
    @required this.addTodo,
    @required this.getTodos,
    @required this.removeTodo,
    @required this.sortByCategory,
    @required this.sortByDateAsc,
    @required this.sortByDateDesc,
    @required this.updateTodo,
  }) : super(TodoEmpty());

  final AddTodoUseCase addTodo;
  final GetTodosUseCase getTodos;
  final RemoveTodoUseCase removeTodo;
  final SortByCategoryUseCase sortByCategory;
  final SortByDateAscUseCase sortByDateAsc;
  final SortByDateDescUseCase sortByDateDesc;
  final UpdateTodoUseCase updateTodo;

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    if (event is AddTodo) {
      yield TodoLoading();
      await addTodo(Param(todo: event.todo));
      final _r = await getTodos(NoParams());
      yield* _mapEitherToState(_r);
    } else if (event is GetTodos) {
      yield TodoLoading();
      final _r = await getTodos(NoParams());
      yield* _mapEitherToState(_r);
    } else if (event is RemoveTodo) {
      await removeTodo(Param(todo: event.todo));
      final _r = await getTodos(NoParams());
      yield* _mapEitherToState(_r);
    } else if (event is SortByCategory) {
      yield TodoLoading();
      final _r = await sortByCategory(CategoryParam(category: event.category));
      yield* _mapEitherToState(_r);
    } else if (event is UpdateTodo) {
      await updateTodo(Param(todo: event.todo));
      final _r = await getTodos(NoParams());
      yield* _mapEitherToState(_r);
    }
  }

  Stream<TodoState> _mapEitherToState(Either<Failure, List<Todo>> _r) async* {
    yield _r.fold(
      (failure) => TodoError(message: _mapFailureToMessage(failure)),
      (todos) => TodoLoaded(todos: todos),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case DbFailure:
        return DB_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_ERROR;
    }
  }
}
