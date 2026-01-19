import 'package:flutter/material.dart';
import '../models/game_state.dart';

class ResultDisplay extends StatelessWidget {
  const ResultDisplay({
    required this.playerChoice,
    required this.computerChoice,
    required this.result,
    super.key,
  });

  final GameChoice? playerChoice;
  final GameChoice? computerChoice;
  final GameResult result;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildChoiceSection(
          label: '컴퓨터',
          icon: '🤖',
          choice: computerChoice,
        ),
        const SizedBox(height: 16),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            color: result != GameResult.none
                ? result.color
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            result != GameResult.none ? result.label : '선택하세요!',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: result != GameResult.none
                  ? Colors.white
                  : const Color(0xFF212121),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildChoiceSection(
          label: '나',
          icon: '👤',
          choice: playerChoice,
        ),
      ],
    );
  }

  Widget _buildChoiceSection({
    required String label,
    required String icon,
    required GameChoice? choice,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            icon,
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF212121),
            ),
          ),
          const SizedBox(width: 24),
          Text(
            choice?.emoji ?? '❓',
            style: const TextStyle(fontSize: 48),
          ),
          const SizedBox(width: 8),
          Text(
            choice?.label ?? '?',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF212121),
            ),
          ),
        ],
      ),
    );
  }
}
