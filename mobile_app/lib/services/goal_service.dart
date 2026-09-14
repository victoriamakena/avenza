import 'api_service.dart';

class GoalService {
  final ApiService api = ApiService.instance;

  Future<List<dynamic>> getGoals() async {
    final data = await api.get('/goals');
    return data['goals'] ?? [];
  }

  Future<Map<String, dynamic>> createGoal(Map<String, dynamic> data) async {
    final response = await api.post('/goals', data);
    return response['goal'];
  }

  Future<void> addSavings(int goalId, double amount) async {
    await api.post('/savings', {
      'goal_id': goalId,
      'amount': amount,
    });
  }
}