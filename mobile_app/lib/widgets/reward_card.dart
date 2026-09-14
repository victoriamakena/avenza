import 'package:flutter/material.dart';
import '../models/reward.dart';
import '../theme/app_colors.dart';

class RewardCard extends StatelessWidget {
  final Reward reward;
  final VoidCallback? onRedeem;

  const RewardCard({
    super.key,
    required this.reward,
    this.onRedeem,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.lightGold,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.card_giftcard_outlined,
                    color: AppColors.gold,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    reward.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              reward.description,
              style: const TextStyle(
                color: AppColors.secondaryText,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const Icon(
                  Icons.stars_outlined,
                  size: 18,
                  color: AppColors.gold,
                ),
                const SizedBox(width: 5),
                Text(
                  '${reward.pointsRequired} points',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: reward.available ? onRedeem : null,
                  child: const Text('Redeem'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}