import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../theme/app_theme.dart';

class DigitalClock extends StatelessWidget {
  final DateTime time;
  final bool is24HourFormat;

  const DigitalClock({
    required this.time,
    required this.is24HourFormat,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final timeFormat = is24HourFormat ? 'HH:mm:ss' : 'hh:mm:ss';
    final timeString = DateFormat(timeFormat).format(time);
    final amPm = is24HourFormat ? '' : DateFormat('a').format(time);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          timeString,
          style: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
            letterSpacing: 4,
          ),
        ),
        if (!is24HourFormat) ...[
          const SizedBox(height: 8),
          Text(
            amPm,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
