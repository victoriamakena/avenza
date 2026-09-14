import 'api_service.dart';

class LessonService {
  final ApiService api;

  LessonService(this.api);

  Future<List<dynamic>> getLessons() async {
    // GET /api/lessons
    return [];
  }

  Future<void> completeLesson(int lessonId) async {
    // POST /api/lessons/{id}/complete
  }
}