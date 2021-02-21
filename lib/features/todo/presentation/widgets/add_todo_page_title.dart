import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({Key key, @required this.isEditing}) : super(key: key);
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
