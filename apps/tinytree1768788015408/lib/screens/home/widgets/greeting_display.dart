import 'package:flutter/material.dart';
import '../../../models/greeting.dart';

class GreetingDisplay extends StatelessWidget {
  final Greeting greeting;
  final bool isMobile;

  const GreetingDisplay({
    required this.greeting,
    required this.isMobile,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double greetingSize = isMobile ? 48 : 64;
    final double transliterationSize = isMobile ? 20 : 24;
    final double languageSize = isMobile ? 16 : 18;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          greeting.greeting,
          style: TextStyle(
            fontSize: greetingSize,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          '(${greeting.transliteration})',
          style: TextStyle(
            fontSize: transliterationSize,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          greeting.language,
          style: TextStyle(
            fontSize: languageSize,
            color: Colors.white60,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
