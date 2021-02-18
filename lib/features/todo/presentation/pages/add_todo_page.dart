import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/utils/dropdown_category_list.dart';
import '../../../../core/utils/dropdown_priority_list.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_checkbox.dart';
import '../../../../core/widgets/custom_dropdown_field.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/todo_category.dart';
import '../../domain/entities/todo_priority.dart';

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    print(height * 0.06);

    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(26),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                autofocus: true,
                hintText: 'Title',
                initialValue: isEditing ? todo.title : '',
                onSaved: (value) => _title = value,
                validator: (val) {
                  return val.trim().isEmpty ? 'Title must not be empty' : null;
                },
              ),
              SizedBox(height: 70),
              CustomTextField(
                hintText: 'Description',
                maxLines: 6,
                onSaved: (value) => _description = value,
                initialValue: isEditing ? todo.description : '',
              ),
              SizedBox(height: 40),
              CustomDropdownField(
                hintText: 'Todo Category',
                value: isEditing ? todo.category : null,
                items: categories(),
                onChanged: (value) => setState(() => _category = value),
              ),
              SizedBox(height: 40),
              CustomDropdownField(
                hintText: 'Todo Priority',
                value: isEditing ? todo.priority : null,
                items: priorities(),
                onChanged: (value) => setState(() => _priority = value),
              ),
              SizedBox(height: 60),
              Row(
                children: [
                  SizedBox(width: 16),
                  Text('Mark as complete?', style: theme.textTheme.headline6),
                  SizedBox(width: 30),
                  CustomCheckbox(
                    value: isEditing ? todo.isComplete : _isComplete,
                    onChanged: (value) => setState(() => _isComplete = value),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: 100),
              CustomButton(
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
                title: isEditing ? 'Done' : 'Add todo',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
