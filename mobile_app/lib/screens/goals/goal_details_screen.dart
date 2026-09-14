import 'package:flutter/material.dart';

import '../../models/goal.dart';
import '../../widgets/avenza_button.dart';

class GoalDetailsScreen
    extends StatelessWidget {
  final Goal goal;

  const GoalDetailsScreen({
    super.key,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    final percentage =
        (goal.progress * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Goal details',
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 90,
                width: 90,
                decoration:
                    BoxDecoration(
                  color:
                      const Color(0xFFDBEAFE),
                  borderRadius:
                      BorderRadius.circular(26),
                ),
                child: Center(
                  child: Text(
                    goal.icon,
                    style:
                        const TextStyle(
                      fontSize: 45,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: Text(
                goal.name,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Center(
              child: Text(
                goal.description,
                textAlign:
                    TextAlign.center,
                style: const TextStyle(
                  color:
                      Color(0xFF6B7280),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Container(
              padding:
                  const EdgeInsets.all(20),
              decoration:
                  BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    'KSh ${goal.savedAmount.toStringAsFixed(0)}',
                    style:
                        const TextStyle(
                      fontSize: 32,
                      fontWeight:
                          FontWeight.bold,
                      color:
                          Color(0xFF10B981),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'of KSh ${goal.targetAmount.toStringAsFixed(0)}',
                    style:
                        const TextStyle(
                      color:
                          Color(0xFF6B7280),
                    ),
                  ),

                  const SizedBox(height: 20),

                  LinearProgressIndicator(
                    value:
                        goal.progress,
                    minHeight: 12,
                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),
                    color:
                        const Color(
                      0xFF10B981,
                    ),
                    backgroundColor:
                        const Color(
                      0xFFE5E7EB,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    '$percentage% complete',
                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: _InfoCard(
                    title: 'Remaining',
                    value:
                        'KSh ${goal.remaining.toStringAsFixed(0)}',
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _InfoCard(
                    title: 'Target date',
                    value:
                        '${goal.targetDate.day}/'
                        '${goal.targetDate.month}/'
                        '${goal.targetDate.year}',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            AvenzaButton(
              text: 'Save Now',
              icon: Icons.add,
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Saving is simulated in Phase 1.',
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            OutlinedButton(
              onPressed: () {},
              style:
                  OutlinedButton.styleFrom(
                minimumSize:
                    const Size(
                  double.infinity,
                  52,
                ),
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),
              ),
              child: const Text(
                'View Savings Activity',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;

  const _InfoCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color:
                  Color(0xFF6B7280),
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            value,
            style: const TextStyle(
              fontWeight:
                  FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}