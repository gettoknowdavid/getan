import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/popup_category_list.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/todo_category.dart';
import '../bloc/todo_bloc.dart';
import '../widgets/todo_list.dart';

List<Todo> selectedList = <Todo>[];

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // ignore: close_sinks
    final bloc = BlocProvider.of<TodoBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Getan'),
        actions: [
          PopupMenuButton<TodoCategory>(
            icon: Icon(Icons.keyboard_arrow_down),
            itemBuilder: (context) => items(),
            onSelected: (value) {
              bloc..add(SortByCategory(category: value));
            },
          ),
        ],
      ),
      body: TodoList(selectedList: selectedList),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: height * 0.1,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              color: Colors.white,
              elevation: 9,
              shadowColor: Colors.black26,
              borderRadius: BorderRadius.circular(40),
              child: Container(
                height: (height * 0.1) * 0.68,
                width: width * 0.58,
                padding: EdgeInsets.only(left: 30, right: 26),
                child: TextFormField(
                  style: TextStyle(fontSize: 22),
                  decoration: const InputDecoration(
                    fillColor: Colors.purple,
                    border: InputBorder.none,
                    hintText: 'Write a new todo',
                    contentPadding: EdgeInsets.fromLTRB(0, 22, 0, 0),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Material(
              color: Colors.white,
              elevation: 9,
              shadowColor: Colors.black26,
              borderRadius: BorderRadius.circular(40),
              child: Container(
                height: (height * 0.1) * 0.68,
                width: (height * 0.1) * 0.68,
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  iconSize: 28,
                  onPressed: () => Navigator.pushNamed(context, '/addTodo'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
