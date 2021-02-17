import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/failures/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class UpdateTodoUseCase implements UseCase<Todo, Param> {
  UpdateTodoUseCase({@required this.repository});
  final TodoRepository repository;

  @override
  Future<Either<Failure, Todo>> call(Param params) async {
    return await repository.updateTodo(params.todo);
  }
}
