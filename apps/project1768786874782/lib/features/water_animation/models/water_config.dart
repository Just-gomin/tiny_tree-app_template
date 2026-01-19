import 'package:flutter/material.dart';

enum WaterColorPreset {
  blue(Color(0xFF2196F3), Color(0xFFE3F2FD)),
  green(Color(0xFF4CAF50), Color(0xFFE8F5E9)),
  purple(Color(0xFF9C27B0), Color(0xFFF3E5F5));

  const WaterColorPreset(this.waterColor, this.backgroundColor);

  final Color waterColor;
  final Color backgroundColor;
}
