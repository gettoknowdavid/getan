import 'package:flutter/material.dart';

bool _readOnly;

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key key,
    this.fillColor = const Color(0xFFF1F2F9),
    this.initialValue,
    this.onSaved,
    this.validator,
    this.autofocus = false,
    this.hintText,
    this.contentPadding,
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
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    super.initState();
    _readOnly = true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _readOnly
            ? Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(widget.hintText),
              )
            : Container(),
        Container(
          decoration: BoxDecoration(
            color: _readOnly ? Colors.transparent : widget.fillColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextFormField(
            onTap: () {
              print('Heloo');
              setState(() => _readOnly = !_readOnly);
            },
            readOnly: _readOnly,
            autofocus: widget.autofocus,
            maxLines: _readOnly ? null : widget.maxLines,
            style: widget.autofocus
                ? theme.textTheme.headline4
                : theme.textTheme.headline6,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border:
                  widget.autofocus ? UnderlineInputBorder() : InputBorder.none,
              contentPadding:
                  widget.contentPadding ?? EdgeInsets.fromLTRB(16, 26, 16, 26),
            ),
            initialValue: widget.initialValue,
            onSaved: widget.onSaved,
            validator: widget.validator,
          ),
        ),
      ],
    );
  }
}
