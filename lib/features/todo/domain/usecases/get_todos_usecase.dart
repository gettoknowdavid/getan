import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/failures/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class GetTodosUseCase implements UseCase<List<Todo>, NoParams> {
  GetTodosUseCase({@required this.repository});
  final TodoRepository repository;

  @override
  Future<Either<Failure, List<Todo>>> call(NoParams params) async {
    return await repository.getTodos();
  }
}
