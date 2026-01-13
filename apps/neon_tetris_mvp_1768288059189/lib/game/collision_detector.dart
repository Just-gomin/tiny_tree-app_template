import '../models/tetromino.dart';
import '../models/game_board.dart';

class CollisionDetector {
  static bool canPlace(Tetromino tetromino, GameBoard board) {
    for (int i = 0; i < tetromino.shape.length; i++) {
      for (int j = 0; j < tetromino.shape[i].length; j++) {
        if (tetromino.shape[i][j] == 1) {
          final row = tetromino.y + i;
          final col = tetromino.x + j;
          if (!board.isCellEmpty(row, col)) {
            return false;
          }
        }
      }
    }
    return true;
  }

  static bool canMoveLeft(Tetromino tetromino, GameBoard board) {
    final moved = tetromino.copyWith(x: tetromino.x - 1);
    return canPlace(moved, board);
  }

  static bool canMoveRight(Tetromino tetromino, GameBoard board) {
    final moved = tetromino.copyWith(x: tetromino.x + 1);
    return canPlace(moved, board);
  }

  static bool canMoveDown(Tetromino tetromino, GameBoard board) {
    final moved = tetromino.copyWith(y: tetromino.y + 1);
    return canPlace(moved, board);
  }

  static bool canRotate(Tetromino tetromino, GameBoard board) {
    final rotated = tetromino.rotate();
    return canPlace(rotated, board);
  }
}
