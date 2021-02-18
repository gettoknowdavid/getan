import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getan/features/todo/presentation/pages/add_todo_page.dart';

import '../../../../core/widgets/custom_checkbox.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/todo_list_type.dart';
import '../bloc/todo_bloc.dart';
import '../pages/details_page.dart';
import 'todo_date_widget.dart';
import 'todo_description_widget.dart';
import 'todo_title_widget.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({Key key, @required this.todo}) : super(key: key);
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _goToDetailsPage(context),
      child: _ListTileContainer(todo: todo),
    );
  }

  void _goToDetailsPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AddTodoPage(todo: todo, isEditing: true),
    ));
  }
}

class _ListTileContainer extends StatelessWidget {
  const _ListTileContainer({Key key, @required this.todo}) : super(key: key);
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final bloc = context.read<TodoBloc>();
    final _todo = todo.copyWith(
      isComplete: !todo.isComplete,
      type: TodoListType.completed,
    );

    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Material(
        color: todo.isComplete ? Color(0xFFF8F9FB) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        elevation: todo.isComplete ? 0 : 12,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 24, 8, 24),
          child: ListTile(
            key: Key('Todo_item__${todo.id}'),
            title: TodoTitleWidget(todo: todo),
            subtitle: _SubtitleItems(todo: todo),
            trailing: CustomCheckbox(
              value: todo.isComplete,
              onChanged: (_) => bloc..add(UpdateTodo(todo: _todo)),
            ),
          ),
        ),
      ),
    );
  }
}

class _SubtitleItems extends StatelessWidget {
  const _SubtitleItems({Key key, @required this.todo}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TodoDateWidget(todo: todo),
        todo.description.isEmpty
            ? Container()
            : TodoDescriptionWidget(todo: todo),
      ],
    );
  }
}
