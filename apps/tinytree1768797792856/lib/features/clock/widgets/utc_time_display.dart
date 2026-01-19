import 'package:flutter/material.dart';

class UTCTimeDisplay extends StatelessWidget {
  const UTCTimeDisplay({
    super.key,
    required this.time,
  });

  final DateTime time;

  String _formatTime(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}:'
        '${dt.second.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    final double fontSize = isMobile ? 48.0 : 72.0;

    return Text(
      _formatTime(time),
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        fontFeatures: const [FontFeature.tabularFigures()],
        letterSpacing: 2,
      ),
    );
  }
}
