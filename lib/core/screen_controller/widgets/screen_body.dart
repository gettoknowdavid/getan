import 'package:flutter/material.dart';

class ScreenBody extends StatelessWidget {
  const ScreenBody({@required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final theme = Theme.of(context);

    return Container(
      height: size.height,
      width: size.width,
      color: theme.colorScheme.secondary,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(60),
        ),
        child: child,
      ),
    );
  }
}
