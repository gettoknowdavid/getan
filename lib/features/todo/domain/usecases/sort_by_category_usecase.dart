import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/failures/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class SortByCategoryUseCase implements UseCase<List<Todo>, CategoryParam> {
  SortByCategoryUseCase({@required this.repository});
  final TodoRepository repository;

  @override
  Future<Either<Failure, List<Todo>>> call(CategoryParam params) async {
    return await repository.sortByCategory(params.category);
  }
}
