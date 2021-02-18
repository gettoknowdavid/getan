import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key key, this.onPressed, this.title}) : super(key: key);
  final Function() onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MaterialButton(
      onPressed: onPressed,
      color: theme.colorScheme.secondary,
      child: Text(
        title,
        style: theme.textTheme.headline6.copyWith(
          color: Colors.white,
          fontSize: 23.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
