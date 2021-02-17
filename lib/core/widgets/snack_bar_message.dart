import 'package:flutter/material.dart';

class SnackBarMessage extends StatelessWidget {
  const SnackBarMessage(this.message, {Key key}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width,
      child: Center(child: Text(message)),
    );
  }
}
