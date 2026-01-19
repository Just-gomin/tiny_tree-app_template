import 'package:flutter/material.dart';

class TimeFormatToggle extends StatelessWidget {
  final bool is24HourFormat;
  final ValueChanged<bool> onFormatChanged;

  const TimeFormatToggle({
    required this.is24HourFormat,
    required this.onFormatChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '12시간 형식',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Switch(
              value: !is24HourFormat,
              onChanged: (value) => onFormatChanged(!value),
            ),
          ],
        ),
      ),
    );
  }
}
