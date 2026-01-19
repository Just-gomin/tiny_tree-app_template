import 'dart:math';
import 'package:flutter/material.dart';

enum GameChoice {
  rock('바위', '✊'),
  paper('보', '✋'),
  scissors('가위', '✌️');

  const GameChoice(this.label, this.emoji);
  final String label;
  final String emoji;
}

enum GameResult {
  win('승리!', Color(0xFF2E7D32)),
  lose('패배!', Color(0xFFC62828)),
  draw('무승부!', Color(0xFFF57C00)),
  none('', Color(0x00000000));

  const GameResult(this.label, this.color);
  final String label;
  final Color color;
}

class GameState {
  GameState({
    this.playerChoice,
    this.computerChoice,
    this.result = GameResult.none,
    this.wins = 0,
    this.losses = 0,
    this.draws = 0,
  });

  final GameChoice? playerChoice;
  final GameChoice? computerChoice;
  final GameResult result;
  final int wins;
  final int losses;
  final int draws;

  static final Random _random = Random();

  static GameChoice getRandomChoice() {
    return GameChoice.values[_random.nextInt(GameChoice.values.length)];
  }

  static GameResult judge(GameChoice player, GameChoice computer) {
    if (player == computer) return GameResult.draw;

    if ((player == GameChoice.scissors && computer == GameChoice.paper) ||
        (player == GameChoice.rock && computer == GameChoice.scissors) ||
        (player == GameChoice.paper && computer == GameChoice.rock)) {
      return GameResult.win;
    }

    return GameResult.lose;
  }

  GameState play(GameChoice choice) {
    final GameChoice computer = getRandomChoice();
    final GameResult gameResult = judge(choice, computer);

    return GameState(
      playerChoice: choice,
      computerChoice: computer,
      result: gameResult,
      wins: wins + (gameResult == GameResult.win ? 1 : 0),
      losses: losses + (gameResult == GameResult.lose ? 1 : 0),
      draws: draws + (gameResult == GameResult.draw ? 1 : 0),
    );
  }

  GameState reset() {
    return GameState();
  }
}
