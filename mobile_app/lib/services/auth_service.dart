import 'api_service.dart';

class GoalService {
  final ApiService api;

  GoalService(this.api);

  Future<List<dynamic>> getGoals() async {
    // Connect to Laravel:
    // GET /api/goals

    return [];
  }

  Future<void> createGoal(
    Map<String, dynamic> data,
  ) async {
    // Connect to Laravel:
    // POST /api/goals
  }
}