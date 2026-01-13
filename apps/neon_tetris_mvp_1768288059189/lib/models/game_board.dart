import '../constants/colors.dart';

class GameBoard {
  final List<List<TetrominoType?>> grid;

  GameBoard()
      : grid = List.generate(
          gridHeight,
          (_) => List.filled(gridWidth, null),
        );

  void clear() {
    for (int i = 0; i < gridHeight; i++) {
      for (int j = 0; j < gridWidth; j++) {
        grid[i][j] = null;
      }
    }
  }

  bool isCellEmpty(int row, int col) {
    if (row < 0 || row >= gridHeight || col < 0 || col >= gridWidth) {
      return false;
    }
    return grid[row][col] == null;
  }

  void setCell(int row, int col, TetrominoType? type) {
    if (row >= 0 && row < gridHeight && col >= 0 && col < gridWidth) {
      grid[row][col] = type;
    }
  }

  List<int> getFullRows() {
    final fullRows = <int>[];
    for (int i = 0; i < gridHeight; i++) {
      if (grid[i].every((cell) => cell != null)) {
        fullRows.add(i);
      }
    }
    return fullRows;
  }

  void clearRow(int row) {
    for (int i = row; i > 0; i--) {
      grid[i] = List.from(grid[i - 1]);
    }
    grid[0] = List.filled(gridWidth, null);
  }
}
