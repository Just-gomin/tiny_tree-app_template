enum TimerStatus { idle, running, paused }
enum TimerMode { work, breakTime }

class TimerState {
  static const int workDuration = 25 * 60;
  static const int breakDuration = 5 * 60;

  final TimerStatus status;
  final TimerMode mode;
  final int remainingSeconds;
  final int completedSessions;

  TimerState({
    this.status = TimerStatus.idle,
    this.mode = TimerMode.work,
    this.remainingSeconds = workDuration,
    this.completedSessions = 0,
  });

  TimerState copyWith({
    TimerStatus? status,
    TimerMode? mode,
    int? remainingSeconds,
    int? completedSessions,
  }) {
    return TimerState(
      status: status ?? this.status,
      mode: mode ?? this.mode,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      completedSessions: completedSessions ?? this.completedSessions,
    );
  }

  String get formattedTime {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String get statusText {
    return mode == TimerMode.work ? 'Work' : 'Break';
  }
}
