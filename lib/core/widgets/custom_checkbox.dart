import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final double size;
  final double iconSize;
  final Color selectedColor;
  final Color selectedIconColor;
  final Function(bool) onChanged;

  CustomCheckbox({
    this.value,
    this.size,
    this.iconSize,
    this.selectedColor,
    this.selectedIconColor,
    this.onChanged,
  });

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.value ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final containerSize = MediaQuery.of(context).size.shortestSide * 0.05;
    final radius = containerSize * 0.36;

    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        setState(() => _isSelected = !_isSelected);
        widget.onChanged(_isSelected);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
          color: _isSelected
              ? widget.selectedColor ?? theme.primaryColor
              : Colors.grey[300],
          borderRadius: BorderRadius.circular(radius),
        ),
        width: widget.size ?? containerSize,
        height: widget.size ?? containerSize,
        child: _isSelected
            ? Icon(
                Icons.check,
                color: widget.selectedIconColor ?? theme.scaffoldBackgroundColor,
                size: widget.iconSize ?? 20,
              )
            : null,
      ),
    );
  }
}
