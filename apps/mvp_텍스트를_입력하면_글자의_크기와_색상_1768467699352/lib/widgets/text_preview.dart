import 'package:flutter/material.dart';

class TextPreview extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;

  const TextPreview({
    super.key,
    required this.text,
    required this.fontSize,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 200),
        padding: const EdgeInsets.all(24),
        child: Center(
          child: text.isEmpty
              ? Text(
                  'Type something...',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey[400],
                  ),
                )
              : Text(
                  text,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}
