import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/utils/dropdown_category_list.dart';
import '../../../../core/utils/dropdown_priority_list.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_dropdown_field.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/is_complete_widget.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/todo_category.dart';
import '../../domain/entities/todo_priority.dart';

typedef OnSaveCallback = Function(Todo _todo);

String _title;
String _description;
TodoCategory _category;
TodoPriority _priority;
bool _isComplete = false;
String _created = DateTime.now().toIso8601String();

class AddTodoWidget extends StatefulWidget {
  const AddTodoWidget({Key key, this.isEditing = false, this.onSave, this.todo})
      : super(key: key);
  final bool isEditing;
  final OnSaveCallback onSave;
  final Todo todo;

  @override
  _AddTodoWidgetState createState() => _AddTodoWidgetState();
}

class _AddTodoWidgetState extends State<AddTodoWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool get isEditing => widget.isEditing;
  Todo get todo => widget.todo;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(30),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              autofocus: isEditing ? false : true,
              hintText: 'Title',
              initialValue: isEditing ? todo.title : '',
              onSaved: (value) => _title = value,
              validator: (val) {
                return val.trim().isEmpty ? 'Title must not be empty' : null;
              },
            ),
            SizedBox(height: 20),
            CustomTextField(
              hintText: 'Description',
              maxLines: 5,
              onSaved: (value) => _description = value,
              initialValue: isEditing ? todo.description : '',
            ),
            SizedBox(height: 20),
            CustomDropdownField(
              hintText: 'Todo Category',
              value: isEditing ? todo.category : null,
              items: categories(),
              onChanged: (value) => setState(() => _category = value),
            ),
            SizedBox(height: 20),
            CustomDropdownField(
              hintText: 'Todo Priority',
              value: isEditing ? todo.priority : null,
              items: priorities(),
              onChanged: (value) => setState(() => _priority = value),
            ),
            SizedBox(height: 30),
            IsCompleteWidget(
              value: isEditing ? todo.isComplete : _isComplete,
              isEditing: widget.isEditing,
              onChanged: (value) => setState(() => _isComplete = value),
            ),
            SizedBox(height: 40),
            CustomButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  widget.onSave(Todo(
                    id: isEditing ? todo.id : Uuid().v4(),
                    title: _title.trim(),
                    description: _description.trim(),
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
    );
  }
}
