import 'package:flutter/material.dart';
import 'screens/game_screen.dart';

void main() {
  runApp(const NeonTetrisApp());
}

class NeonTetrisApp extends StatelessWidget {
  const NeonTetrisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neon Tetris',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00F0FF),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const GameScreen(),
    );
  }
}
