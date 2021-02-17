import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failure.dart';
import '../entities/todo.dart';
import '../entities/todo_category.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodos();

  Future<Either<Failure, Todo>> addTodo(Todo todo);
  Future<Either<Failure, Todo>> updateTodo(Todo todo);
  Future<Either<Failure, Todo>> removeTodo(Todo todo);

  Future<Either<Failure, List<Todo>>> sortByCategory(TodoCategory category);
  Future<Either<Failure, List<Todo>>> sortByDateAsc();
  Future<Either<Failure, List<Todo>>> sortByDateDesc();
}
