import 'package:counter_app_brown/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CounterApp());
}

/// Main application widget
class CounterApp extends StatelessWidget {
  /// Creates a [CounterApp]
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
