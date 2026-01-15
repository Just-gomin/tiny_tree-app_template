import 'package:flutter/material.dart';

const String defaultText = 'Hello, World!';
const double defaultFontSize = 48.0;
const double minFontSize = 12.0;
const double maxFontSize = 120.0;
const Color defaultColor = Colors.black;

final List<Color> colorPalette = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.indigo,
  Colors.purple,
  Colors.black,
];

class TextStyleState {
  final String text;
  final double fontSize;
  final Color textColor;

  const TextStyleState({
    required this.text,
    required this.fontSize,
    required this.textColor,
  });

  TextStyleState copyWith({
    String? text,
    double? fontSize,
    Color? textColor,
  }) {
    return TextStyleState(
      text: text ?? this.text,
      fontSize: fontSize ?? this.fontSize,
      textColor: textColor ?? this.textColor,
    );
  }

  static TextStyleState get defaultState => const TextStyleState(
        text: defaultText,
        fontSize: defaultFontSize,
        textColor: defaultColor,
      );
}
