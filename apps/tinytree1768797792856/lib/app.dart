import 'package:flutter/material.dart';
import 'features/clock/clock_screen.dart';

class UTCClockApp extends StatelessWidget {
  const UTCClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTC Clock',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      home: const ClockScreen(),
    );
  }
}
