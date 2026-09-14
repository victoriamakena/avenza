import 'package:flutter/foundation.dart';
import '../models/lesson.dart';
import '../services/lesson_service.dart';

class LearnStore extends ChangeNotifier {
  final LessonService _lessonService = LessonService();

  List<Lesson> _lessons = [];
  bool isLoading = false;
  String? errorMessage;

  List<Lesson> get lessons => List.unmodifiable(_lessons);

  Future<void> fetchLessons() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final json = await _lessonService.getLessons();
      _lessons = json.map((j) => Lesson.fromJson(j)).toList();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> completeLesson(int id) async {
    try {
      await _lessonService.completeLesson(id);
      await fetchLessons();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}