import 'package:flutter/material.dart';
import '../services/clock_service.dart';

class TimezoneSelector extends StatelessWidget {
  final String selectedTimezone;
  final ValueChanged<String> onTimezoneChanged;

  const TimezoneSelector({
    required this.selectedTimezone,
    required this.onTimezoneChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            const Text(
              'Timezone:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButton<String>(
                value: selectedTimezone,
                isExpanded: true,
                underline: const SizedBox(),
                items: ClockService.timezones.map((tz) {
                  return DropdownMenuItem<String>(
                    value: tz.name,
                    child: Text(tz.displayName),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    onTimezoneChanged(value);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
