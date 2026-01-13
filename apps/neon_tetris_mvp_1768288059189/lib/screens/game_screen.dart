import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../game/game_controller.dart';
import '../widgets/game_grid.dart';
import '../widgets/score_panel.dart';
import '../widgets/next_block_preview.dart';
import '../constants/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = GameController(onUpdate: () {
      if (mounted) setState(() {});
    });
    _controller.start();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowLeft:
          _controller.moveLeft();
          break;
        case LogicalKeyboardKey.arrowRight:
          _controller.moveRight();
          break;
        case LogicalKeyboardKey.arrowUp:
          _controller.rotate();
          break;
        case LogicalKeyboardKey.arrowDown:
          _controller.moveDown();
          break;
        case LogicalKeyboardKey.space:
          _controller.hardDrop();
          break;
        case LogicalKeyboardKey.keyP:
          _controller.pause();
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: _handleKeyEvent,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final maxWidth = constraints.maxWidth;
                        if (maxWidth > 800) {
                          return _buildWideLayout();
                        } else {
                          return _buildNarrowLayout();
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildControls(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '⚡ NEON TETRIS ⚡',
          style: TextStyle(
            color: Color(0xFF00F0FF),
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
            shadows: [
              Shadow(
                color: Color(0xFF00F0FF),
                blurRadius: 20,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        if (_controller.state.isPaused)
          const Text(
            '[PAUSED]',
            style: TextStyle(
              color: Color(0xFFFFFF00),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }

  Widget _buildWideLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            NextBlockPreview(nextPiece: _controller.nextPiece),
            const SizedBox(height: 16),
            ScorePanel(state: _controller.state),
          ],
        ),
        const SizedBox(width: 24),
        GameGrid(
          board: _controller.board,
          currentPiece: _controller.currentPiece,
        ),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NextBlockPreview(nextPiece: _controller.nextPiece),
            const SizedBox(width: 16),
            ScorePanel(state: _controller.state),
          ],
        ),
        const SizedBox(height: 16),
        GameGrid(
          board: _controller.board,
          currentPiece: _controller.currentPiece,
        ),
      ],
    );
  }

  Widget _buildControls() {
    return Column(
      children: [
        if (_controller.state.isGameOver)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                const Text(
                  'GAME OVER',
                  style: TextStyle(
                    color: Color(0xFFFF0040),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Color(0xFFFF0040),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _controller.start();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00F0FF),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                  child: const Text(
                    'NEW GAME',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _controller.pause,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFFF00),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: Text(
                  _controller.state.isPaused ? 'RESUME' : 'PAUSE',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _controller.start();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00F0FF),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'NEW GAME',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        const SizedBox(height: 16),
        const Text(
          'Controls: ← → Move | ↑ Rotate | ↓ Drop | SPACE Hard Drop | P Pause',
          style: TextStyle(
            color: Color(0x99FFFFFF),
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
