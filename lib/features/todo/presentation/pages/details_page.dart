import 'package:flutter/material.dart';
import 'package:getan/features/todo/domain/entities/todo.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key key, @required this.todo}) : super(key: key);
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
    );
  }
}
