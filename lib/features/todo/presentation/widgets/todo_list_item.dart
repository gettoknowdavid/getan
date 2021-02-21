import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getan/core/usecase/usecase.dart';
import 'package:getan/core/widgets/custom_bottom_sheet.dart';
import 'package:getan/features/todo/presentation/widgets/todo_category_widget.dart';
import 'package:getan/features/todo/presentation/widgets/todo_date_widget.dart';

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

  GlobalKey<TodoDescriptionWidgetState> _key =
      GlobalKey<TodoDescriptionWidgetState>();

  bool _isComplete;
  bool _isOpen;
  @override
  void initState() {
    super.initState();
    _isComplete = isComplete;
    _isOpen = false;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final bloc = context.read<TodoBloc>();
    // final theme = Theme.of(context);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final _todo = widget.todo.copyWith(
      isComplete: !isComplete,
      type: TodoListType.completed,
    );
    final _title = TodoTitleWidget(
      todo: widget.todo,
      key: _key,
    );

    return GestureDetector(
      onTap: () => _goToDetailsPage(context),
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(vertical: 16),
        height: _isOpen ? height * 0.16 : height * 0.07,
        alignment: Alignment.topCenter,
        duration: Duration(milliseconds: 350),
        padding: EdgeInsets.fromLTRB(26, 12, 20, 12),
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
              Row(
                children: [
                  CustomCheckbox(
                    value: isComplete,
                    onChanged: (_) {
                      setState(() {
                        _isComplete = !_isComplete;
                      });
                      bloc..add(UpdateTodo(todo: _todo));
                    },
                  ),
                  SizedBox(width: 26),
                  Expanded(child: _title),
                  IconButton(
                    icon: Icon(Icons.keyboard_arrow_down),
                    onPressed: () {
                      setState(() => _isOpen = !_isOpen);
                      print(_title.key);
                    },
                  ),
                ],
              ),
              TodoDescriptionWidget(todo: widget.todo),
              TodoDateWidget(todo: widget.todo),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TodoCategoryWidget(todo: widget.todo),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.delete_outline),
                    color: Colors.red,
                    onPressed: () {
                      bloc.add(RemoveTodo(todo: widget.todo));
                    },
                  ),
                  SizedBox(width: 30),
                  IconButton(
                    icon: Icon(Icons.archive_outlined),
                    color: Colors.red,
                    onPressed: () {
                      bloc..add(RemoveTodo(todo: widget.todo));
                    },
                  ),
                ],
              ),
            ],
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
