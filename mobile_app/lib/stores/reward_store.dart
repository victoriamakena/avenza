import 'package:flutter/foundation.dart';
import '../models/achievement.dart';
import '../models/reward.dart';
import '../services/reward_service.dart';

class RewardStore extends ChangeNotifier {
  final RewardService _rewardService = RewardService();

  int rewardPoints = 0;
  List<Achievement> achievements = [];
  List<Reward> rewards = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchRewards() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final data = await _rewardService.getRewards();
      rewardPoints = data['reward_points'] ?? 0;

      final List rewardsJson = data['rewards'] ?? [];
      rewards = rewardsJson.map((json) => Reward.fromJson(json)).toList();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAchievements() async {
    try {
      final json = await _rewardService.getAchievements();
      achievements = json.map((j) => Achievement.fromJson(j)).toList();
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<bool> redeemReward(Reward reward) async {
    if (rewardPoints < reward.pointsRequired) return false;

    try {
      await _rewardService.redeemReward(reward.id);
      await fetchRewards();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}