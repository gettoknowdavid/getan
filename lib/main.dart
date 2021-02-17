import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotEnv;

import 'app.dart';
import 'dependency_injector.dart';
import 'features/todo/presentation/bloc/todo_bloc.dart';

Future<void> main() async {
  await dotEnv.load();
  await initializeDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<TodoBloc>()..add(GetTodos()),
        ),
      ],
      child: App(),
    ),
  );
}
