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

String _title;
String _description;
TodoCategory _category;
TodoPriority _priority;
bool _isComplete;
String _created = DateTime.now().toIso8601String();

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key key, this.isEditing = false, this.onSave, this.todo})
      : super(key: key);
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Details' : '')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(26),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _PageTitle(isEditing: isEditing),
              CustomTextField(
                autofocus: true,
                hintText: 'Title',
                initialValue: isEditing ? todo.title : '',
                onSaved: (value) => _title = value,
                fillColor: Colors.transparent,
                validator: (val) {
                  return val.trim().isEmpty ? 'Title must not be empty' : null;
                },
              ),
              SizedBox(height: 40),
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
              SizedBox(height: 40),
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
              SizedBox(height: 80),
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
                title: isEditing ? 'Done' : 'Add',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageTitle extends StatelessWidget {
  const _PageTitle({Key key, @required this.isEditing}) : super(key: key);
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.headline4.copyWith(
      fontWeight: FontWeight.bold,
    );

    return isEditing
        ? Container()
        : Container(
            child: Text('Add new todo', style: style),
            margin: EdgeInsets.symmetric(vertical: 30),
          );
  }
}
