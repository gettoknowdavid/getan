import 'package:flutter/material.dart';

class AddTodoButton extends StatelessWidget {
  const AddTodoButton({Key key, @required this.onPressed}) : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'Add task',
      child: Icon(Icons.add),
      onPressed: onPressed,
    );
  }
}
