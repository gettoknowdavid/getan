import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  const CustomDropdownField({
    Key key,
    this.hintText,
    this.value,
    this.items,
    this.onChanged,
  }) : super(key: key);

  final String hintText;
  final dynamic value;
  final List<DropdownMenuItem<dynamic>> items;
  final Function(dynamic) onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF1F2F9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButtonFormField(
        elevation: 24,
        isDense: false,
        style: theme.textTheme.headline6,
        icon: Icon(Icons.keyboard_arrow_down, size: 28),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(16, 14, 16, 14),
        ),
        hint: Text(hintText),
        value: value,
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
