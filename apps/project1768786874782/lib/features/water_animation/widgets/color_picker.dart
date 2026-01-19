import 'package:flutter/material.dart';
import '../models/water_config.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({
    required this.selectedColor,
    required this.onColorChanged,
    super.key,
  });

  final WaterColorPreset selectedColor;
  final ValueChanged<WaterColorPreset> onColorChanged;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    final double size = isMobile ? 48 : 56;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: WaterColorPreset.values.map((preset) {
        final bool isSelected = preset == selectedColor;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: InkWell(
            onTap: () => onColorChanged(preset),
            customBorder: const CircleBorder(),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: preset.waterColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.black : Colors.transparent,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
