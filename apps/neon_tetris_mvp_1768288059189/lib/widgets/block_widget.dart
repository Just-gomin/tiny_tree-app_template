import 'package:flutter/material.dart';
import '../constants/colors.dart';

class BlockWidget extends StatelessWidget {
  final TetrominoType type;
  final double size;

  const BlockWidget({
    super.key,
    required this.type,
    this.size = 30,
  });

  @override
  Widget build(BuildContext context) {
    final color = neonColors[type]!;
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color, width: 2),
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}
