import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../theme/app_theme.dart';

class DateDisplay extends StatelessWidget {
  final DateTime date;

  const DateDisplay({
    required this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy년 MM월 dd일 E요일', 'ko_KR');
    final dateString = dateFormat.format(date);

    return Text(
      dateString,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: AppTheme.textSecondary,
        letterSpacing: 1,
      ),
    );
  }
}
