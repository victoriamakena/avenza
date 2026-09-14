import 'package:flutter/material.dart';

import '../../widgets/progress_card.dart';
import '../../widgets/section_title.dart';
import '../../widgets/stat_card.dart';
import '../../navigation/app_navigation.dart';
import '../goals/create_goal_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Good morning 👋',
                        style: TextStyle(
                          color:
                              Color(0xFF6B7280),
                        ),
                      ),

                      const SizedBox(height: 4),

                      const Text(
                        'Victoria',
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 46,
                  width: 46,
                  decoration:
                      const BoxDecoration(
                    color:
                        Color(0xFFDBEAFE),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    color:
                        Color(0xFF1E3A8A),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Container(
              padding:
                  const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color:
                    const Color(0xFF1E3A8A),
                borderRadius:
                    BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Saved',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'KSh 12,500',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Keep going. Every small amount counts.',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 18),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                      ),
                      label:
                          const Text('Save Now'),
                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.white,
                        foregroundColor:
                            const Color(
                          0xFF1E3A8A,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: 'Active Goals',
                    value: '3',
                    icon:
                        Icons.flag_outlined,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: StatCard(
                    title: 'Streak',
                    value: '7 days',
                    icon:
                        Icons.local_fire_department,
                    iconColor:
                        const Color(
                      0xFFFBBF24,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            SectionTitle(
              title: 'Goal progress',
              actionText: 'View all',
              onAction: () {
                // The bottom navigation
                // handles this in the full app.
              },
            ),

            const SizedBox(height: 12),

            const ProgressCard(
              title: 'Emergency Fund',
              subtitle: 'Target: KSh 20,000',
              progress: 0.625,
              amount: 'KSh 12,500',
            ),

            const SizedBox(height: 28),

            const SectionTitle(
              title: 'Today\'s learning',
            ),

            const SizedBox(height: 12),

            Container(
              padding:
                  const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color:
                    const Color(0xFFD1FAE5),
                borderRadius:
                    BorderRadius.circular(18),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.school_outlined,
                    color:
                        Color(0xFF10B981),
                    size: 34,
                  ),

                  SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Why small savings matter',
                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Learn how small, regular contributions can build a strong saving habit.',
                          style: TextStyle(
                            color: Color(
                              0xFF6B7280,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}