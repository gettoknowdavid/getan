import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet(
      {Key key, this.title, this.child, this.showTopBar = true})
      : super(key: key);
  final String title;
  final Widget child;
  final bool showTopBar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.transparent,
      height: height * 0.8,
      child: Material(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(60)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _TopBar(),
            Text(title ?? 'Create todo', style: theme.textTheme.headline6),
            Expanded(child: child ?? Container()),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        height: 3.0,
        width: width * 0.5,
        margin: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: theme.primaryColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(60),
        ),
      ),
    );
  }
}
