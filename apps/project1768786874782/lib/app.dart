import 'package:flutter/material.dart';
import 'features/water_animation/water_animation_screen.dart';

class WaterAnimationApp extends StatelessWidget {
  const WaterAnimationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Fill Animation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2196F3),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const WaterAnimationScreen(),
    );
  }
}
