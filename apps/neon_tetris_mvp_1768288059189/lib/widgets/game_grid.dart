import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/game_board.dart';
import '../models/tetromino.dart';
import 'block_widget.dart';

class GameGrid extends StatelessWidget {
  final GameBoard board;
  final Tetromino? currentPiece;
  final double blockSize;

  const GameGrid({
    super.key,
    required this.board,
    this.currentPiece,
    this.blockSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: gridLineColor, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(gridHeight, (row) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(gridWidth, (col) {
              return _buildCell(row, col);
            }),
          );
        }),
      ),
    );
  }

  Widget _buildCell(int row, int col) {
    TetrominoType? cellType = board.grid[row][col];

    if (currentPiece != null) {
      final relRow = row - currentPiece!.y;
      final relCol = col - currentPiece!.x;
      if (relRow >= 0 &&
          relRow < currentPiece!.shape.length &&
          relCol >= 0 &&
          relCol < currentPiece!.shape[relRow].length &&
          currentPiece!.shape[relRow][relCol] == 1) {
        cellType = currentPiece!.type;
      }
    }

    if (cellType != null) {
      return BlockWidget(type: cellType, size: blockSize);
    }

    return Container(
      width: blockSize,
      height: blockSize,
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        border: Border.all(color: gridLineColor, width: 0.5),
      ),
    );
  }
}
