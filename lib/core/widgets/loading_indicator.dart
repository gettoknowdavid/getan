import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key key, this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12,
      color: Colors.white,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(26),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.12,
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text(
              message ?? 'Please wait...',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
