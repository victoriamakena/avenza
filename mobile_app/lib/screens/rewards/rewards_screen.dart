import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../stores/reward_store.dart';
import '../../theme/app_colors.dart';
import '../../widgets/reward_card.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<RewardStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewards'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            color: AppColors.lightGold,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Icon(
                    Icons.stars,
                    color: AppColors.gold,
                    size: 35,
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Reward Points',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${store.rewardPoints}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Available rewards',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          ...store.rewards.map(
            (reward) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: RewardCard(
                reward: reward,
                onRedeem: () async {
                      final success = await context.read<RewardStore>().redeemReward(reward);

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            success
                                ? 'Reward redeemed successfully.'
                                : 'You need more points for this reward.',
                          ),
                        ),
                      );
},
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Prototype note: rewards are simulated and do not represent real-money payouts.',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}