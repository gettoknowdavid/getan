import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../features/todo/domain/entities/todo.dart';
import '../../features/todo/domain/entities/todo_category.dart';
import '../errors/failures/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class Param extends Equatable {
  Param({@required this.todo});
  final Todo todo;

  @override
  List<Object> get props => [todo];
}

class Params extends Equatable {
  Params({@required this.todos});
  final List<Todo> todos;

  @override
  List<Object> get props => [todos];
}

class CategoryParam extends Equatable {
  CategoryParam({@required this.category});
  final TodoCategory category;

  @override
  List<Object> get props => [category];
}
