import 'package:flutter/material.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({
    required this.isPlaying,
    required this.speed,
    required this.onPlayPause,
    required this.onReset,
    required this.onSpeedChanged,
    super.key,
  });

  final bool isPlaying;
  final double speed;
  final VoidCallback onPlayPause;
  final VoidCallback onReset;
  final ValueChanged<double> onSpeedChanged;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onPlayPause,
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              iconSize: isMobile ? 32 : 40,
              tooltip: isPlaying ? 'Pause' : 'Play',
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: onReset,
              icon: const Icon(Icons.refresh),
              iconSize: isMobile ? 32 : 40,
              tooltip: 'Reset',
            ),
          ],
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Speed',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${speed.toStringAsFixed(1)}x',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Slider(
                value: speed,
                min: 0.5,
                max: 2.0,
                divisions: 15,
                onChanged: onSpeedChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
