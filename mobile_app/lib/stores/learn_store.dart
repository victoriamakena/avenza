import 'package:flutter/foundation.dart';
import '../models/lesson.dart';

class LearnStore extends ChangeNotifier {
  final List<Lesson> _lessons = [
    Lesson(
      id: 1,
      title: 'Why Should I Save?',
      description:
          'Understand why small, regular savings can make a difference.',
      category: 'Money Basics',
      durationMinutes: 5,
    ),
    Lesson(
      id: 2,
      title: 'Building an Emergency Fund',
      description:
          'Learn how to prepare for unexpected expenses.',
      category: 'Saving',
      durationMinutes: 7,
    ),
    Lesson(
      id: 3,
      title: 'Needs vs Wants',
      description:
          'Learn how to make better everyday spending decisions.',
      category: 'Budgeting',
      durationMinutes: 6,
    ),
    Lesson(
      id: 4,
      title: 'Creating a Simple Budget',
      description:
          'Learn an easy way to plan your money each month.',
      category: 'Budgeting',
      durationMinutes: 8,
    ),
  ];

  List<Lesson> get lessons => List.unmodifiable(_lessons);

  void completeLesson(int id) {
    final index = _lessons.indexWhere((lesson) => lesson.id == id);

    if (index == -1) return;

    final lesson = _lessons[index];

    _lessons[index] = Lesson(
      id: lesson.id,
      title: lesson.title,
      description: lesson.description,
      category: lesson.category,
      durationMinutes: lesson.durationMinutes,
      completed: true,
    );

    notifyListeners();
  }
}