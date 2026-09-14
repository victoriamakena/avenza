import 'package:flutter/material.dart';

import '../../models/goal.dart';
import '../../widgets/goal_card.dart';
import 'create_goal_screen.dart';
import 'goal_details_screen.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  List<Goal> get goals => [
        Goal(
          id: 1,
          name: 'Emergency Fund',
          description:
              'Build a safety cushion',
          targetAmount: 20000,
          savedAmount: 12500,
          targetDate:
              DateTime(2026, 12, 30),
          icon: '🛡️',
        ),

        Goal(
          id: 2,
          name: 'New Laptop',
          description:
              'Save for school and work',
          targetAmount: 60000,
          savedAmount: 18000,
          targetDate:
              DateTime(2027, 3, 30),
          icon: '💻',
        ),

        Goal(
          id: 3,
          name: 'Business Fund',
          description:
              'Start a small business',
          targetAmount: 40000,
          savedAmount: 10000,
          targetDate:
              DateTime(2027, 6, 30),
          icon: '💼',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Goals',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView.separated(
        padding:
            const EdgeInsets.all(20),
        itemCount: goals.length,
        separatorBuilder:
            (_, __) =>
                const SizedBox(height: 14),
        itemBuilder:
            (context, index) {
          final goal = goals[index];

          return GoalCard(
            goal: goal,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      GoalDetailsScreen(
                    goal: goal,
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const CreateGoalScreen(),
            ),
          );
        },
        backgroundColor:
            const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text(
          'New Goal',
        ),
      ),
    );
  }
}