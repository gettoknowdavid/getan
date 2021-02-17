import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/exceptions/db_exception.dart';
import '../../../../core/errors/failures/failure.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/todo_category.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_local_data_source.dart';
import '../models/todo_mapper.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;
  TodoRepositoryImpl({@required this.localDataSource});

  @override
  Future<Either<Failure, Todo>> addTodo(Todo todo) async {
    try {
      final _todo = TodoMapper.toModel(todo);
      await localDataSource.addTodo(_todo);
      return Right(todo);
    } on DbException {
      return Left(DbFailure());
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    try {
      final todos = await localDataSource.getTodos();
      final _r = TodoMapper.toEntityList(todos);
      return Right(_r);
    } on DbException {
      return Left(DbFailure());
    }
  }

  @override
  Future<Either<Failure, Todo>> removeTodo(Todo todo) async {
    try {
      final _todo = TodoMapper.toModel(todo);
      await localDataSource.removeTodo(_todo);
      return Right(todo);
    } on DbException {
      return Left(DbFailure());
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> sortByCategory(
      TodoCategory category) async {
    try {
      final todos = await localDataSource.sortByCategory(category);
      final _r = TodoMapper.toEntityList(todos);
      return Right(_r);
    } on DbException {
      return Left(DbFailure());
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> sortByDateAsc() async {
    try {
      final todos = await localDataSource.sortByDateAsc();
      final _r = TodoMapper.toEntityList(todos);
      return Right(_r);
    } on DbException {
      return Left(DbFailure());
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> sortByDateDesc() async {
    try {
      final todos = await localDataSource.sortByDateDesc();
      final _r = TodoMapper.toEntityList(todos);
      return Right(_r);
    } on DbException {
      return Left(DbFailure());
    }
  }

  @override
  Future<Either<Failure, Todo>> updateTodo(Todo todo) async {
    try {
      final _r = TodoMapper.toModel(todo);
      await localDataSource.updateTodo(_r);
      return Right(todo);
    } on DbException {
      return Left(DbFailure());
    }
  }
}
