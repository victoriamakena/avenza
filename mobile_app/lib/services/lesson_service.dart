import 'api_service.dart';

class LessonService {
  final ApiService api = ApiService.instance;

  Future<List<dynamic>> getLessons() async {
    final data = await api.get('/lessons');
    return data['lessons'] ?? [];
  }

  Future<void> completeLesson(int lessonId) async {
    await api.post('/lessons/$lessonId/complete');
  }
}