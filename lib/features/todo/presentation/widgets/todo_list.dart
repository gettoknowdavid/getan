import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/empty_message.dart';
import '../../../../core/widgets/error_message.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../domain/entities/todo.dart';
import '../bloc/todo_bloc.dart';
import 'todo_list_item.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoLoaded) {
          return state.todos.isEmpty
              ? Center(child: EmptyMessage())
              : _ListWidget(todos: state.todos);
        } else if (state is TodoEmpty) {
          return Center(child: EmptyMessage());
        } else if (state is TodoError) {
          return Center(child: ErrorMessage(message: state.message));
        } else {
          return Center(child: LoadingIndicator());
        }
      },
    );
  }
}

class _ListWidget extends StatelessWidget {
  const _ListWidget({Key key, @required this.todos}) : super(key: key);
  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(12, 18, 12, 0),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoListItem(todo: todo);
      },
    );
  }
}
