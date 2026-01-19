import 'package:flutter/material.dart';

class ControlButton extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPressed;

  const ControlButton({
    required this.isPlaying,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
        size: 48,
      ),
      color: Colors.white,
      onPressed: onPressed,
    );
  }
}
