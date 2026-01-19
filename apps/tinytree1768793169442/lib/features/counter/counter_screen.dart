import 'package:flutter/material.dart';
import 'package:storage/storage.dart';

import 'widgets/counter_actions.dart';
import 'widgets/counter_display.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  static const String _storageKey = 'counter_value';
  final StorageRepository _storage = SharedPreferencesStorage();

  int _counter = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    try {
      final value = await _storage.get(_storageKey);
      if (value != null) {
        setState(() {
          _counter = int.parse(value);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveCounter() async {
    try {
      await _storage.save(_storageKey, _counter.toString());
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('저장 중 오류가 발생했습니다')),
        );
      }
    }
  }

  void _increment() {
    setState(() {
      _counter++;
    });
    _saveCounter();
  }

  void _decrement() {
    setState(() {
      _counter--;
    });
    _saveCounter();
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
    _saveCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('초록색 카운터 앱'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CounterDisplay(counter: _counter),
                  const SizedBox(height: 48),
                  CounterActions(
                    onIncrement: _increment,
                    onDecrement: _decrement,
                    onReset: _reset,
                  ),
                ],
              ),
            ),
    );
  }
}
