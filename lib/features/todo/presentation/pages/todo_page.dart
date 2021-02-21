import 'package:flutter/material.dart';

import '../widgets/todo_list.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TodoList(),
    );
  }
}
