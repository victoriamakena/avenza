class Lesson {
  final int id;
  final String title;
  final String description;
  final String category;
  final int durationMinutes;
  final bool completed;

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.durationMinutes,
    this.completed = false,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? 'Money Basics',
      durationMinutes: int.tryParse(json['estimated_minutes'].toString()) ?? 5,
      completed: json['completed'] ?? false,
    );
  }
}