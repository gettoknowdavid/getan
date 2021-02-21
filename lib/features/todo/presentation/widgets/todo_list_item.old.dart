import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getan/core/widgets/custom_bottom_sheet.dart';

import '../../../../core/widgets/custom_checkbox.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/todo_list_type.dart';
import '../bloc/todo_bloc.dart';
import 'add_todo_widget.dart';
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

  @override
  void initState() {
    super.initState();
    _isComplete = isComplete;
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
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        child: Material(
          color: _isComplete ? Color(0xFFEBEBEB) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          elevation: _isComplete ? 0 : 12,
          child: AnimatedContainer(
            curve: Curves.easeInOut,
            height: _isComplete ? height * 0.055 : height * 0.13,
            alignment: Alignment.topCenter,
            duration: Duration(seconds: 2),
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: ListTile(
              key: Key('Todo_item__${widget.todo.id}'),
              title: TodoTitleWidget(todo: widget.todo),
              subtitle: widget.todo.description.isEmpty
                  ? null
                  : TodoDescriptionWidget(todo: widget.todo),
              trailing: CustomCheckbox(
                value: isComplete,
                onChanged: (_) {
                  setState(() {
                    _isComplete = !_isComplete;
                  });
                  bloc..add(UpdateTodo(todo: _todo));
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _goToDetailsPage(BuildContext context) {
    // ignore: close_sinks
    final bloc = context.read<TodoBloc>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => CustomBottomSheet(
        child: AddTodoWidget(
          isEditing: true,
          todo: widget.todo,
          onSave: (_todo) => bloc..add(UpdateTodo(todo: _todo)),
        ),
      ),
    );
  }
}
