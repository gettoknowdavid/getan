import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/todo/presentation/bloc/todo_bloc.dart';
import 'features/todo/presentation/pages/add_todo_page.dart';
import 'features/todo/presentation/pages/todo_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final bloc = context.read<TodoBloc>();

    return MaterialApp(
      title: 'Getan',
      theme: ThemeData(primarySwatch: Colors.green),
      routes: {
        '/': (context) => TodoPage(),
        '/addTodo': (context) {
          return AddTodoPage(onSave: (todo) => bloc..add(AddTodo(todo: todo)));
        }
      },
    );
  }
}