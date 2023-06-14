import 'package:flutter/material.dart';

class StylesPalette {
  const StylesPalette({
    required this.largeTitle,
    required this.title,
    required this.button,
    required this.body,
    required this.subhead,
  });

  final TextStyle largeTitle;
  final TextStyle title;
  final TextStyle button;
  final TextStyle body;
  final TextStyle subhead;
}

class RobotoStyle {
  const RobotoStyle._();

  static const fontFamily = 'Roboto';

  static const largeTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w500,
    height: 32 / 38,
  );

  static const title = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 20 / 32,
    letterSpacing: 0.5,
  );

  static const button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 14 / 24,
    letterSpacing: 0.16,
  );

  static const body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 16 / 20,
  );

  static const subhead = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 14 / 20,
  );
}
