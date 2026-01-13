import '../constants/colors.dart';

class Tetromino {
  final TetrominoType type;
  final List<List<int>> shape;
  int x;
  int y;

  Tetromino({
    required this.type,
    required this.shape,
    this.x = 3,
    this.y = 0,
  });

  static Tetromino random() {
    final types = TetrominoType.values;
    final type = types[DateTime.now().millisecondsSinceEpoch % types.length];
    return Tetromino(type: type, shape: getShape(type));
  }

  static List<List<int>> getShape(TetrominoType type) {
    switch (type) {
      case TetrominoType.I:
        return [
          [0, 0, 0, 0],
          [1, 1, 1, 1],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
        ];
      case TetrominoType.O:
        return [
          [1, 1],
          [1, 1],
        ];
      case TetrominoType.T:
        return [
          [0, 1, 0],
          [1, 1, 1],
          [0, 0, 0],
        ];
      case TetrominoType.S:
        return [
          [0, 1, 1],
          [1, 1, 0],
          [0, 0, 0],
        ];
      case TetrominoType.Z:
        return [
          [1, 1, 0],
          [0, 1, 1],
          [0, 0, 0],
        ];
      case TetrominoType.J:
        return [
          [1, 0, 0],
          [1, 1, 1],
          [0, 0, 0],
        ];
      case TetrominoType.L:
        return [
          [0, 0, 1],
          [1, 1, 1],
          [0, 0, 0],
        ];
    }
  }

  Tetromino rotate() {
    final n = shape.length;
    final rotated = List.generate(n, (_) => List.filled(n, 0));
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        rotated[j][n - 1 - i] = shape[i][j];
      }
    }
    return Tetromino(type: type, shape: rotated, x: x, y: y);
  }

  Tetromino copyWith({int? x, int? y}) {
    return Tetromino(
      type: type,
      shape: shape,
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }
}
