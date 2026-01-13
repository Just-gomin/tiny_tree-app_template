import 'package:flutter/material.dart';
import '../models/tetromino.dart';
import 'block_widget.dart';

class NextBlockPreview extends StatelessWidget {
  final Tetromino? nextPiece;

  const NextBlockPreview({
    super.key,
    this.nextPiece,
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
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'NEXT',
            style: TextStyle(
              color: Color(0xFF00F0FF),
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          if (nextPiece != null)
            SizedBox(
              width: 100,
              height: 100,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(nextPiece!.shape.length, (i) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(nextPiece!.shape[i].length, (j) {
                        if (nextPiece!.shape[i][j] == 1) {
                          return BlockWidget(
                            type: nextPiece!.type,
                            size: 20,
                          );
                        }
                        return const SizedBox(width: 22, height: 22);
                      }),
                    );
                  }),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
