import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../stores/auth_store.dart';
import '../../theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthStore>().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CircleAvatar(
            radius: 45,
            backgroundColor: AppColors.lightPrimary,
            child: Icon(
              Icons.person,
              size: 45,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 18),
          Center(
            child: Text(
              user?.name ?? 'Avenza User',
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Center(
            child: Text(
              user?.email ?? '',
              style: const TextStyle(
                color: AppColors.secondaryText,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('XP'),
                  trailing: Text('${user?.xp ?? 0}'),
                ),
                ListTile(
                  title: const Text('Reward Points'),
                  trailing:
                      Text('${user?.rewardPoints ?? 0}'),
                ),
                ListTile(
                  title: const Text('Current Streak'),
                  trailing:
                      Text('${user?.streak ?? 0} days'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}