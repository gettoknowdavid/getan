import 'package:flutter/material.dart';

import 'custom_checkbox.dart';

class IsCompleteWidget extends StatelessWidget {
  const IsCompleteWidget({
    Key key,
    @required this.value,
    @required this.isEditing,
    @required this.onChanged,
  }) : super(key: key);
  final bool value;
  final bool isEditing;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Text('Mark as complete?', style: theme.textTheme.headline6),
        SizedBox(width: 30),
        CustomCheckbox(value: value, onChanged: onChanged),
        Spacer(),
      ],
    );
  }
}
