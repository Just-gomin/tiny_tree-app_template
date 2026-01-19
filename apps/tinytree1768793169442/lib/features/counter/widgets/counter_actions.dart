import 'package:flutter/material.dart';

class CounterActions extends StatelessWidget {
  const CounterActions({
    required this.onIncrement,
    required this.onDecrement,
    required this.onReset,
    super.key,
  });

  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 600;

    if (isWideScreen) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.large(
            onPressed: onDecrement,
            heroTag: 'decrement',
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 24),
          FilledButton(
            onPressed: onReset,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text('Reset', style: TextStyle(fontSize: 18)),
            ),
          ),
          const SizedBox(width: 24),
          FloatingActionButton.large(
            onPressed: onIncrement,
            heroTag: 'increment',
            child: const Icon(Icons.add),
          ),
        ],
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: onDecrement,
              heroTag: 'decrement',
              child: const Icon(Icons.remove),
            ),
            const SizedBox(width: 24),
            FloatingActionButton(
              onPressed: onIncrement,
              heroTag: 'increment',
              child: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: onReset,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            child: Text('Reset', style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}
