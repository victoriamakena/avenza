import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../stores/reward_store.dart';
import '../../theme/app_colors.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<RewardStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Your achievements',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Build healthy financial habits and unlock milestones along the way.',
            style: TextStyle(
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(height: 24),

          ...store.achievements.map(
            (achievement) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: CircleAvatar(
                  radius: 28,
                  backgroundColor: achievement.unlocked
                      ? AppColors.lightGold
                      : Colors.grey.shade200,
                  child: Text(
                    achievement.icon,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                title: Text(
                  achievement.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    achievement.description,
                  ),
                ),
                trailing: achievement.unlocked
                    ? const Icon(
                        Icons.check_circle,
                        color: AppColors.emerald,
                      )
                    : Text(
                        '+${achievement.xpReward} XP',
                        style: const TextStyle(
                          color: AppColors.secondaryText,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}