import 'package:flutter/material.dart';
import '../models/timer_state.dart';

class TimerDisplay extends StatelessWidget {
  final TimerState timerState;

  const TimerDisplay({super.key, required this.timerState});

  Color _getColor() {
    if (timerState.status == TimerStatus.idle) {
      return Colors.grey;
    }
    return timerState.mode == TimerMode.work ? Colors.blue : Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();

    return Container(
      constraints: const BoxConstraints(
        maxWidth: 400,
        maxHeight: 400,
      ),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(48),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withValues(alpha: 0.1),
                color.withValues(alpha: 0.05),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                timerState.statusText,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: color,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                timerState.formattedTime,
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
