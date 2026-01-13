class GameState {
  int score;
  int level;
  int linesCleared;
  int highScore;
  bool isGameOver;
  bool isPaused;

  GameState({
    this.score = 0,
    this.level = 1,
    this.linesCleared = 0,
    this.highScore = 0,
    this.isGameOver = false,
    this.isPaused = false,
  });

  void reset() {
    score = 0;
    level = 1;
    linesCleared = 0;
    isGameOver = false;
    isPaused = false;
  }

  void addScore(int points) {
    score += points;
    if (score > highScore) {
      highScore = score;
    }
  }

  void addLines(int lines) {
    linesCleared += lines;
    level = (linesCleared ~/ 10) + 1;
  }

  int calculateScore(int lines) {
    switch (lines) {
      case 1:
        return 100 * level;
      case 2:
        return 300 * level;
      case 3:
        return 500 * level;
      case 4:
        return 800 * level;
      default:
        return 0;
    }
  }
}
