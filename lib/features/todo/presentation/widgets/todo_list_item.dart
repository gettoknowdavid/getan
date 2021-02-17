import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_checkbox.dart';
import '../../../../core/widgets/snack_bar_message.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/todo_list_type.dart';
import '../bloc/todo_bloc.dart';
import '../pages/add_todo_page.dart';
import 'todo_date_widget.dart';
import 'todo_description_widget.dart';
import 'todo_title_widget.dart';

class TodoListItem extends StatefulWidget {
  const TodoListItem({
    Key key,
    @required this.todo,
    @required this.selectedList,
  }) : super(key: key);
  final Todo todo;
  final List<Todo> selectedList;

  @override
  _TodoListItemState createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  List<Todo> get _selectedList => widget.selectedList;

  @override
  Widget build(BuildContext context) {
    bool isSelected = _selectedList.isNotEmpty;

    return GestureDetector(
      onTap: () => _updateTodo(context),
      child: _ListTileContainer(
        todo: widget.todo,
        isSelected: isSelected,
        onRemoveTodo: () => _removeTodo(context),
      ),
    );
  }

  void _removeTodo(BuildContext context) {
    // ignore: close_sinks
    final bloc = context.read<TodoBloc>();
    bloc..add(RemoveTodo(todo: widget.todo));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: SnackBarMessage('Successfully removed: ${widget.todo.title}'),
    ));
  }

  void _updateTodo(BuildContext context) {
    // ignore: close_sinks
    final bloc = context.read<TodoBloc>();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AddTodoPage(
        todo: widget.todo,
        isEditing: true,
        onSave: (_todo) => bloc..add(UpdateTodo(todo: _todo)),
      ),
    ));
  }
}

class _ListTileContainer extends StatelessWidget {
  const _ListTileContainer({
    Key key,
    @required this.todo,
    @required this.isSelected,
    @required this.onRemoveTodo,
  }) : super(key: key);
  final Todo todo;
  final bool isSelected;
  final Function onRemoveTodo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ignore: close_sinks
    final bloc = context.read<TodoBloc>();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Material(
        color: isSelected
            ? Colors.grey[500]
            : todo.isComplete
                ? Colors.transparent
                : Colors.white,
        borderRadius: BorderRadius.circular(16),
        elevation: todo.isComplete ? 0 : 12,
        shadowColor: theme.primaryColor.withOpacity(.15),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 24, 8, 24),
          child: ListTile(
            key: Key('Todo_item__${todo.id}'),
            title: TodoTitleWidget(todo: todo),
            subtitle: _SubtitleItems(todo: todo),
            trailing: CustomCheckbox(
              value: todo.isComplete,
              onChanged: (_) {
                bloc
                  ..add(UpdateTodo(
                      todo: todo.copyWith(
                    isComplete: !todo.isComplete,
                    type: TodoListType.completed,
                  )));
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _SubtitleItems extends StatelessWidget {
  const _SubtitleItems({
    Key key,
    @required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 8),
        TodoDateWidget(todo: todo),
        SizedBox(height: 16),
        TodoDescriptionWidget(todo: todo),
      ],
    );
  }
}

