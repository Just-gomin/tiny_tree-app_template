import 'dart:async';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'services/clock_service.dart';
import 'widgets/digital_clock.dart';
import 'widgets/date_display.dart';
import 'widgets/timezone_selector.dart';
import 'widgets/time_format_toggle.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  final ClockService _clockService = ClockService();
  late Timer _timer;
  late DateTime _currentTime;
  late String _selectedTimezone;
  late bool _is24HourFormat;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    try {
      final settings = await _clockService.loadSettings();
      setState(() {
        _selectedTimezone = settings.timezone;
        _is24HourFormat = settings.is24HourFormat;
        _currentTime = _clockService.getTimeForTimezone(_selectedTimezone);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _selectedTimezone = 'Asia/Seoul';
        _is24HourFormat = true;
        _currentTime = _clockService.getTimeForTimezone(_selectedTimezone);
        _isLoading = false;
      });
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _currentTime = _clockService.getTimeForTimezone(_selectedTimezone);
      });
    });
  }

  Future<void> _onTimezoneChanged(String timezone) async {
    setState(() {
      _selectedTimezone = timezone;
      _currentTime = _clockService.getTimeForTimezone(_selectedTimezone);
    });
    await _clockService.saveTimezone(timezone);
  }

  Future<void> _onFormatChanged(bool is24Hour) async {
    setState(() {
      _is24HourFormat = is24Hour;
    });
    await _clockService.saveTimeFormat(is24Hour);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final selectedTimezoneInfo = ClockService.timezones.firstWhere(
      (tz) => tz.name == _selectedTimezone,
      orElse: () => ClockService.timezones.first,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Green Clock App'),
      ),
      body: Container(
        decoration: AppTheme.backgroundGradient,
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 600;
              final padding = isDesktop ? 64.0 : 24.0;

              return Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${selectedTimezoneInfo.displayName} Time',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 48),
                        DigitalClock(
                          time: _currentTime,
                          is24HourFormat: _is24HourFormat,
                        ),
                        const SizedBox(height: 24),
                        DateDisplay(date: _currentTime),
                        const SizedBox(height: 64),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 400),
                          child: Column(
                            children: [
                              TimezoneSelector(
                                selectedTimezone: _selectedTimezone,
                                onTimezoneChanged: _onTimezoneChanged,
                              ),
                              const SizedBox(height: 16),
                              TimeFormatToggle(
                                is24HourFormat: _is24HourFormat,
                                onFormatChanged: _onFormatChanged,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
