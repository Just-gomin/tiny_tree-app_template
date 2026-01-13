import 'dart:async';
import 'dart:math';
import '../models/tetromino.dart';
import '../models/game_board.dart';
import '../models/game_state.dart';
import '../constants/colors.dart';
import 'collision_detector.dart';

class GameController {
  final GameBoard board = GameBoard();
  final GameState state = GameState();
  Tetromino? currentPiece;
  Tetromino? nextPiece;
  Timer? gameTimer;
  final Random _random = Random();

  final void Function() onUpdate;

  GameController({required this.onUpdate});

  void start() {
    board.clear();
    state.reset();
    _spawnNewPiece();
    _spawnNextPiece();
    _startGameLoop();
    onUpdate();
  }

  void pause() {
    state.isPaused = !state.isPaused;
    if (state.isPaused) {
      gameTimer?.cancel();
    } else {
      _startGameLoop();
    }
    onUpdate();
  }

  void _startGameLoop() {
    gameTimer?.cancel();
    final speed = max(
      100,
      initialDropSpeed - (state.level - 1) * levelSpeedDecrease,
    );
    gameTimer = Timer.periodic(Duration(milliseconds: speed), (_) {
      if (!state.isPaused && !state.isGameOver) {
        _tick();
      }
    });
  }

  void _tick() {
    if (currentPiece == null) return;

    if (CollisionDetector.canMoveDown(currentPiece!, board)) {
      currentPiece = currentPiece!.copyWith(y: currentPiece!.y + 1);
    } else {
      _lockPiece();
      _clearLines();
      _spawnNewPiece();
      if (!CollisionDetector.canPlace(currentPiece!, board)) {
        state.isGameOver = true;
        gameTimer?.cancel();
      }
    }
    onUpdate();
  }

  void _spawnNewPiece() {
    if (nextPiece != null) {
      currentPiece = Tetromino(
        type: nextPiece!.type,
        shape: nextPiece!.shape,
        x: 3,
        y: 0,
      );
    } else {
      currentPiece = _generateRandomPiece();
    }
    _spawnNextPiece();
  }

  void _spawnNextPiece() {
    nextPiece = _generateRandomPiece();
  }

  Tetromino _generateRandomPiece() {
    final types = TetrominoType.values;
    final type = types[_random.nextInt(types.length)];
    return Tetromino(type: type, shape: Tetromino.getShape(type));
  }

  void _lockPiece() {
    if (currentPiece == null) return;
    for (int i = 0; i < currentPiece!.shape.length; i++) {
      for (int j = 0; j < currentPiece!.shape[i].length; j++) {
        if (currentPiece!.shape[i][j] == 1) {
          board.setCell(
            currentPiece!.y + i,
            currentPiece!.x + j,
            currentPiece!.type,
          );
        }
      }
    }
  }

  void _clearLines() {
    final fullRows = board.getFullRows();
    if (fullRows.isEmpty) return;

    for (final row in fullRows.reversed) {
      board.clearRow(row);
    }

    final points = state.calculateScore(fullRows.length);
    state.addScore(points);
    state.addLines(fullRows.length);
    _startGameLoop();
  }

  void moveLeft() {
    if (currentPiece == null || state.isGameOver || state.isPaused) return;
    if (CollisionDetector.canMoveLeft(currentPiece!, board)) {
      currentPiece = currentPiece!.copyWith(x: currentPiece!.x - 1);
      onUpdate();
    }
  }

  void moveRight() {
    if (currentPiece == null || state.isGameOver || state.isPaused) return;
    if (CollisionDetector.canMoveRight(currentPiece!, board)) {
      currentPiece = currentPiece!.copyWith(x: currentPiece!.x + 1);
      onUpdate();
    }
  }

  void moveDown() {
    if (currentPiece == null || state.isGameOver || state.isPaused) return;
    if (CollisionDetector.canMoveDown(currentPiece!, board)) {
      currentPiece = currentPiece!.copyWith(y: currentPiece!.y + 1);
      onUpdate();
    }
  }

  void rotate() {
    if (currentPiece == null || state.isGameOver || state.isPaused) return;
    if (CollisionDetector.canRotate(currentPiece!, board)) {
      currentPiece = currentPiece!.rotate();
      onUpdate();
    }
  }

  void hardDrop() {
    if (currentPiece == null || state.isGameOver || state.isPaused) return;
    while (CollisionDetector.canMoveDown(currentPiece!, board)) {
      currentPiece = currentPiece!.copyWith(y: currentPiece!.y + 1);
    }
    onUpdate();
  }

  void dispose() {
    gameTimer?.cancel();
  }
}
