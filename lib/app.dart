import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/screen_controller/screen_controller.dart';
import 'features/todo/presentation/bloc/todo_bloc.dart';
import 'features/todo/presentation/widgets/add_todo_widget.dart';
import 'theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final bloc = context.read<TodoBloc>();

    return MaterialApp(
      title: 'Getan',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => ScreenController(),
        // '/': (context) => TodoPage(),
        '/addTodo': (context) {
          return AddTodoWidget(onSave: (todo) => bloc..add(AddTodo(todo: todo)));
        },
      },
    );
  }
}
