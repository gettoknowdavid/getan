import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../domain/entities/todo.dart';

class TodoDescriptionWidget extends StatefulWidget {
  const TodoDescriptionWidget(
      {GlobalKey key, @required this.todo, this.onChange})
      : super(key: key);

  final Todo todo;
  final Function onChange;

  @override
  TodoDescriptionWidgetState createState() => TodoDescriptionWidgetState();
}

class TodoDescriptionWidgetState extends State<TodoDescriptionWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Text(
      widget.todo.description.trim(),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: theme.textTheme.subtitle1.copyWith(
        color: Colors.grey[600],
      ),
    );
  }

  var widgetKey = GlobalKey();
  var oldSize;

  void postFrameCallback(_) {
    var context = widgetKey.currentContext;
    if (context == null) return;

    var newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize);
  }
}
