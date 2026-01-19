import 'dart:async';
import 'package:flutter/material.dart';
import 'widgets/utc_time_display.dart';
import 'widgets/date_display.dart';
import 'widgets/timezone_info.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  late Timer _timer;
  late DateTime _currentUtcTime;
  late DateTime _currentLocalTime;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    setState(() {
      _currentUtcTime = DateTime.now().toUtc();
      _currentLocalTime = DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 24.0 : 48.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'UTC CLOCK',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w300,
                        letterSpacing: 4,
                      ),
                ),
                const SizedBox(height: 48),
                UTCTimeDisplay(time: _currentUtcTime),
                const SizedBox(height: 32),
                DateDisplay(date: _currentUtcTime),
                const SizedBox(height: 48),
                TimezoneInfo(
                  localTime: _currentLocalTime,
                  utcTime: _currentUtcTime,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
