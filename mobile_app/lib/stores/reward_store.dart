import 'package:flutter/foundation.dart';
import '../models/achievement.dart';
import '../models/reward.dart';

class RewardStore extends ChangeNotifier {
  int rewardPoints = 120;

  final List<Achievement> achievements = [
    Achievement(
      id: 1,
      title: 'First Step',
      description: 'Create your first savings goal.',
      icon: '🎯',
      xpReward: 50,
      unlocked: true,
    ),
    Achievement(
      id: 2,
      title: 'Consistent Saver',
      description: 'Save regularly for seven days.',
      icon: '🌱',
      xpReward: 100,
      unlocked: false,
    ),
    Achievement(
      id: 3,
      title: 'Money Learner',
      description: 'Complete your first financial lesson.',
      icon: '📚',
      xpReward: 75,
      unlocked: true,
    ),
  ];

  final List<Reward> rewards = [
    Reward(
      id: 1,
      title: 'Airtime Voucher',
      description: 'Demo airtime reward for the prototype.',
      pointsRequired: 100,
      category: 'Airtime',
    ),
    Reward(
      id: 2,
      title: 'Data Voucher',
      description: 'Demo data reward for the prototype.',
      pointsRequired: 200,
      category: 'Data',
    ),
    Reward(
      id: 3,
      title: 'Partner Discount',
      description: 'A simulated partner discount reward.',
      pointsRequired: 300,
      category: 'Discount',
    ),
  ];

  bool redeemReward(Reward reward) {
    if (rewardPoints < reward.pointsRequired) {
      return false;
    }

    rewardPoints -= reward.pointsRequired;
    notifyListeners();

    return true;
  }
}