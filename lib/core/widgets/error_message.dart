import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({Key key, this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12,
      color: Colors.white,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(26),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.16,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Center(
          child: Text(message ?? 'Hmmm, something is odd here.'),
        ),
      ),
    );
  }
}
