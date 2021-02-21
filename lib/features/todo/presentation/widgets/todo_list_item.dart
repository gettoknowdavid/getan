import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_bottom_sheet.dart';
import '../../../../core/widgets/custom_checkbox.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/todo_list_type.dart';
import '../bloc/todo_bloc.dart';
import 'add_todo_widget.dart';
import 'todo_category_widget.dart';
import 'todo_date_widget.dart';
import 'todo_description_widget.dart';
import 'todo_title_widget.dart';

class TodoListItem extends StatefulWidget {
  const TodoListItem({Key key, @required this.todo}) : super(key: key);
  final Todo todo;

  @override
  _TodoListItemState createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  bool get isComplete => widget.todo.isComplete;
  bool _isComplete;
  bool _isOpen;

  @override
  void initState() {
    super.initState();
    _isComplete = isComplete;
    _isOpen = false;
  }

  void _goToDetailsPage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => CustomBottomSheet(
        title: 'Edit todo',
        child: AddTodoWidget(
          isEditing: true,
          todo: widget.todo,
          onSave: (_todo) {
            context.read<TodoBloc>()..add(UpdateTodo(todo: _todo));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final bloc = context.read<TodoBloc>();

    final height = MediaQuery.of(context).size.height;

    final _todo = widget.todo.copyWith(
      isComplete: !isComplete,
      type: TodoListType.completed,
    );

    return GestureDetector(
      onTap: () => _goToDetailsPage(context),
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(vertical: 16),
        height: _isOpen ? height * 0.165 : height * 0.07,
        alignment: Alignment.topCenter,
        duration: Duration(milliseconds: 350),
        padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
        decoration: BoxDecoration(
          color: _isComplete ? Color(0xFFEBEBEB) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _isComplete ? Colors.transparent : Colors.black12,
              offset: Offset(0, 10.0),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TopTile(
                todo: widget.todo,
                onMorePressed: () => setState(() => _isOpen = !_isOpen),
                onChanged: (_) {
                  setState(() => _isComplete = !_isComplete);
                  bloc..add(UpdateTodo(todo: _todo));
                },
              ),
              TodoDescriptionWidget(todo: widget.todo),
              TodoDateWidget(todo: widget.todo),
              _BottomTile(todo: widget.todo),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomTile extends StatelessWidget {
  const _BottomTile({Key key, @required this.todo}) : super(key: key);
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(width: 16.0),
        TodoCategoryWidget(todo: todo),
        Spacer(),
        IconButton(
          icon: Icon(Icons.delete_outline),
          color: Colors.red,
          onPressed: () {
            context.read<TodoBloc>()..add(RemoveTodo(todo: todo));
          },
        ),
        SizedBox(width: 30),
        IconButton(
          icon: Icon(Icons.archive_outlined),
          color: Colors.red,
          onPressed: () {
            context.read<TodoBloc>()..add(RemoveTodo(todo: todo));
          },
        ),
        SizedBox(width: 16.0),
      ],
    );
  }
}

class _TopTile extends StatelessWidget {
  const _TopTile({
    Key key,
    @required this.todo,
    @required this.onChanged,
    @required this.onMorePressed,
  }) : super(key: key);
  final Todo todo;
  final Function(bool) onChanged;
  final Function() onMorePressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomCheckbox(value: todo.isComplete, onChanged: onChanged),
      title: TodoTitleWidget(todo: todo),
      trailing: IconButton(
        icon: Icon(Icons.keyboard_arrow_down),
        onPressed: onMorePressed,
      ),
      horizontalTitleGap: 8,
    );
  }
}
