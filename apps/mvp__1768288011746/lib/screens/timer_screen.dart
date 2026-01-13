import 'dart:async';
import 'package:flutter/material.dart';
import '../models/timer_state.dart';
import '../widgets/timer_display.dart';
import '../widgets/control_buttons.dart';
import '../widgets/session_counter.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late TimerState _timerState;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timerState = TimerState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    if (_timerState.status == TimerStatus.running) return;

    setState(() {
      _timerState = _timerState.copyWith(status: TimerStatus.running);
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerState.remainingSeconds > 0) {
        setState(() {
          _timerState = _timerState.copyWith(
            remainingSeconds: _timerState.remainingSeconds - 1,
          );
        });
      } else {
        _onTimerComplete();
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() {
      _timerState = _timerState.copyWith(status: TimerStatus.paused);
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _timerState = TimerState(
        completedSessions: _timerState.completedSessions,
      );
    });
  }

  void _onTimerComplete() {
    _timer?.cancel();

    if (_timerState.mode == TimerMode.work) {
      setState(() {
        _timerState = _timerState.copyWith(
          status: TimerStatus.idle,
          mode: TimerMode.breakTime,
          remainingSeconds: TimerState.breakDuration,
          completedSessions: _timerState.completedSessions + 1,
        );
      });
      _showNotification('Work session complete! Time for a break.');
      _startTimer();
    } else {
      setState(() {
        _timerState = _timerState.copyWith(
          status: TimerStatus.idle,
          mode: TimerMode.work,
          remainingSeconds: TimerState.workDuration,
        );
      });
      _showNotification('Break complete! Ready for next session?');
    }
  }

  void _showNotification(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _resetSessions() {
    setState(() {
      _timerState = _timerState.copyWith(completedSessions: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Pomodoro Timer'),
            SizedBox(width: 8),
            Text('🍅', style: TextStyle(fontSize: 24)),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TimerDisplay(timerState: _timerState),
                  const SizedBox(height: 32),
                  ControlButtons(
                    timerState: _timerState,
                    onStart: _startTimer,
                    onPause: _pauseTimer,
                    onReset: _resetTimer,
                  ),
                  const SizedBox(height: 48),
                  SessionCounter(
                    completedSessions: _timerState.completedSessions,
                    onReset: _resetSessions,
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
