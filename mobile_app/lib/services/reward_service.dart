import 'api_service.dart';

class RewardService {
  final ApiService api = ApiService.instance;

  Future<Map<String, dynamic>> getRewards() async {
    return await api.get('/rewards'); // { reward_points, rewards }
  }

  Future<List<dynamic>> getAchievements() async {
    final data = await api.get('/achievements');
    return data['achievements'] ?? [];
  }

  Future<void> redeemReward(int rewardId) async {
    await api.post('/rewards/$rewardId/redeem');
  }
}