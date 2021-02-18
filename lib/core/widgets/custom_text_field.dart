import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key key,
    this.initialValue,
    this.onSaved,
    this.validator,
    this.autofocus = false,
    this.hintText,
    this.contentPadding,
    this.style,
    this.maxLines,
  }) : super(key: key);

  final String initialValue;
  final Function(String) onSaved;
  final Function(String) validator;
  final bool autofocus;
  final String hintText;
  final EdgeInsets contentPadding;
  final TextStyle style;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: autofocus ? Colors.transparent : Color(0xFFF1F2F9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        autofocus: autofocus,
        maxLines: maxLines,
        style:
            autofocus ? theme.textTheme.headline4 : theme.textTheme.headline6,
        decoration: InputDecoration(
          hintText: hintText,
          border: autofocus ? UnderlineInputBorder() : InputBorder.none,
          contentPadding: contentPadding ?? EdgeInsets.fromLTRB(16, 26, 16, 26),
        ),
        initialValue: initialValue,
        onSaved: onSaved,
        validator: validator,
      ),
    );
  }
}
