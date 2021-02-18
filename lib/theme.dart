import 'package:flutter/material.dart';

const Color primary = const Color(0xFF282240);
const Color primaryVariant = const Color(0xFF2E2C73);
const Color secondary = const Color(0xFFD9674E);
const Color secondaryVariant = const Color(0xFFD93425);
const Color background = const Color(0xFFEBEBEB);

const ColorScheme colorScheme = const ColorScheme.light(
  primary: primary,
  primaryVariant: primaryVariant,
  onPrimary: Colors.white,
  secondary: secondary,
  secondaryVariant: secondaryVariant,
  onSecondary: Colors.white,
  background: background,
);

class AppTheme {
  static get theme {
    final base = ThemeData.light();

    return base.copyWith(
      appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
      accentColor: primaryVariant,
      primaryColor: primary,
      colorScheme: colorScheme,
      shadowColor: primary.withOpacity(0.13),
      scaffoldBackgroundColor: Colors.white,
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        height: 65.0,
        buttonColor: secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      iconTheme: _iconTheme(base.iconTheme),
      primaryIconTheme: _iconTheme(base.primaryIconTheme),
      textTheme: _textTheme(base.textTheme),
      primaryTextTheme: _textTheme(base.primaryTextTheme),
    );
  }
}

TextTheme _textTheme(TextTheme base) {
  return base.copyWith().apply(
        fontFamily: 'ProductSans',
        displayColor: Color(0xFF282240),
        bodyColor: Color(0xFF282240),
      );
}

IconThemeData _iconTheme(IconThemeData base) {
  return base.copyWith(color: primary);
}
