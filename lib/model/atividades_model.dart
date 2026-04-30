class Activity {
  final String id;
  final String title;
  bool isCompleted;
  final int calories;
  final int durationMinutes;

  Activity({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.calories = 0,
    this.durationMinutes = 0,
  });
}
