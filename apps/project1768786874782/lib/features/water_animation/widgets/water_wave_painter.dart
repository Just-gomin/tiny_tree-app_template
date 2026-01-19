import 'dart:math';
import 'package:flutter/material.dart';

class WaterWavePainter extends CustomPainter {
  WaterWavePainter({
    required this.animationValue,
    required this.waterColor,
    this.waveHeight = 20.0,
    this.waveFrequency = 2.0,
  });

  final double animationValue;
  final Color waterColor;
  final double waveHeight;
  final double waveFrequency;

  @override
  void paint(Canvas canvas, Size size) {
    final double waterLevel = size.height * (1 - animationValue);
    final Paint waterPaint = Paint()
      ..color = waterColor
      ..style = PaintingStyle.fill;

    final Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, waterLevel);

    for (double x = 0; x <= size.width; x++) {
      final double y = waterLevel +
          sin((x / size.width * waveFrequency * 2 * pi) +
                  (animationValue * 2 * pi)) *
              waveHeight;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, waterPaint);
  }

  @override
  bool shouldRepaint(WaterWavePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.waterColor != waterColor;
  }
}
