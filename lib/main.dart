import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotEnv;

import 'app.dart';
import 'core/bottom_nav/bloc/bottom_nav_bloc.dart';
import 'dependency_injector.dart';
import 'features/todo/presentation/bloc/todo_bloc.dart';

Future<void> main() async {
  await dotEnv.load();
  await initializeDependencies();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<TodoBloc>()..add(GetTodos()),
        ),
        BlocProvider(create: (context) => sl<BottomNavBloc>()),
      ],
      child: App(),
    ),
  );
}
