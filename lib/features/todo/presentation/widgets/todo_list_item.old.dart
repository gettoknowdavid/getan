import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/format_date.dart';
import '../../../../core/utils/string_helpers.dart';
import '../../../../core/utils/todo_category_to_color.dart';
import '../../../../core/widgets/custom_checkbox.dart';
import '../../../../core/widgets/snack_bar_message.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/todo_list_type.dart';
import '../bloc/todo_bloc.dart';
import '../pages/add_todo_page.dart';
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
      // onLongPress: () {
      //   setState(() => isSelected = !isSelected);
      //   widget.selectedList.add(widget.todo);
      // },
      onTap: () {
        if (widget.selectedList.isNotEmpty) {
          setState(() => isSelected = !isSelected);
          widget.selectedList.add(widget.todo);
        } else {
          setState(() => isSelected = !isSelected);
          _updateTodo(context);
        }
      },
      child: Stack(
        children: [
          _ListTileContainer(
            todo: widget.todo,
            isSelected: isSelected,
            onRemoveTodo: () => _removeTodo(context),
          ),
          isSelected
              ? Positioned(
                  top: 3,
                  right: 0,
                  child: Material(
                    color: Colors.white,
                    type: MaterialType.circle,
                    child: Icon(Icons.check_circle, color: Colors.red),
                  ),
                )
              : Container(),
        ],
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
      margin: EdgeInsets.symmetric(vertical: 12),
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
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
          child: ListTile(
            key: Key('Todo_item__${todo.id}'),
            title: TodoTitleWidget(todo: todo),
            subtitle: _SubtitleItems(todo: todo),
            trailing: IconButton(
              icon: Icon(Icons.delete_outlined),
              onPressed: onRemoveTodo,
              color: Colors.red,
            ),
            leading: CustomCheckbox(
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
        Text(
          formatDate(context, todo.created),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            decoration: todo.isComplete
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        SizedBox(height: 6),
        Text(
          categoryCase(todo.category),
          style: TextStyle(color: categoryColor(todo.category)),
        ),
        SizedBox(height: 8),
        Text(
          todo.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            decoration: todo.isComplete
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
      ],
    );
  }
}
