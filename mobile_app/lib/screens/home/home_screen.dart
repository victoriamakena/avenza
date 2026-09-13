import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../stores/auth_store.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authStore = context.watch<AuthStore>();
    final user = authStore.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Avenza'),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: () async {
              await context.read<AuthStore>().logout();

              if (!context.mounted) return;

              Navigator.popUntil(
                context,
                (route) => route.isFirst,
              );
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.savings_outlined,
                size: 70,
                color: Color(0xFF1E3A8A),
              ),

              const SizedBox(height: 20),

              Text(
                'Welcome, ${user?.name ?? 'Saver'}!',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Your Avenza dashboard will be built here next.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}