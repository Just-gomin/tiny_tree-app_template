import 'package:flutter/material.dart';
import '../models/game_state.dart';

class ScorePanel extends StatelessWidget {
  final GameState state;

  const ScorePanel({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0x33007FFF), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildStat('SCORE', state.score.toString()),
          const SizedBox(height: 16),
          _buildStat('LEVEL', state.level.toString()),
          const SizedBox(height: 16),
          _buildStat('LINES', state.linesCleared.toString()),
          const SizedBox(height: 16),
          _buildStat('HI-SCORE', state.highScore.toString()),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF00F0FF),
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Color(0xFF00F0FF),
                blurRadius: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
