enum Priority { high, medium, low }

enum ActionCategory { price, photos, schedule, description, operation }

class ActionItem {
  final String title;
  final String description;
  final Priority priority;
  final ActionCategory category;
  bool isCompleted;

  ActionItem({
    required this.title,
    required this.description,
    required this.priority,
    required this.category,
    this.isCompleted = false,
  });
}

class CoachingFeedback {
  final String diagnosis;
  final List<ActionItem> actions;
  final String expectedImpact;

  CoachingFeedback({
    required this.diagnosis,
    required this.actions,
    required this.expectedImpact,
  });
}
