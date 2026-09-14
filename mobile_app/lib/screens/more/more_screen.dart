import 'package:flutter/material.dart';

import '../rewards/achievements_screen.dart';
import '../rewards/rewards_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'accessibility_screen.dart';
import 'about_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _item(
            context,
            Icons.person_outline,
            'Profile',
            'Manage your personal information',
            const ProfileScreen(),
          ),
          _item(
            context,
            Icons.emoji_events_outlined,
            'Achievements',
            'View your savings milestones',
            const AchievementsScreen(),
          ),
          _item(
            context,
            Icons.card_giftcard_outlined,
            'Rewards',
            'View your available rewards',
            const RewardsScreen(),
          ),
          _item(
            context,
            Icons.settings_outlined,
            'Settings',
            'Manage your app preferences',
            const SettingsScreen(),
          ),
          _item(
            context,
            Icons.accessibility_new_outlined,
            'Accessibility',
            'Adjust accessibility preferences',
            const AccessibilityScreen(),
          ),
          _item(
            context,
            Icons.info_outline,
            'About Avenza',
            'Learn more about the project',
            const AboutScreen(),
          ),
        ],
      ),
    );
  }

  Widget _item(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Widget screen,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => screen,
            ),
          );
        },
      ),
    );
  }
}