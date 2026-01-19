import 'dart:async';
import 'package:flutter/material.dart';
import '../../data/greetings_data.dart';
import 'widgets/control_button.dart';
import 'widgets/greeting_display.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool _isPlaying = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % greetingsData.length;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _startTimer();
      } else {
        _stopTimer();
      }
    });
  }

  void _nextGreeting() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % greetingsData.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    final double padding = isMobile ? 24 : 48;

    return Scaffold(
      body: GestureDetector(
        onTap: _nextGreeting,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF1A1A2E),
                Color(0xFF16213E),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: ControlButton(
                      isPlaying: _isPlaying,
                      onPressed: _togglePlayPause,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        switchInCurve: Curves.easeInOut,
                        switchOutCurve: Curves.easeInOut,
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: GreetingDisplay(
                          key: ValueKey<int>(_currentIndex),
                          greeting: greetingsData[_currentIndex],
                          isMobile: isMobile,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '${_currentIndex + 1} / ${greetingsData.length}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
