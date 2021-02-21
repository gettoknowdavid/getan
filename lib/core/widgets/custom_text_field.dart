import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key key,
    this.fillColor = const Color(0xFFEBEBEB),
    this.initialValue,
    this.onSaved,
    this.validator,
    this.autofocus = false,
    this.hintText,
    this.contentPadding = const EdgeInsets.fromLTRB(16, 18, 16, 18),
    this.style,
    this.maxLines,
  }) : super(key: key);

  final Color fillColor;
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
        color: fillColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        autofocus: autofocus,
        maxLines: maxLines,
        style: theme.textTheme.headline6,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: contentPadding,
          // labelText: hintText,
        ),
        initialValue: initialValue,
        onSaved: onSaved,
        validator: validator,
      ),
    );
  }
}
