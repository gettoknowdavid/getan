import 'package:flutter/material.dart';
import 'package:getan/features/todo/domain/entities/todo_priority.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/utils/string_helpers.dart';
import '../../../../core/widgets/custom_checkbox.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/todo_category.dart';
import '../widgets/add_todo_button.dart';

typedef OnSaveCallback = Function(Todo _todo);

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({
    Key key,
    this.isEditing = false,
    this.onSave,
    this.todo,
  }) : super(key: key);
  final bool isEditing;
  final OnSaveCallback onSave;
  final Todo todo;

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool get isEditing => widget.isEditing;
  Todo get todo => widget.todo;

  String _title;
  String _description;
  TodoCategory _category;
  TodoPriority _priority;
  bool _isComplete;
  String _created = DateTime.now().toIso8601String();

  List<DropdownMenuItem<TodoCategory>> categories() {
    List<DropdownMenuItem<TodoCategory>> _items = [];

    for (TodoCategory category in TodoCategory.values) {
      _items.add(
        DropdownMenuItem(
          value: category,
          child: Text(
            category == null
                ? categoryCase(TodoCategory.none)
                : categoryCase(category),
          ),
        ),
      );
    }
    return _items.toList();
  }

  List<DropdownMenuItem<TodoPriority>> priorities() {
    List<DropdownMenuItem<TodoPriority>> _items = [];

    for (TodoPriority priority in TodoPriority.values) {
      _items.add(
        DropdownMenuItem(
          value: priority,
          child: Text(
            priority == null
                ? categoryCase(TodoPriority.none)
                : categoryCase(priority),
          ),
        ),
      );
    }
    return _items.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(26),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(hintText: 'Title'),
                initialValue: isEditing ? todo.title : '',
                onSaved: (value) => _title = value,
                validator: (val) {
                  return val.trim().isEmpty ? 'Title must not be empty' : null;
                },
              ),
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(hintText: 'Description'),
                onSaved: (value) => _description = value,
                initialValue: isEditing ? todo.description : '',
              ),
              DropdownButtonFormField(
                hint: Text('Todo Category'),
                value: isEditing ? todo.category : null,
                items: categories(),
                onChanged: (value) => setState(() => _category = value),
              ),
              DropdownButtonFormField(
                hint: Text('Todo Priority'),
                value: isEditing ? todo.priority : null,
                items: priorities(),
                onChanged: (value) => setState(() => _priority = value),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Spacer(),
                  Text('Mark as complete?'),
                  SizedBox(width: 60),
                  CustomCheckbox(
                    value: isEditing ? todo.isComplete : _isComplete,
                    onChanged: (value) => setState(() => _isComplete = value),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: AddTodoButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(Todo(
              id: isEditing ? todo.id : Uuid().v4(),
              title: _title,
              description: _description,
              category: _category,
              priority: _priority,
              isComplete: _isComplete,
              created: isEditing ? todo.created : _created,
            ));
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
