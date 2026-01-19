import 'package:flutter/material.dart';
import 'models/game_state.dart';
import 'widgets/choice_button.dart';
import 'widgets/result_display.dart';
import 'widgets/score_board.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  GameState _gameState = GameState();

  void _onChoiceSelected(GameChoice choice) {
    setState(() {
      _gameState = _gameState.play(choice);
    });
  }

  void _onReset() {
    setState(() {
      _gameState = _gameState.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final bool isWide = constraints.maxWidth > 600;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 48 : 16,
                vertical: 24,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    children: [
                      Text(
                        '가위바위보 게임',
                        style: TextStyle(
                          fontSize: isWide ? 48 : 32,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF212121),
                        ),
                      ),
                      const SizedBox(height: 32),
                      ResultDisplay(
                        playerChoice: _gameState.playerChoice,
                        computerChoice: _gameState.computerChoice,
                        result: _gameState.result,
                      ),
                      const SizedBox(height: 32),
                      _buildChoiceButtons(isWide),
                      const SizedBox(height: 32),
                      ScoreBoard(
                        wins: _gameState.wins,
                        losses: _gameState.losses,
                        draws: _gameState.draws,
                        onReset: _onReset,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildChoiceButtons(bool isWide) {
    final List<Widget> buttons = GameChoice.values
        .map(
          (GameChoice choice) => ChoiceButton(
            choice: choice,
            onPressed: () => _onChoiceSelected(choice),
          ),
        )
        .toList();

    if (isWide) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: buttons,
      );
    }

    return Wrap(
      alignment: WrapAlignment.center,
      children: buttons,
    );
  }
}
