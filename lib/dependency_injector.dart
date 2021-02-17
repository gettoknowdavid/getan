import 'package:get_it/get_it.dart';

import 'core/database/getan_db.dart';
import 'features/todo/data/datasources/todo_local_data_source.dart';
import 'features/todo/data/repositories/todo_repository_impl.dart';
import 'features/todo/domain/repositories/todo_repository.dart';
import 'features/todo/domain/usecases/add_todo_usecase.dart';
import 'features/todo/domain/usecases/get_todos_usecase.dart';
import 'features/todo/domain/usecases/remove_todo_usecase.dart';
import 'features/todo/domain/usecases/sort_by_category_usecase.dart';
import 'features/todo/domain/usecases/sort_by_date_asc_usecase.dart';
import 'features/todo/domain/usecases/sort_by_date_desc_usecase.dart';
import 'features/todo/domain/usecases/update_todo_usecase.dart';
import 'features/todo/presentation/bloc/todo_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final database = await GetanDb.init();

  // BLoCs
  sl.registerFactory<TodoBloc>(
    () => TodoBloc(
      addTodo: sl(),
      getTodos: sl(),
      sortByCategory: sl(),
      removeTodo: sl(),
      sortByDateAsc: sl(),
      sortByDateDesc: sl(),
      updateTodo: sl(),
    ),
  );

  // Repositories
  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(localDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton<AddTodoUseCase>(
    () => AddTodoUseCase(repository: sl()),
  );
  sl.registerLazySingleton<GetTodosUseCase>(
    () => GetTodosUseCase(repository: sl()),
  );

  sl.registerLazySingleton<RemoveTodoUseCase>(
    () => RemoveTodoUseCase(repository: sl()),
  );
  sl.registerLazySingleton<SortByCategoryUseCase>(
    () => SortByCategoryUseCase(repository: sl()),
  );
  sl.registerLazySingleton<SortByDateAscUseCase>(
    () => SortByDateAscUseCase(repository: sl()),
  );
  sl.registerLazySingleton<SortByDateDescUseCase>(
    () => SortByDateDescUseCase(repository: sl()),
  );
  sl.registerLazySingleton<UpdateTodoUseCase>(
    () => UpdateTodoUseCase(repository: sl()),
  );

  // Data sources
  sl.registerLazySingleton<TodoLocalDataSource>(
    () => TodoLocalDataSourceImpl(database: sl()),
  );

  // External
  sl.registerLazySingleton<GetanDb>(() => database);
}
