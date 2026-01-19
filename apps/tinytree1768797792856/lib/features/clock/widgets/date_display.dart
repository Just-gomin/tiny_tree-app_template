import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateDisplay extends StatelessWidget {
  const DateDisplay({
    super.key,
    required this.date,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    final double fontSize = isMobile ? 18.0 : 24.0;

    final String formattedDate = DateFormat('yyyy년 M월 d일 EEEE', 'ko_KR').format(date);
    final String isoDate = DateFormat('yyyy-MM-dd').format(date);

    return Column(
      children: [
        Text(
          formattedDate,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'ISO 8601: $isoDate',
          style: TextStyle(
            fontSize: fontSize * 0.7,
            fontWeight: FontWeight.w300,
            color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
